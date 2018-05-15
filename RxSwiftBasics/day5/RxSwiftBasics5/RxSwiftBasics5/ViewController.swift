//
//  ViewController.swift
//  RxSwiftBasics5
//
//  Created by Young Kim on 2018-05-14.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .withLatestFrom(viewModel.isValid)
            .filter { $0 }
            .flatMapLatest { [unowned self] valid -> Observable<ProfileStatus> in
                self.viewModel.loginFlow()
            }
            .subscribe(onNext: { [unowned self] profileStatus in
                switch profileStatus {
                case .error(let error_msg):
                    self.showError(error: error_msg)
                    break
                case .userprofile(let profile):
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyboard.instantiateViewController(withIdentifier: "profileVC") as? ProfileViewController {
                        vc.profileViewModel = ProfileViewModel(profile: profile)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    break
                }
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showError(error: String) {
        let title = "Error"
        let message = error
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
            print("OK button tapped!")
        })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

