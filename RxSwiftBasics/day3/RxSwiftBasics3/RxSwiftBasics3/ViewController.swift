//
//  ViewController.swift
//  RxSwiftBasics3
//
//  Created by Young Kim on 2018-05-12.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MyError: Error {
    case anError
}

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
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
    
    @IBAction func showTwoOptionsDelegateVC(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "TwoOptionsDelegateVC") as? TwoOptionsDelegateVC {
            vc.delegate = self
            self.show(vc, sender: nil)
        }
    }
    
    @IBAction func showTwoOptionsObservableVC(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "TwoOptionsObservableVC") as? TwoOptionsObservableVC {
            
            vc.selectedOption.subscribe(onNext: { option in
                print("Option \(option) Selected : TwoOptionsObservableVC")
            })
                .disposed(by: disposeBag)
            
            self.show(vc, sender: nil)
        }
    }
}


extension ViewController:  TwoOptionsDelegate {
    func optionOneSelected() {
        print("Option One Selected : TwoOptionsDelegateVC")
    }
    
    func optionTwoSelected() {
        print("Option Two Selected : TwoOptionsDelegateVC")
    }
}

