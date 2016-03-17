//
//  ComicList.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterItemList: JSONObject {
    let items: [CharacterItemSummary]
    
    required init?(jsonDictionary: NSDictionary) {
        guard let list = jsonDictionary["items"] as? NSArray else {
            self.items = [];
            return nil
        }
        var items = [CharacterItemSummary]()
        for obj in list {
            if let dict = obj as? NSDictionary, let item = CharacterItemSummary(jsonDictionary: dict) {
                items.append(item)
            }
        }
        self.items = items
    }
    
}
