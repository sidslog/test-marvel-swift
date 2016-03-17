//
//  Character.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class Character: ThumbnailItem {

    let name: String
    let resourceURI: String
    let descr: String
    
    let comics: CharacterItemList?
    let stories: CharacterItemList?
    let events: CharacterItemList?
    let series: CharacterItemList?
    
    let urls: [Link]
    
    required init?(jsonDictionary: NSDictionary) {
        guard let name = jsonDictionary["name"] as? String,
            let resourceURI = jsonDictionary["resourceURI"] as? String else {
                self.name = ""
                self.resourceURI = ""
                self.comics = nil
                self.stories = nil
                self.events = nil
                self.series = nil
                self.descr = ""
                self.urls = []
                super.init(jsonDictionary: jsonDictionary)
                return nil
        }
        
        self.name = name
        self.resourceURI = resourceURI
        
        if let descr = jsonDictionary["description"] as? String {
            self.descr = descr
        } else {
            self.descr = ""
        }
        
        if let comics = jsonDictionary["comics"] as? NSDictionary {
            self.comics = CharacterItemList(jsonDictionary: comics)
        } else {
            self.comics = nil
        }
        
        if let stories = jsonDictionary["stories"] as? NSDictionary {
            self.stories = CharacterItemList(jsonDictionary: stories)
        } else {
            self.stories = nil
        }
        
        if let events = jsonDictionary["events"] as? NSDictionary {
            self.events = CharacterItemList(jsonDictionary: events)
        } else {
            self.events = nil
        }
        
        if let series = jsonDictionary["series"] as? NSDictionary {
            self.series = CharacterItemList(jsonDictionary: series)
        } else {
            self.series = nil
        }
        
        if let urls = jsonDictionary["urls"] as? NSArray {
            var temp = [Link]()
            for url in urls {
                if let dict = url as? NSDictionary {
                    if let urlObject = Link(jsonDictionary: dict) {
                        temp.append(urlObject)
                    }
                }
            }
            self.urls = temp
        } else {
            self.urls = []
        }
        
        super.init(jsonDictionary: jsonDictionary)
    }
}