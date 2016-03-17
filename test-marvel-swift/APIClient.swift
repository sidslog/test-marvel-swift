//
//  APIClient.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import Foundation

protocol APIClient {
    
    func characters(offset: Int, completion: (result: DataWrapper<Character>?, error: NSError?) -> Void)
    func thumbnail(resourceURIString: String, completion: (result: DataWrapper<ThumbnailItem>?, error: NSError?) -> Void)

    func search(nameStartsWith: String, offset: Int, completion: (result: DataWrapper<Character>?, error: NSError?) -> Void)
    func cancelSearchRequests()
    
}