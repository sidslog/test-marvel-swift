//
//  CharactersSearchViewModel.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharactersSearchViewModel: CharactersViewModel {
    
    private let api: APIClient
    private let didChange: (CharactersViewModel, NSError?) -> Void
    
    private(set) var characters = [Character]()
    private var offset = 0
    private var total = 0
    
    var searchText = "" {
        didSet {
            self.clearData()
            self.requestByName()
        }
    }
    
    private var isLoading = true
    
    init(api: APIClient, didChange: (CharactersViewModel, NSError?) -> Void) {
        self.api = api
        self.didChange = didChange
    }
    
    func requestByName() {
        self.api.cancelSearchRequests()
        self.isLoading = false
        if self.shouldMakeRequest() {
            self.requestNextPage()
        }
    }
    
    func requestNextPage() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.api.search(self.searchText, offset: self.offset) {[weak self] (result, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let this = self {
                    if let container = result?.data {
                        this.finishWithContainer(container)
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
    
    private func finishWithContainer(container : DataContainer<Character>) {
        self.offset += container.limit
        self.total  = container.total
        self.characters += container.results
        self.didChange(self, nil)
    }
    
    private func clearData() {
        if self.characters.count != 0 || self.offset != 0 || self.total != 0 {
            self.characters.removeAll()
            self.offset = 0
            self.total = 0
            self.didChange(self, nil)
        }
    }
    
    private func shouldMakeRequest() -> Bool {
        return self.searchText.characters.count > 1
    }

}
