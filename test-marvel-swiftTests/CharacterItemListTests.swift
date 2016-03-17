//
//  CharacterItemListTests.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

class CharacterItemListTests: XCTestCase {
    

    func testDictionaryNoItems() {
        let emptyJSON = [:]
        XCTAssertNil(CharacterItemList(jsonDictionary: emptyJSON), "mustn't create if there are no items")
    }
    
    func testDictionaryWrongItemsType() {
        let json = ["items":123]
        XCTAssertNil(CharacterItemList(jsonDictionary: json), "mustn't create if items has wrong type")
        let json2 = ["items":["": ""]]
        XCTAssertNil(CharacterItemList(jsonDictionary: json2), "mustn't create if items has wrong type")
    }
    
    func testDictionaryRightItemsType() {
        let json = ["items":[]]
        let list = CharacterItemList(jsonDictionary: json)
        XCTAssertNotNil(list)
        XCTAssertNotNil(list!.items)
        XCTAssertEqual(list!.items.count, 0)
    }

    func testDictionaryRightItemsTypeNoValidItems() {
        let json = ["items":[1,2,3]]
        let list = CharacterItemList(jsonDictionary: json)
        XCTAssertNotNil(list)
        XCTAssertNotNil(list!.items)
        XCTAssertEqual(list!.items.count, 0)
    }
    
    func testDictionaryRightItemsTypeHasValidItems() {
        let json = ["items":[["resourceURI":"1234", "name": "123"]]]
        let list = CharacterItemList(jsonDictionary: json)
        XCTAssertNotNil(list)
        XCTAssertNotNil(list!.items)
        XCTAssertEqual(list!.items.count, 1)
    }
    func testDictionaryRightItemsTypeHasValidAndInvalidItems() {
        let json = ["items":[["resourceURI":"1234", "name": "123"], 2]]
        let list = CharacterItemList(jsonDictionary: json)
        XCTAssertNotNil(list)
        XCTAssertNotNil(list!.items)
        XCTAssertEqual(list!.items.count, 1)
    }
    
}
