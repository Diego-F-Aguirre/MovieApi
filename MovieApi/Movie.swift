//
//  Movie.swift
//  MovieApi
//
//  Created by Diego Aguirre on 4/29/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class Movie {
    private let kTitle = "title"
    private let kImage = "poster_path"
    private let kResults = "results"
    private let kRating = "vote_average"
    private let kOverview = "overview"
    
    
    var title: String
    var image: String
    var rating: Double
    var overView: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let title = dictionary[kTitle] as? String,
        image = dictionary[kImage] as? String,
        rating = dictionary[kRating] as? Double,
        overview = dictionary[kOverview] as? String else { return nil }
        
        self.title = title
        self.image = image
        self.rating = rating
        self.overView = overview
    }
}