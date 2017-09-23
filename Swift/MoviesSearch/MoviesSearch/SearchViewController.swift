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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if titleTextField.text?.count == 0 {
            let alert = UIAlertController(title: "Error", message: "Title must be longer than 0 characters", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            let searchCriteria = SearchCriteria(searchName: titleTextField.text!, searchYear: yearTextField.text!, searchGenre: genreTextField.text!)
            Alamofire.request(urlString, parameters: ["api_key": apiKey, "query": searchCriteria.name , "year": searchCriteria.year , "search_type": searchCriteria.genre]).responseJSON { (json) in
                let moviesJSONObject = try? JSONSerialization.jsonObject(with: json.data!) as! [String: AnyObject]
                let movieResults = moviesJSONObject!["results"] as! [AnyObject]
                var moviesArray = [Movie]()
                for movie in movieResults{
                    moviesArray.append(Movie(dic: movie as! [String : AnyObject]))
                }
                let moviesListViewController = self.createViewController(storyboardID: "MoviesListViewController") as! MoviesListViewController
                moviesListViewController.moviesArray = moviesArray
                self.navigationController?.pushViewController(moviesListViewController, animated: true)
            }
        }
    }
}
