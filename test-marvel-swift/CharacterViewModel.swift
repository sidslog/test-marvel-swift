//
//  CharacterViewModel.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterSection<T> {
    let items: [T]
    
    init(t: T) {
        self.items = [t]
    }
    
    init(t: [T]) {
        self.items = t
    }
}

class CharacterItemSummaryViewModel {
    let title: String
    let items: [CharacterItemSummary]
    
    init(title: String, items: [CharacterItemSummary]) {
        self.title = title
        self.items = items
    }
}

class CharacterViewModel {

    let character: Character
    
    let infoSection: CharacterSection<Character>
    let itemsSection: CharacterSection<CharacterItemSummaryViewModel>
    let linksSection: CharacterSection<Link>
    
    init(character: Character) {
        self.character = character
        
        self.infoSection = CharacterSection(t: character)
        
        var temp = [CharacterItemSummaryViewModel]()
        if CharacterViewModel.showRowForList(character.comics) {
            temp.append(CharacterItemSummaryViewModel(title: "COMICS", items: character.comics!.items))
        }
        if CharacterViewModel.showRowForList(character.stories) {
            temp.append(CharacterItemSummaryViewModel(title: "STORIES", items: character.stories!.items))
        }
        if CharacterViewModel.showRowForList(character.events) {
            temp.append(CharacterItemSummaryViewModel(title: "EVENTS", items: character.events!.items))
        }
        if CharacterViewModel.showRowForList(character.series) {
            temp.append(CharacterItemSummaryViewModel(title: "SERIES", items: character.series!.items))
        }
        self.itemsSection = CharacterSection(t: temp)
        self.linksSection = CharacterSection(t: character.urls)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return self.infoSection.items.count
        case 1:
            return self.itemsSection.items.count
        case 2:
            return self.linksSection.items.count
        default:
            fatalError()
        }
    }
    
    private static func showRowForList(list: CharacterItemList?) -> Bool {
        if let list = list where list.items.count > 0 {
            return true
        }
        return false
    }
    
}
