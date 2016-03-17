//
//  UIImageUtils.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

extension UIImage {
    
    private struct AssociatedKeys {
        static var InflatedKey = "UIImage.Inflated"
    }
    
    public var inflated: Bool {
        get {
            if let inflated = objc_getAssociatedObject(self, &AssociatedKeys.InflatedKey) as? Bool {
                return inflated
            } else {
                return false
            }
        }
        set(inflated) {
            objc_setAssociatedObject(self, &AssociatedKeys.InflatedKey, inflated, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func inflate() {
        guard !inflated else { return }
        
        inflated = true
        CGDataProviderCopyData(CGImageGetDataProvider(CGImage))
    }
    
}
