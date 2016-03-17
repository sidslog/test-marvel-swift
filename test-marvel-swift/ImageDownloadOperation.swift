//
//  ImageDownloadOperation.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadOperation: NSOperation {
    
    let url: NSURL
    let completion: ImageCacheLoadCompletionBlock
    private var task: NSURLSessionDataTask?
    
    private let semaphore = dispatch_semaphore_create(0)
    
    init(url: NSURL, completion: ImageCacheLoadCompletionBlock) {
        self.url = url
        self.completion = completion
    }
    
    override func main() {
        self.task = NSURLSession.sharedSession().dataTaskWithURL(self.url) { (data, response, error) -> Void in
            if let data = data {
                if !self.cancelled {
                    let image = self.decodeImage(data)
                    let completion = self.completion
                    let url = self.url
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(image: image, url: url, error: error)
                    })
                }
            }
            dispatch_semaphore_signal(self.semaphore)
        }
        self.task?.resume()
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
    }
    
    override func cancel() {
        super.cancel()
        if let task = self.task {
            task.cancel()
        }
    }
    
    private func decodeImage(data: NSData) -> UIImage? {
        if let image = UIImage(data: data) {
            image.inflate()
            return image
        } 
        return nil
    }
    
}
