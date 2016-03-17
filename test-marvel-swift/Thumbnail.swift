//
//  Thumbnail.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

enum ThumbnailVariant: String {
    case LandscapeIncredible = "landscape_incredible"
    case StandardMedium = "standard_medium"
    case StandardFantastic = "standard_fantastic"
    case PortraitMedium = "portrait_medium"
    case PortraitUncanny = "portrait_uncanny"
}

class Thumbnail: JSONObject {
    let path: String
    let ext: String
    
    required init?(jsonDictionary: NSDictionary) {
        guard let path = jsonDictionary["path"] as? String, ext = jsonDictionary["extension"] as? String else {
            self.path = ""
            self.ext = ""
            return nil
        }
        self.path = path;
        self.ext = ext;
    }
    
    func resourceURL(variant: ThumbnailVariant) -> NSURL? {
        return NSURL(string: self.path.stringByAppendingFormat("/%@.%@", variant.rawValue, self.ext))
    }

}
