//
//  ThumbnailItem.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class ThumbnailItem: JSONObject {
    let thumbnail: Thumbnail?

    required init?(jsonDictionary: NSDictionary) {
        if let thumbnailDict = jsonDictionary["thumbnail"] as? NSDictionary {
            self.thumbnail = Thumbnail(jsonDictionary: thumbnailDict)
        } else {
            self.thumbnail = nil
        }
    }
}
