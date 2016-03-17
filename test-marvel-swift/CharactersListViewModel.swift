//
//  CharactersViewModel.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharactersListViewModel: CharactersViewModel {
    
    private let api: APIClient
    private let didChange: (CharactersViewModel, NSError?) -> Void
    
    private(set) var characters = [Character]()
    private var offset = 0
    private(set) var total = 0
    
    private var isLoading = false
    
    init(api: APIClient, didChange: (CharactersViewModel, NSError?) -> Void) {
        self.api = api
        self.didChange = didChange
    }
    
    func requestNextPage() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.api.characters(self.offset) {[weak self] (result, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let this = self {
                    if let container = result?.data {
                        this.offset += container.limit
                        this.total  = container.total
                        this.characters += container.results
                        this.didChange(this, nil)
                    } else if let error = error {
                        this.didChange(this, error)
                    } else {
                        // do nothing - task cancelled
                    }
                    this.isLoading = false
                }
            })
        }
    }
    
    func canRequestNextPage() -> Bool {
        return self.characters.count < total
    }
}
