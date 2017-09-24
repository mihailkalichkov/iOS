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
    
    public func presentAlertWithTitle(title: String, message : String, alertActionClosure : @escaping ((UIAlertAction) -> Void)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            alertActionClosure(alertAction)
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
