//
//  MoviesListViewController.swift
//  MoviesSearch
//
//  Created by Mihail Kalichkov on 9/23/17.
//  Copyright © 2017 Mihail Kalichkov. All rights reserved.
//

import UIKit

class MoviesListViewController: GenericViewController, UITableViewDelegate, UITableViewDataSource {
    
    var moviesArray : [Movie]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MovieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let movie = moviesArray[indexPath.row]
        
        cell.textLabel?.text = movie.name
        cell.detailTextLabel?.text = movie.releaseDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesArray[indexPath.row]
        let movieDetailstViewController = self.createViewController(storyboardID: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailstViewController.movie = movie
        self.navigationController?.pushViewController(movieDetailstViewController, animated: true)
    }
}
