//
//  CharacterItemsViewController.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CharacterItemsViewController: UICollectionViewController {

    var items: [CharacterItemSummary]!
    let api: APIClient
    let didSelectItem: (CharacterItemSummary, [CharacterItemSummary]) -> Void
    
    let layout = UICollectionViewFlowLayout()
    
    init(items: [CharacterItemSummary], api: APIClient, didSelectItem: (CharacterItemSummary, [CharacterItemSummary]) -> Void) {
        self.items = items
        self.api = api
        self.didSelectItem = didSelectItem
        super.init(collectionViewLayout: self.layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView!.backgroundColor = UIColor.clearColor()
        self.collectionView!.showsHorizontalScrollIndicator = false
        
        self.collectionView!.registerNib(UINib(nibName: "CharacterItemCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: reuseIdentifier)
        self.layout.scrollDirection = .Horizontal
        self.layout.minimumInteritemSpacing = 10
        self.layout.itemSize = CGSizeMake(100, 187)
        self.layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.items.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CharacterItemCell
    
        let item = self.items[indexPath.row]
        cell.nameLabel.text = item.name

        if let thumbnail = item.relatedThumbnailItem?.thumbnail, let url = thumbnail.resourceURL(.PortraitMedium) {
            cell.thumbnailView.setImageWithURL(url)
        } else {
            self.api.thumbnail(item.resourceURI) {[weak item, weak cell] (result, error) -> Void in
                if let result = result, thumbnail = result.data.results.first?.thumbnail, url = thumbnail.resourceURL(.PortraitMedium) {
                    item?.relatedThumbnailItem = result.data.results.first
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        cell?.thumbnailView.setImageWithURL(url)
                    })
                }
            }
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let item = self.items[indexPath.row]
        self.didSelectItem(item, self.items)
    }

}
