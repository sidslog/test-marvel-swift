//
//  CharacterViewController.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterViewController: UITableViewController {

    var viewModel: CharacterViewModel!
    var api: APIClient!
    
    private var selectedItem: CharacterItemSummary?
    private var selectedItems: [CharacterItemSummary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "CharacterLinksHeader", bundle: NSBundle.mainBundle()), forHeaderFooterViewReuseIdentifier: "CharacterLinksHeader")
        
        if let thumbnail = viewModel.character.thumbnail, url = thumbnail.resourceURL(.PortraitMedium) {
            ImageDownloader.sharedInstance.loadImage(url, completion: {[weak self] (image, url, error) -> Void in
                let imageView = UIImageView(image: image)
                self?.tableView.backgroundView = imageView
                let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
                visualEffectView.frame = imageView.bounds
                imageView.addSubview(visualEffectView)
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        AppearanceHelper.makeNavigationBarTransparent(self.navigationController!.navigationBar)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        AppearanceHelper.makeNavigationBarOpaque(self.navigationController!.navigationBar)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let item = self.selectedItem, items = self.selectedItems, nav = segue.destinationViewController as? UINavigationController, controller = nav.topViewController as? CharacterItemPageViewController, identifier = segue.identifier where identifier == "ItemSummaryList" {
            controller.items = items
            controller.selectedItem = item
            controller.api = self.api
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("CharacterInfoCell", forIndexPath: indexPath) as! CharacterInfoCell
            let character = self.viewModel.infoSection.items[indexPath.row]
            cell.configure(character)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("CharacterItemsCell", forIndexPath: indexPath) as! CharacterItemsCell
            let list = self.viewModel.itemsSection.items[indexPath.row]
            cell.configure(list, parent: self, api: self.api, didSelectItem: {[weak self] (item, items) in
                self?.presentItemSummary(item, items: items)
                })
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("CharacterLinkCell", forIndexPath: indexPath) as! CharacterLinkCell
            let link = self.viewModel.linksSection.items[indexPath.row]
            cell.configure(link)
            return cell
        default:
            fatalError()
        }
    }

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 450
        case 1:
            return 230
        case 2:
            return 44
        default:
            fatalError()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return 230
        case 2:
            return 44
        default:
            fatalError()
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 30
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            return tableView.dequeueReusableHeaderFooterViewWithIdentifier("CharacterLinksHeader")
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            let link = self.viewModel.linksSection.items[indexPath.row]
            UIApplication.sharedApplication().openURL(link.url)
        }
    }
    
    private func presentItemSummary(item: CharacterItemSummary, items: [CharacterItemSummary]) {
        self.selectedItem = item
        self.selectedItems = items
        self.performSegueWithIdentifier("ItemSummaryList", sender: nil)
    }

    @IBAction func onBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
