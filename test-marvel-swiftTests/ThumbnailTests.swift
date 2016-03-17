//
//  ThumbnailTests.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

class ThumbnailTests: XCTestCase {
    
    func testDictionaryWithoutPath() {
        let json = [String:AnyObject]()
        XCTAssertNil(Thumbnail(jsonDictionary:json), "empty dictionary thumbnail")
    }
    
    func testDictionaryWithWrongPathType() {
        let json = ["path":1234]
        XCTAssertNil(Thumbnail(jsonDictionary:json), "wrong path type")
    }
    
    func testDictionaryWithRightPathAndNoExtensionType() {
        let json = ["path":"1234"]
        XCTAssertNil(Thumbnail(jsonDictionary:json), "no extension")
    }
    
    func testDictionaryWithRightPathType() {
        let json = ["path":"1234", "extension": "1234"]
        let thumbnail = Thumbnail(jsonDictionary: json)
        XCTAssertNotNil(thumbnail, "thumbnial must exist")
        XCTAssertEqual("1234", thumbnail?.path, "path == 1234")
    }
    
}
