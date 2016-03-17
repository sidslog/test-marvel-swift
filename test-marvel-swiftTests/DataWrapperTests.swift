//
//  DataWrapperTests.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

class CheckJSONObject: JSONObject {
    required init?(jsonDictionary: NSDictionary) {
        guard let _ = jsonDictionary["exists"] as? Bool else {
            return nil
        }
    }
}


class DataWrapperTests: XCTestCase {
    
    func testDictionaryWithoutData() {
        let json = [String:AnyObject]()
        XCTAssertNil(DataWrapper<CheckJSONObject>(jsonDictionary:json), "empty dictionary")
    }
    
    func testDictionaryWithDataWrongType() {
        let json = ["data":1234]
        XCTAssertNil(DataWrapper<CheckJSONObject>(jsonDictionary:json), "wrong data type")
    }
    
    func testDictionaryWithDataWrongSchema() {
        let json = ["data":["limit": 4]]
        XCTAssertNil(DataWrapper<CheckJSONObject>(jsonDictionary:json), "wrong container type")
    }
    
    func testDictionaryWithDataRightType() {
        
        let requiredFields = ["offset", "limit", "total", "results"];
        var json = [String:AnyObject]()
        for field in requiredFields {
            json[field] = field == "results" ? [] : 123
        }

        let wrapper = ["data":json]
        let wrapperObject = DataWrapper<CheckJSONObject>(jsonDictionary:wrapper)
        XCTAssertNotNil(wrapperObject, "right container type")
    }
    
}
