//
//  MovieDetailsViewController.swift
//  MoviesSearch
//
//  Created by Mihail Kalichkov on 9/23/17.
//  Copyright © 2017 Mihail Kalichkov. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailsViewController: GenericViewController {

    var movie : Movie!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieDetailsTextView: UITextView!
    
    let apiKey = "7b64ae78d2898a533fc0b81d5b1b4411"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieNameLabel.text = movie.name
        movieYearLabel.text = movie.releaseDate
        movieDetailsTextView.text = movie.details
        
        let url = URL(string: movie.posterPath)
        if url != nil{
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData:NSData = NSData(contentsOf: url!)!
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.movieImageView.image = image
                }
            }
        }
    }
}
