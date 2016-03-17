//
//  Link.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 17/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

enum LinkType: String {
    case Detail = "detail"
    case ComicLink = "comiclink"
    case Wiki = "wiki"
    
    var name: String {
        switch self {
        case .Detail:
            return "Detail"
        case .ComicLink:
            return "ComicLink"
        case .Wiki:
            return "Wiki"
        }
    }
    
}

class Link: JSONObject {

    let type: LinkType
    let url: NSURL
    
    required init?(jsonDictionary: NSDictionary) {
        guard let type = jsonDictionary["type"] as? String, typeEnum = LinkType(rawValue: type), urlString = jsonDictionary["url"] as? String, url = NSURL(string: urlString) else {
            self.type = .Detail
            self.url = NSBundle.mainBundle().bundleURL
            return nil
        }
        
        self.type = typeEnum
        self.url = url
    }
    
}
