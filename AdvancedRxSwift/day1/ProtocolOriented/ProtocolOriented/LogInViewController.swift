//
//  LogInViewController.swift
//  ProtocolOriented
//
//  Created by Young Kim on 2018-05-20.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit

class BuzzableTextField: UITextField, Buzzable {}
class BuzzableButton: UIButton, Buzzable {}
class BuzzableImageView: UIImageView, Buzzable {}
class BuzzablePoppableLabel: UILabel, Buzzable, Poppable {}

class LogInViewController: UIViewController {
    @IBOutlet weak var passcodTextField: BuzzableTextField!
    @IBOutlet weak var loginButton: BuzzableButton!
    @IBOutlet weak var errorMessageLabel: BuzzablePoppableLabel!
    @IBOutlet weak var profileImageView: BuzzableImageView!
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        passcodTextField.buzz()
        loginButton.buzz()
        errorMessageLabel.buzz()
        errorMessageLabel.pop()
        profileImageView.buzz()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
