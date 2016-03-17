//
//  CharactersViewController.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharactersViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var listViewModel: CharactersListViewModel!
    var searchViewModel: CharactersSearchViewModel!
    var api: APIClient!
    
    var currentModel: CharactersViewModel! {
        didSet {
            self.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.barTintColor = UIColor(red: 12/255.0, green: 14/255.0, blue: 15/255.0, alpha: 1.0);
        searchController.searchBar.tintColor = UIColor(red: 240/255.0, green: 16/255.0, blue: 35/255.0, alpha: 1.0);
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        self.api = MarvelAPIClient(networkingManager: MarvelNetworkingManager())
        
        let modelDidChange = { [weak self] (model: CharactersViewModel, error: NSError?) -> Void in
            if let this = self {
                if let error = error {
                    this.showError(error)
                } else {
                    this.reloadData()
                }
            }
        }
        
        self.listViewModel = CharactersListViewModel(api: self.api, didChange: modelDidChange)
        self.searchViewModel = CharactersSearchViewModel(api: self.api, didChange: modelDidChange)
        self.currentModel = self.listViewModel
        
        self.currentModel.requestNextPage()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? CharacterViewController, cell = sender as? UITableViewCell, indexPath = self.tableView.indexPathForCell(cell) {
            let character = self.currentModel.characters[indexPath.row]
            controller.viewModel = CharacterViewModel(character: character)
            controller.api = self.api
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.currentModel.characters.count
        return count > 0 ? count + (self.currentModel.canRequestNextPage() ? 1 : 0) : 0;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let characters = self.currentModel.characters
        if indexPath.row < characters.count {
            if self.searchController.active {
                return 64
            } else {
                return 160
            }
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let characters = self.currentModel.characters
        if indexPath.row < characters.count {
            let character = characters[indexPath.row]
            
            if self.searchController.active {
                let cell = tableView.dequeueReusableCellWithIdentifier("CharactersSearchCell", forIndexPath: indexPath) as! CharactersSearchCell
                cell.titleLabel.text = character.name
                if let thumbnail = character.thumbnail, url = thumbnail.resourceURL(.StandardMedium)  {
                    cell.characterImageView.setImageWithURL(url)
                } else {
                    cell.characterImageView.image = nil
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("CharactersCell", forIndexPath: indexPath) as! CharactersCell
                cell.titleLabel.text = character.name
                if let thumbnail = character.thumbnail, url = thumbnail.resourceURL(.LandscapeIncredible)  {
                    cell.backgroundImageView.setImageWithURL(url)
                } else {
                    cell.backgroundImageView.image = nil
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("LoadingCell", forIndexPath: indexPath)
            self.currentModel.requestNextPage()
            return cell
        }
    }

    @IBAction func onSearch(sender: AnyObject) {
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.becomeFirstResponder()
        self.searchViewModel.searchText = ""
        self.currentModel = self.searchViewModel
    }
    
    private func reloadData() {
        self.tableView.reloadData()
    }
    
    private func showError(error: NSError) {
        
    }

}


extension CharactersViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.tableView.tableHeaderView = nil
        self.currentModel = self.listViewModel
    }

}

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.searchViewModel.searchText = searchBar.text ?? ""
    }
}