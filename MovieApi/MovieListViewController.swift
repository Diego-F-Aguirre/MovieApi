//
//  MovieListViewController.swift
//  MovieApi
//
//  Created by Diego Aguirre on 4/29/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSearchTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var searchResults: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieListViewController {
    @IBAction func searchButtonPressed(sender: AnyObject) {
        guard let searchTerm = movieSearchTextField.text else { return }
        
        MovieController.shareInstance.fetchMovieFromURL(searchTerm) { (movies) in
            guard let movies = movies else {
                print("No movies")
                return
            }
            self.searchResults = movies
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()
            })
        }
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieController.shareInstance.moviesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = MovieController.shareInstance.moviesArray[indexPath.row]
        
        self.movieTitleLabel.text = movie.title
        self.ratingLabel.text = "rating: " + String(movie.rating)
        self.summaryLabel.text = movie.overView
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            guard let imageURL = NSURL(string: "http://image.tmdb.org/t/p/w500/" + movie.image),
                imageData = NSData(contentsOfURL: imageURL) else {
                    print("No image found")
                    return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.image.image = UIImage(data: imageData)
            })
        }
        return cell
    }
}









