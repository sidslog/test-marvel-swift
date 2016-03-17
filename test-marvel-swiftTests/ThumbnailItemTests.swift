//
//  ThumbnailItemTests.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

class ThumbnailItemTests: XCTestCase {
    
    func testDictionaryWithoutThumbnail() {
        let json = [String:AnyObject]()
        XCTAssertNotNil(ThumbnailItem(jsonDictionary:json), "empty dictionary thumbnail item")
        XCTAssertNil(ThumbnailItem(jsonDictionary:json)!.thumbnail, "empty dictionary thumbnail item")
    }
    
    func testDictionaryWithThumbnailWrongType() {
        let json = ["thumbnail":1234]
        XCTAssertNotNil(ThumbnailItem(jsonDictionary:json), "wrong thumbnail type")
        XCTAssertNil(ThumbnailItem(jsonDictionary:json)!.thumbnail, "wrong thumbnail type")
        
        let json2 = ["thumbnail":[1234]]
        XCTAssertNotNil(ThumbnailItem(jsonDictionary:json2), "wrong thumbnail type")
        XCTAssertNil(ThumbnailItem(jsonDictionary:json2)!.thumbnail, "wrong thumbnail type")
    }
    
    func testDictionaryWithThumbnailRightType() {
        let json = ["thumbnail":[:]]
        let item = ThumbnailItem(jsonDictionary:json);
        XCTAssertNotNil(item, "thumbnail must be created if there is a thumnail key with a value of type nsdictionary")
        XCTAssertNil(item!.thumbnail)
    }
    
}
