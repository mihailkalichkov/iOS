//
//  SearchCriteria.swift
//  MoviesSearch
//
//  Created by Mihail Kalichkov on 9/23/17.
//  Copyright © 2017 Mihail Kalichkov. All rights reserved.
//

import UIKit

class SearchCriteria: NSObject {
    let name : String
    let year : String
    let genre : String
    
    init(name : String, year : String, genre : String) {
        self.name = name
        self.year = year
        self.genre = genre
    }
}
