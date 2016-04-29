//
//  NetworkController.swift
//  MovieApi
//
//  Created by Diego Aguirre on 4/29/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class NetworkController {
    private static let API_Key = "api_key=2a2b100ee4e144cfe31916e2d826e833"
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func searchMovieByTitle(title: String) -> NSURL {
        guard let movieEscapedString = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) else { return NSURL() }
        
        let urlString = baseURL + "search/movie?" + API_Key + "&query=" + movieEscapedString
        print(urlString)
        return NSURL(string: urlString)!
    }
    
    // Fetches data from URL
    static func dataAtURL(url: String, completion: (data: NSData?) -> Void) {
        guard let url = NSURL(string: url) else {completion(data: nil); return}
        
        //Goes to URL and retrieves data from URL
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(data: nil)
            } else {
                if let data = data {
                    completion(data: data)
                } else {
                    print("No data return from network request")
                    completion(data: nil)
                }
            }
        }
        dataTask.resume()
    }
    static func jsonWithReturn(data: NSData) -> [String: AnyObject]? {
        return (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject]
    }
}