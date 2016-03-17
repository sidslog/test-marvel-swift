//
//  ComicSummary.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterItemSummary: JSONObject {
    let resourceURI: String
    let name: String
    
    var relatedThumbnailItem: ThumbnailItem?
    
    required init?(jsonDictionary: NSDictionary) {
        guard let name = jsonDictionary["name"] as? String, let resourceURI = jsonDictionary["resourceURI"] as? String else {
            self.resourceURI = ""
            self.name = ""
            return nil
        }
        self.name = name;
        self.resourceURI = resourceURI;
    }
    
}
