//
//  NetworkController.swift
//  Representatives
//
//  Created by Dylan Slade on 2/21/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class NetworkController {
    static let baseURL =  "http://whoismyrepresentative.com/"
    static let repByStateCall = "getall_reps_bystate.php?state="
    static let jsonConverter = "&output=json" // Add this to the end of your network call to retrieve JSON.
    
    static func toURL(stateAbbreviation: String) -> NSURL {
        let url = NSURL(string: NetworkController.baseURL + NetworkController.repByStateCall + stateAbbreviation + NetworkController.jsonConverter)!
        return url
    }
    
    static func dataAtURL(url: NSURL, completion: (resultData: NSData?) -> Void) {
        // We must make the network call here. If it is unsuccessful call the ocmpoletion block with a parameter of nil.
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, _, error) -> Void in
            guard let data = data else {
                print(error?.localizedDescription)
                completion(resultData: nil)
                return
            }
            completion(resultData: data)
        } // We just defined dataTask as a NSURLSessionDataTask. On the next line we are calling resume on it. This is akin to pressing a button and having it's action fire.
        dataTask.resume()
    }
}