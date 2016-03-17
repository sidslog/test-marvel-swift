//
//  ImageDownloader.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

typealias ImageCacheLoadCompletionBlock = (image: UIImage?, url: NSURL, error: NSError?) -> Void

class ImageDownloader {

    static let sharedInstance = ImageDownloader()
    
    // only in memory cache
    private let cachedImages: NSCache
    private let operationQueue: NSOperationQueue

    init() {
        self.operationQueue = NSOperationQueue()
        self.operationQueue.maxConcurrentOperationCount = 10;
        self.cachedImages = NSCache();
        self.cachedImages.countLimit = 10;
    }

    func loadImage(url: NSURL, completion: ImageCacheLoadCompletionBlock) -> ImageDownloadOperation? {
        let key = url.absoluteString
        
        if let image = self.cachedImages.objectForKey(key) as? UIImage {
            completion(image: image, url: url, error: nil)
            return nil
        }
        
        // download and decode image
        let operation = ImageDownloadOperation(url: url, completion: { (image, url, error) -> Void in
            if let image = image {
                self.cachedImages.setObject(image, forKey: key)
            }
            completion(image: image, url: url, error: error)
        })
        
        self.operationQueue.addOperation(operation)
        return operation;
    }
    
}