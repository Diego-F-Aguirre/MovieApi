//
//  MovieController.swift
//  MovieApi
//
//  Created by Diego Aguirre on 4/29/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class MovieController {
    static let shareInstance = MovieController()
    var moviesArray: [Movie] = []
    
    
    func fetchMovieFromURL(movie: String, completion:(movies: [Movie]?) -> Void ) {
        let url = NetworkController.searchMovieByTitle(movie)
        
        NetworkController.dataAtURL(String(url)) { (data) in
            guard let data = data else {
                print("No data returned!")
                completion(movies: [])
                return
            }
            
            do {
                if let movieObjects = NetworkController.jsonWithReturn(data),
                    resultsArray = movieObjects["results"] as? [[String: AnyObject]]{
                    var movies:[Movie] = []
                    
                    for resultDictionary in resultsArray {
                        if let movie = Movie(dictionary: resultDictionary) {
                            movies.append(movie)
                        }
                    }
                    self.moviesArray = movies
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(movies: movies)
                    })
                } else {
                    completion(movies: [])
                }
            }
        }
        
    }
}