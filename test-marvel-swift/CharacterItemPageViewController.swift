//
//  CharacterItemPageViewController.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit


class HitTestView: UIView {
    
    weak var viewToPassHitTest: UIView?
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        return self.viewToPassHitTest
    }
    
}

class CharacterItemPageViewController: UIViewController {

    var items: [CharacterItemSummary]!
    var selectedItem: CharacterItemSummary!
    var api: APIClient!

    @IBOutlet weak var hitTestView: HitTestView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageNumber: UILabel!
    
    private var viewControllers = [CharacterItemViewController?]()
    private var didLoadInitialPages = false
    private var page: Int = 0 {
        didSet {
            self.pageNumber.text = "\(page + 1)/\(items.count)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hitTestView.viewToPassHitTest = self.scrollView
        for i in 0..<items.count {
            viewControllers.insert(Optional.None, atIndex: i)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.didLoadInitialPages == false {
            self.scrollView.setNeedsLayout()
            self.scrollView.layoutIfNeeded()
            
            self.scrollView.contentSize = CGSizeMake(CGFloat(self.items.count) * self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)
            self.page = self.items.indexOf({$0.resourceURI == self.selectedItem!.resourceURI})!
            self.loadPage(self.page)
            self.loadPage(self.page - 1)
            self.loadPage(self.page + 1)
            let pageWidth = self.scrollView.frame.width
            self.scrollView.contentOffset = CGPointMake(pageWidth * CGFloat(page), 0)
            self.didLoadInitialPages = true
        }
    }

    private func instantiateViewControllerAtIndex(index: Int) -> CharacterItemViewController {
        let controller = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("CharacterItem") as! CharacterItemViewController

        controller.itemSummary = self.items[index]
        controller.api = self.api
        
        return controller
    }
    
    func loadPage(index: Int) {
        if index >= self.items.count || index < 0 {
            return
        }
        
        var controller: CharacterItemViewController
        switch self.viewControllers[index] {
        case .None:
            controller = self.instantiateViewControllerAtIndex(index)
            self.viewControllers[index] = controller
        case .Some(let ctrl):
            controller = ctrl
        }
        
        if index != self.page {
            controller.view.layer.opacity = 0.5
        } else {
            controller.view.layer.opacity = 1
        }
        
        if controller.view.superview == nil {
            var frame = self.scrollView.frame
            frame.origin.x = frame.width * CGFloat(index)
            frame.origin.y = 0
            controller.view.frame = frame
            self.addChildViewController(controller)
            self.scrollView.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
        }
    }

    @IBAction func onDismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension CharacterItemPageViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = self.scrollView.frame.width
        self.page = Int(floor(scrollView.contentOffset.x - pageWidth) / pageWidth) + 1
        self.loadPage(self.page - 1)
        self.loadPage(self.page)
        self.loadPage(self.page + 1)
    }
    
}

