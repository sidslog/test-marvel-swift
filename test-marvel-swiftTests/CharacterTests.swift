//
//  CharacterTests.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 15/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift

class CharacterTests: XCTestCase {
    
    func testDictionaryWithoutNameOrResourceURI() {
        let emptyJSON = [:]
        XCTAssertNil(Character(jsonDictionary: emptyJSON), "mustn't create if name or resource uri is nil")

        let noName = ["resourceURI":"123"]
        XCTAssertNil(Character(jsonDictionary: noName), "mustn't create if name or resource uri is nil")

        let noURI = ["name":"123"]
        XCTAssertNil(Character(jsonDictionary: noURI), "mustn't create if name or resource uri is nil")
    }
    
    func testDictionaryWithNameOrResourceURIWrongType() {
        let json = ["resourceURI":123, "name": 234]
        XCTAssertNil(Character(jsonDictionary: json), "mustn't create if name or resource uri type is not a string")
        let json1 = ["resourceURI":"123", "name": 234]
        XCTAssertNil(Character(jsonDictionary: json1), "mustn't create if name or resource uri type is not a string")
        let json2 = ["resourceURI":123, "name": "234"]
        XCTAssertNil(Character(jsonDictionary: json2), "mustn't create if name or resource uri type is not a string")
        
    }
    
    func testDictionaryWithNameOrResourceURIRightType() {
        let json = ["resourceURI":"123", "name": "234"]
        let character = Character(jsonDictionary: json)
        XCTAssertNotNil(character, "must create if name or resource uri type is string")
        XCTAssertNotNil(character!.name, "must create if name or resource uri type is string")
        XCTAssertNotNil(character!.resourceURI, "must create if name or resource uri type is string")
        XCTAssertEqual(character!.name, "234")
        XCTAssertEqual(character!.resourceURI, "123")
    }
    
    func testDescription() {
        let json = ["resourceURI":"123", "name": "234"]
        let character = Character(jsonDictionary: json)
        XCTAssertNotNil(character, "must create if name or resource uri type is string")
        XCTAssertNotNil(character!.descr)
        XCTAssertEqual(character!.descr, "")
        let json2 = ["resourceURI":"123", "name": "234", "description": "d"]
        let character2 = Character(jsonDictionary: json2)
        XCTAssertNotNil(character2, "must create if name or resource uri type is string")
        XCTAssertNotNil(character2!.descr)
        XCTAssertEqual(character2!.descr, "d")
    }
    
    func testThumbnail() {
        let json = ["resourceURI":"123", "name": "234"]
        let character = Character(jsonDictionary: json)
        XCTAssertNotNil(character, "must create if name or resource uri type is string")
        XCTAssertNil(character!.thumbnail, "must create if name or resource uri type is string with thumbnail = nil")
        let json2 = ["resourceURI":"123", "name": "234", "thumbnail": ["path": "567", "extension": "abc"]]
        let character2 = Character(jsonDictionary: json2)
        XCTAssertNotNil(character2, "must create if name or resource uri type is string")
        XCTAssertNotNil(character2!.thumbnail, "must create if name or resource uri type is string with thumbnail != nil")
    }
    
    func testComics() {
        let json = ["resourceURI":"123", "name": "234"]
        let character = Character(jsonDictionary: json)
        XCTAssertNotNil(character, "must create if name or resource uri type is string")
        XCTAssertNil(character!.comics, "must create if name or resource uri type is string with comics = nil")
        let json2 = ["resourceURI":"123", "name": "234", "comics": ["items": []]]
        let character2 = Character(jsonDictionary: json2)
        XCTAssertNotNil(character2, "must create if name or resource uri type is string")
        XCTAssertNotNil(character2!.comics, "must create if name or resource uri type is string with comics != nil")
    }
    
    func testStories() {
        let json = ["resourceURI":"123", "name": "234"]
        let character = Character(jsonDictionary: json)
        XCTAssertNotNil(character, "must create if name or resource uri type is string")
        XCTAssertNil(character!.stories, "must create if name or resource uri type is string with stories = nil")
        let json2 = ["resourceURI":"123", "name": "234", "stories": ["items": []]]
        let character2 = Character(jsonDictionary: json2)
        XCTAssertNotNil(character2, "must create if name or resource uri type is string")
        XCTAssertNotNil(character2!.stories, "must create if name or resource uri type is string with stories != nil")
    }

    func testEvents() {
        let json = ["resourceURI":"123", "name": "234"]
        let character = Character(jsonDictionary: json)
        XCTAssertNotNil(character, "must create if name or resource uri type is string")
        XCTAssertNil(character!.events, "must create if name or resource uri type is string with events = nil")
        let json2 = ["resourceURI":"123", "name": "234", "events": ["items": []]]
        let character2 = Character(jsonDictionary: json2)
        XCTAssertNotNil(character2, "must create if name or resource uri type is string")
        XCTAssertNotNil(character2!.events, "must create if name or resource uri type is string with events != nil")
    }

    func testSeries() {
        let json = ["resourceURI":"123", "name": "234"]
        let character = Character(jsonDictionary: json)
        XCTAssertNotNil(character, "must create if name or resource uri type is string")
        XCTAssertNil(character!.series, "must create if name or resource uri type is string with series = nil")
        let json2 = ["resourceURI":"123", "name": "234", "series": ["items": []]]
        let character2 = Character(jsonDictionary: json2)
        XCTAssertNotNil(character2, "must create if name or resource uri type is string")
        XCTAssertNotNil(character2!.series, "must create if name or resource uri type is string with series != nil")
    }
}
