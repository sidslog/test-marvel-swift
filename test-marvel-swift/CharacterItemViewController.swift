//
//  CharacterItemViewController.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterItemViewController: UIViewController {

    var itemSummary: CharacterItemSummary!
    var api: APIClient!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = itemSummary.name
        
        if let thumbnail = self.itemSummary.relatedThumbnailItem?.thumbnail, let url = thumbnail.resourceURL(.PortraitUncanny) {
            self.imageView.setImageWithURL(url)
        } else {
            self.api.thumbnail(itemSummary.resourceURI) {[weak self] (result, error) -> Void in
                if let result = result, thumbnail = result.data.results.first?.thumbnail, url = thumbnail.resourceURL(.PortraitMedium) {
                    self?.itemSummary.relatedThumbnailItem = result.data.results.first
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self?.imageView.setImageWithURL(url)
                    })
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
