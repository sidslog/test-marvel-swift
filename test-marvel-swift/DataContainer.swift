//
//  CharacterDataContainer.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class DataContainer<T: JSONObject>: JSONObject {
    let offset: Int
    let limit: Int
    let total: Int
    let results: [T]
    
    init() {
        self.offset = 0
        self.limit = 0
        self.total = 0
        self.results = []
    }
    
    required init?(jsonDictionary: NSDictionary) {
        guard let offset = jsonDictionary["offset"] as? NSNumber,
            let limit = jsonDictionary["limit"] as? NSNumber,
            let total = jsonDictionary["total"] as? NSNumber,
            let results = jsonDictionary["results"] as? NSArray else {
                self.offset = 0
                self.limit = 0
                self.total = 0
                self.results = []
                return nil
        }
        
        self.offset = offset.integerValue
        self.limit = limit.integerValue
        self.total = total.integerValue
        
        var temp = [T]()
        
        for obj in results {
            if let dict = obj as? NSDictionary {
                if let character = T(jsonDictionary: dict) {
                    temp.append(character)
                }
            }
        }
        
        self.results = temp
    }
    
}
