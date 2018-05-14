//
//  ViewController.swift
//  RxSwiftBasics2
//
//  Created by Young Kim on 2018-05-12.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit

enum MyError: Error {
    case anError
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMain(segue:UIStoryboardSegue) {
        
    }
}

