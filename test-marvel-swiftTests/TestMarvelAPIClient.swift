//
//  TestMarvelAPIClient.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 3/17/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import XCTest
@testable import test_marvel_swift




class NetworkingManagerCompletionMock: NetworkingManager {
    
    var returnError = false
    
    func get<T:JSONObject>(resource: String, parameters: [String: AnyObject], completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask? {
        if returnError {
            completion(nil, NSError(domain: "123", code: 6, userInfo: nil))
        } else {
            completion(T(jsonDictionary: createWrapperJSON()), nil)
        }
        return nil
    }
    
    func getResource<T:JSONObject>(resourceURLString: String, completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask? {
        return nil
    }
    
    func cancelTask(task: NSURLSessionDataTask) {
        
    }
    
    func createWrapperJSON() -> [String: AnyObject] {
        var results = [[String: AnyObject]]()
        for i in 0..<10 {
            let characterJson = ["resourceURI":"\(i)", "name": "\(i)"]
            results.append(characterJson)
        }
        
        let json = ["offset": 0, "limit": 20, "total": 1000, "results": results]
        
        let wrapper = ["data":json]
        return wrapper
    }
}


class NetworkingManagerMock: NetworkingManager {
    
    var resultResource: String?
    var resultParameters: [String: AnyObject]?
    var resultResourceURLString: String?
    
    func get<T:JSONObject>(resource: String, parameters: [String: AnyObject], completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask? {
        self.resultResource = resource
        self.resultParameters = parameters
        return nil
    }
    
    func getResource<T:JSONObject>(resourceURLString: String, completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask? {
        self.resultResourceURLString = resourceURLString
        return nil
    }
    
    func cancelTask(task: NSURLSessionDataTask) {
        
    }

}

class TestMarvelAPIClient: XCTestCase {
    
    var completionManager: NetworkingManagerCompletionMock!
    var networkingManager: NetworkingManagerMock!
    var api: MarvelAPIClient!
    var completionApi: MarvelAPIClient!
    
    override func setUp() {
        super.setUp()
        self.networkingManager = NetworkingManagerMock()
        self.completionManager = NetworkingManagerCompletionMock()
        self.api = MarvelAPIClient(networkingManager: self.networkingManager)
        self.completionApi = MarvelAPIClient(networkingManager: self.completionManager)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacters() {
        api.characters(14) { (result, error) -> Void in
            
        }
        XCTAssertEqual(self.networkingManager.resultResource, "v1/public/characters")
        XCTAssertEqual(self.networkingManager.resultParameters!["offset"] as? Int, 14)
    }
    
    func testThumbnail() {
        api.thumbnail("uri string") { (result, error) -> Void in
            
        }
        XCTAssertEqual(self.networkingManager.resultResourceURLString, "uri string")
    }
    
    func testSearch() {
        api.search("name", offset: 1, completion: { (result, error) -> Void in
            
        })
        
        XCTAssertEqual(self.networkingManager.resultResource, "v1/public/characters")
        XCTAssertEqual(self.networkingManager.resultParameters!["nameStartsWith"] as? String, "name")
        XCTAssertEqual(self.networkingManager.resultParameters!["offset"] as? Int, 1)
    }
    
    func testCharactersCompletionPass() {
        self.completionManager.returnError = false
        self.completionApi.characters(0) { (result, error) -> Void in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        }
    }
    
    func testCharactersCompletionError() {
        self.completionManager.returnError = true
        self.completionApi.characters(0) { (result, error) -> Void in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
        }
    }
    
    
}
