//
//  CharacterViewModel.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import Foundation


protocol CharactersViewModel {
    var characters: [Character] {get}
    
    func canRequestNextPage() -> Bool
    func requestNextPage()
}