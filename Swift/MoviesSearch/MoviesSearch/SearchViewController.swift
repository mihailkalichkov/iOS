//
//  SearchViewController.swift
//  MoviesSearch
//
//  Created by Mihail Kalichkov on 9/23/17.
//  Copyright © 2017 Mihail Kalichkov. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: GenericViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    
    let urlString = "https://api.themoviedb.org/3/search/movie"
    let apiKey = "7b64ae78d2898a533fc0b81d5b1b4411"
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if titleTextField.text?.count == 0 {//basic validation for example purposes
            self.presentAlertWithTitle(title: "Error", message: "Title must be longer than 0 characters", alertActionClosure: { (action) in
                //handle alertAction here
            })
        }else{
            self.createSearchCriteria()
        }
    }
    
    private func createSearchCriteria() -> Void{
        let searchCriteria = SearchCriteria(name: titleTextField.text!, year: yearTextField.text!, genre: genreTextField.text!)
        self.sendSearchCriteria(criteria: searchCriteria)
    }
    
    private func sendSearchCriteria(criteria : SearchCriteria) -> Void{
        Alamofire.request(urlString, parameters: ["api_key": apiKey, "query": criteria.name , "year": criteria.year , "search_type": criteria.genre]).responseJSON { (json) in
            let moviesJSONObject = try? JSONSerialization.jsonObject(with: json.data!) as! [String: AnyObject]
            let movieResults = moviesJSONObject!["results"] as! [AnyObject]
            var moviesArray = [Movie]()
            for movie in movieResults{
                moviesArray.append(Movie(dic: movie as! [String : AnyObject]))
            }
            self.pushMoviesListViewControllerWithMovies(movies: moviesArray)
        }
    }
    
    private func pushMoviesListViewControllerWithMovies(movies : [Movie]){
        let moviesListViewController = self.createViewController(storyboardID: "MoviesListViewController") as! MoviesListViewController
        moviesListViewController.moviesArray = movies
        self.navigationController?.pushViewController(moviesListViewController, animated: true)
    }
}
