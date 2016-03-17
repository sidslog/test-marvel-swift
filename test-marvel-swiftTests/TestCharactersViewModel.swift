//
//  TestCharactersViewModel.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

func createWrapper(offset: Int, pageSize: Int, total: Int) -> DataWrapper<test_marvel_swift.Character> {
    var results = [[String: AnyObject]]()
    for i in 0..<pageSize {
        let characterJson = ["resourceURI":"\(i)", "name": "\(i)"]
        results.append(characterJson)
    }

    let json = ["offset": offset, "limit": 20, "total": total, "results": results]
    
    let wrapper = ["data":json]
    return DataWrapper<test_marvel_swift.Character>(jsonDictionary:wrapper)!
}


class CharactersViewModelMockApi: APIClient {
    
    var predefinedOffset = 0
    var predefinedPageSize = 10
    var predefinedTotalCount = 1000
    
    
    func characters(offset: Int, completion: (result: DataWrapper<test_marvel_swift.Character>?, error: NSError?) -> Void) {
        completion(result: createWrapper(self.predefinedOffset, pageSize: self.predefinedPageSize, total: self.predefinedTotalCount), error: nil)
    }
    
    func thumbnail(resourceURIString: String, completion: (result: DataWrapper<ThumbnailItem>?, error: NSError?) -> Void) {
        
    }
    
    func search(nameStartsWith: String, offset: Int, completion: (result: DataWrapper<test_marvel_swift.Character>?, error: NSError?) -> Void) {
        
    }
    
    func cancelSearchRequests() {
        
    }
    
}

class TestCharactersListViewModel: XCTestCase {
    
    var callCount = 0
    
    override func setUp() {
        super.setUp()
        self.callCount = 0
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFirstCall() {
        let api = CharactersViewModelMockApi()
        let viewModel = CharactersListViewModel(api: api) {(model, error) -> Void in
            XCTAssertEqual(model.characters.count, 10)
        }
        viewModel.requestNextPage();
    }
    
    func testSecondCall() {
        let api = CharactersViewModelMockApi()
        let viewModel = CharactersListViewModel(api: api) {(model, error) -> Void in
            if self.callCount == 2 {
                XCTAssertEqual(model.characters.count, 20)
            }
        }
        viewModel.requestNextPage();
        callCount += 1
        viewModel.requestNextPage();
    }
    
}
