//
//  MarvelAPIClient.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class MarvelAPIClient {

    let networkingManager: NetworkingManager
    
    let searchTasks = NSHashTable.weakObjectsHashTable()
    
    init(networkingManager: NetworkingManager) {
        self.networkingManager = networkingManager
    }
}

extension MarvelAPIClient: APIClient {
    
    func characters(offset: Int, completion: (result: DataWrapper<Character>?, error: NSError?) -> Void) {
        var parameters = [String: AnyObject]();
        parameters["offset"] = offset
        self.networkingManager.get("v1/public/characters", parameters: parameters, completion: completion)
    }
    
    
    func thumbnail(resourceURIString: String, completion: (result: DataWrapper<ThumbnailItem>?, error: NSError?) -> Void) {
        self.networkingManager.getResource(resourceURIString, completion: completion)
    }

    func search(nameStartsWith: String, offset: Int, completion: (result: DataWrapper<Character>?, error: NSError?) -> Void) {
        var parameters = [String: AnyObject]();
        parameters["offset"] = offset
        parameters["nameStartsWith"] = nameStartsWith;
        if let task = self.networkingManager.get("v1/public/characters", parameters: parameters, completion: completion) {
            searchTasks.addObject(task)
        }
    }
    
    func cancelSearchRequests() {
        for task in searchTasks.allObjects as! [NSURLSessionDataTask] {
            task.cancel()
        }
    }

}
