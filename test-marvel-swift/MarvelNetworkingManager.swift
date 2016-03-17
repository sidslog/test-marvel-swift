//
//  MarvelNetworkingManager.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 14/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import Foundation

let PUBLIC_KEY = "d57ebe1917e261ef038183e89370b5a6"
let PRIVATE_KEY = ""
let BASE_URL = NSURL(string: "http://gateway.marvel.com/")!

class MarvelNetworkingManager: NSObject, NetworkingManager {

    func get<T:JSONObject>(resource: String, parameters: [String: AnyObject], completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask? {
        let url = self.urlForResource(BASE_URL, resource: resource, parameters: parameters)
        return self.get(url, completion: completion)
    }
    
    func getResource<T:JSONObject>(resourceURLString: String, completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask? {
        if let resourceURL = NSURL(string: resourceURLString) {
            let url = self.urlForResource(resourceURL)
            return self.get(url, completion: completion)
        } else {
            completion(nil, nil)
            return nil
        }
    }
    
    func cancelTask(task: NSURLSessionDataTask) {
        task.cancel()
    }
    
    private func get<T:JSONObject>(url: NSURL, completion: (T?,NSError?) -> Void) -> NSURLSessionDataTask {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let data = data {
                do {
                    if let object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? NSDictionary, let resultObject = T(jsonDictionary: object) {
                        completion(resultObject, nil)
                    }
                } catch _ {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
    
    func urlForResource(baseURL: NSURL, resource: String? = nil, parameters: [String:AnyObject]? = nil) -> NSURL {
        var queryString = resource ?? ""
        let parametersWithAuth = self.extendParameters(parameters ?? [String:AnyObject](), ts: "\(NSDate().timeIntervalSince1970)")
        for (index, param) in parametersWithAuth.enumerate() {
            if let key = param.0.escapedString, let value = "\(param.1)".escapedString {
                if index == 0 {
                    queryString += "?"
                } else {
                    queryString += "&"
                }
                queryString += key
                queryString += "=\(value)"
            }
        }
        return NSURL(string: queryString, relativeToURL: baseURL)!
    }
    
    private func extendParameters(parameters: [String:AnyObject], ts: String) -> [String: AnyObject] {
        var result = parameters;
        result["ts"] = ts;
        result["apikey"] = PUBLIC_KEY
        result["hash"] = prepareAuthQueryString(ts)
        return result
    }
    
    private func prepareAuthQueryString(ts: String) -> String {
        return (ts + PRIVATE_KEY + PUBLIC_KEY).md5
    }
    
}
