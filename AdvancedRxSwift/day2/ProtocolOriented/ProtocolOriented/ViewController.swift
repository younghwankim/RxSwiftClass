//
//  ViewController.swift
//  ProtocolOriented
//
//  Created by Young Kim on 2018-05-20.
//  Copyright © 2018 Young Kim. All rights reserved.
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
    
    @IBAction func groupInterfaceAction(_ sender: UIButton) {
        
        print("\(4.ex.cube)")
        
        print("\(4.ext.cube)")
        print("\(Int.ext.almostMax)")
        
        print("ReactiveStudy".cibc.greet())
        print("ReactiveStudy".simplii.greet())
        
        print(self.cibc.business())
        print(self.simplii.business())
    }

}

