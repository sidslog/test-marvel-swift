//
//  UIImageViewUtils.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit


extension UIImageView {
    
    private struct AssociatedKeys {
        static var DownloadURL = "UIImageView.DownloadURL"
    }
    
    private var downloadURL: NSURL? {
        get {
            if let url = objc_getAssociatedObject(self, &AssociatedKeys.DownloadURL) as? NSURL {
                return url
            } else {
                return nil
            }
        }
        set(url) {
            objc_setAssociatedObject(self, &AssociatedKeys.DownloadURL, url, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }


    func setImageWithURL(url: NSURL) {
        self.downloadURL = url
        ImageDownloader.sharedInstance.loadImage(url, completion:  {[weak self] (image, url, error) -> Void in
            if let this = self, let downloadURL = this.downloadURL where downloadURL == url {
                this.image = image
            }
        })
    }

    private func extendParameters(parameters: [String:AnyObject], ts: String) -> [String: AnyObject] {
        var result = parameters;
        result["ts"] = ts;
        result["apikey"] = PUBLIC_KEY
        result["hash"] = prepareAuthQueryString(ts)
        return result
    }
    
    private func prepareAuthQueryString(ts: String) -> String {
        return (ts + PRIVATE_KEY + PUBLIC_KEY).md5
    }
    
}