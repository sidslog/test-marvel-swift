//
//  DataContainerTests.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

class EmptyJSONObject: JSONObject {
    required init?(jsonDictionary: NSDictionary) {
    }
}

class DataContainerTests: XCTestCase {
    
    func testDictionaryWithoutRequiredFields() {
        let requiredFields = ["offset", "limit", "total", "results"];
        for requieredField in requiredFields {
            var json = [String:AnyObject]()
            for field in requiredFields.filter( {$0 != requieredField } ) {
                json[field] = field == "results" ? [] : 123
                XCTAssertNil(DataContainer<EmptyJSONObject>(jsonDictionary: json), "not all required fields are in the dictionary")
            }
        }
    }
    
    func testDictionaryWithRequiredFields() {
        let requiredFields = ["offset", "limit", "total", "results"];
        var json = [String:AnyObject]()
        for field in requiredFields {
            json[field] = field == "results" ? [] : 123
        }
        XCTAssertNotNil(DataContainer<EmptyJSONObject>(jsonDictionary: json), "all required fields are in the dictionary")
    }
    
    func testDictionaryHasNotEmptyResults() {
        let requiredFields = ["offset", "limit", "total", "results"];
        var json = [String:AnyObject]()
        for field in requiredFields {
            json[field] = field == "results" ? [[:]] : 123
        }
        let container = DataContainer<EmptyJSONObject>(jsonDictionary: json)
        XCTAssertNotNil(container, "all required fields are in the dictionary")
        XCTAssertEqual(container!.results.count, 1)
    }
    
}
