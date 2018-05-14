//
//  TwoOptionsDelegateVC.swift
//  ReactiveStudy
//
//  Created by Young Kim on 2018-04-27.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit

protocol TwoOptionsDelegate: class {
    func optionOneSelected()
    func optionTwoSelected()
}

class TwoOptionsDelegateVC: UIViewController {

    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    
    weak var delegate: TwoOptionsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func optionOneClicked(_ sender: UIButton) {
        if let _delegate = delegate {
            _delegate.optionOneSelected()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func optionTwoClicked(_ sender: UIButton) {
        if let _delegate = delegate {
            _delegate.optionTwoSelected()
            dismiss(animated: true, completion: nil)
        }
    }
}
