//
//  CharacterDataWrapper.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class DataWrapper<T: JSONObject>: JSONObject {
    
    let data: DataContainer<T>
    
    required init?(jsonDictionary: NSDictionary) {
        guard let container = jsonDictionary["data"] as? NSDictionary else {
            self.data = DataContainer()
            return nil
        }
        
        if let data = DataContainer<T>(jsonDictionary: container) {
            self.data = data
        } else {
            self.data = DataContainer()
            return nil
        }
    }
}
