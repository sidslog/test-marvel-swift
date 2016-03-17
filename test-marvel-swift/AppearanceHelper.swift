//
//  AppearanceHelper.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 3/17/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class AppearanceHelper: NSObject {

    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 12/255.0, green: 14/255.0, blue: 15/255.0, alpha: 1.0)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    static func makeNavigationBarTransparent(navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = true
    }
    
    static func makeNavigationBarOpaque(navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        navigationBar.translucent = true
        navigationBar.barTintColor = UIColor(red: 12/255.0, green: 14/255.0, blue: 15/255.0, alpha: 1.0)
    }
    
}
