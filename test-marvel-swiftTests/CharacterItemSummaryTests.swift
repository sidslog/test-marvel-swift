//
//  CharacterItemSummaryTests.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

class CharacterItemSummaryTests: XCTestCase {
    
    func testDictionaryWithoutNameOrResourceURI() {
        let noNameAndURI = [:]
        XCTAssertNil(CharacterItemSummary(jsonDictionary: noNameAndURI), "mustn't create if name or uri is nil")
        let nameAndNoURI = ["name":"123"]
        XCTAssertNil(CharacterItemSummary(jsonDictionary: nameAndNoURI), "mustn't create if uri is nil")
        let uriAndNoName = ["resourceURI":"123"]
        XCTAssertNil(CharacterItemSummary(jsonDictionary: uriAndNoName), "mustn't create if name is nil")
    }

    func testDictionaryNameOrResourceURIWrongType() {
        let nameWrongType = ["name":123, "resourceURI":"123"]
        XCTAssertNil(CharacterItemSummary(jsonDictionary: nameWrongType), "mustn't create if name is not a string")
        let uriAndNoName = ["resourceURI":123, "name": "123"]
        XCTAssertNil(CharacterItemSummary(jsonDictionary: uriAndNoName), "mustn't create if uri is not a string")
    }

    func testDictionaryNameAndResourceURIRightType() {
        let uriAndNoName = ["resourceURI":"1234", "name": "123"]
        let itemSummary = CharacterItemSummary(jsonDictionary: uriAndNoName)
        XCTAssertNotNil(itemSummary)
        XCTAssertNotNil(itemSummary?.resourceURI)
        XCTAssertNotNil(itemSummary?.name)
        XCTAssertEqual(itemSummary!.resourceURI, "1234")
        XCTAssertEqual(itemSummary!.name, "123")
    }
    
}
