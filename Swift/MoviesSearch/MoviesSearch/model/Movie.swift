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
        name = dic["title"] as! String
        releaseDate = dic["release_date"] as! String
        details = dic["overview"] as! String
//        let suffix = dic["poster_path"] as! String
//        if suffix.isEmpty{
//            posterPath = ""
//        }else{
//            posterPath = "https://api.themoviedb.org/3" + suffix
//        }
//        if dic["poster_path"] == NSNull{
//            posterPath = "https://api.themoviedb.org/3" + (dic["poster_path"] as! String)
//        }else{
//            posterPath = ""
//        }
        if let suffix = dic["poster_path"] as? String {
            //https://image.tmdb.org/t/p
            posterPath = "https://image.tmdb.org/t/p/w640" + suffix
//            posterPath = "https://api.themoviedb.org/3" + suffix
        }else{
            posterPath = ""
        }
    }
}
