//
//  GenericViewController.swift
//  MoviesSearch
//
//  Created by Mihail Kalichkov on 9/23/17.
//  Copyright © 2017 Mihail Kalichkov. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {

    public func createViewController(storyboardID : String) -> GenericViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardID) as! GenericViewController
        return vc
    }
}
