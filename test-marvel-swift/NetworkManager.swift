//
//  NetworkManager.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import Foundation

protocol NetworkingManager {
    func get<T:JSONObject>(resource: String, parameters: [String: AnyObject], completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask?
    func getResource<T:JSONObject>(resourceURLString: String, completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask?
    func cancelTask(task: NSURLSessionDataTask)
}
