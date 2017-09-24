//
//  Movie.swift
//  MoviesSearch
//
//  Created by Mihail Kalichkov on 9/23/17.
//  Copyright © 2017 Mihail Kalichkov. All rights reserved.
//

import UIKit

class Movie: NSObject {
    let name : String
    let releaseDate : String
    let details : String
    let posterPath : String
    
    init(dic : [String : AnyObject]){
        self.name = dic["title"] as! String
        self.releaseDate = dic["release_date"] as! String
        self.details = dic["overview"] as! String
        if let suffix = dic["poster_path"] as? String {
            self.posterPath = "https://image.tmdb.org/t/p/w640" + suffix
        }else{
            self.posterPath = ""
        }
    }
}
