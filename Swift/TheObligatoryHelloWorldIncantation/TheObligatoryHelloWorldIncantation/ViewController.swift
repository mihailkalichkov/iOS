//
//  ViewController.swift
//  TheObligatoryHelloWorldIncantation
//
//  Created by Mihail Kalichkov on 5/21/15.
//  Copyright (c) 2015 Mihail Kalichkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttoonPressed(sender: UIButton) {
        let alertController = UIAlertController(title: "Hello World", message: "Valar morghulis!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Valar dohaeris", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}

