//
//  CharacterItemsCell.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterItemsCell: UITableViewCell {

    weak var controller: UICollectionViewController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionContainer: UIView!
    
    func configure(data: CharacterItemSummaryViewModel, parent: UIViewController, api: APIClient, didSelectItem: (CharacterItemSummary, [CharacterItemSummary]) -> Void) {
        self.nameLabel.text = data.title
        
        let controller = CharacterItemsViewController(items: data.items, api: api, didSelectItem: didSelectItem)
        
        self.collectionContainer.addSubview(controller.view)
        CharacterItemsCell.fill(self.collectionContainer, child: controller.view)
        parent.addChildViewController(controller)
        controller.didMoveToParentViewController(parent)
        
        self.controller = controller
    }
    
    func releaseController() {
        if let controller = self.controller {
            controller.willMoveToParentViewController(nil)
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
    }
    
    override func prepareForReuse() {
        self.releaseController()
    }
    
    deinit {
        self.releaseController()
    }
    
    class func fill(parent: UIView, child: UIView) {
        let subview = child;
        subview.translatesAutoresizingMaskIntoConstraints = false;
        let dict = ["subview":subview] as [String : AnyObject];
        parent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: dict));
        parent.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: dict));
    }

}
