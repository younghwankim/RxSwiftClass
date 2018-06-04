//
//  ViewController.swift
//  TwoWay
//
//  Created by Young Kim on 2018-05-26.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var isHiddenButton: UIButton!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    let hiddenRelay = BehaviorRelay<Bool>(value: false)
    
    @IBOutlet weak var kvoTestButton: UIButton!
    @objc dynamic var someString = ""
    @objc dynamic var someBoolean = false
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.isHiddenButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.isHiddenButtonTest()
            }).disposed(by: disposeBag)
        
        self.kvoTestButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.kvoTest()
            }).disposed(by: disposeBag)
        
//        oneLabel.rx.observe(Bool.self, "hidden")
//            .subscribe(onNext: { [unowned self] hidden in
//                if let _hidden = hidden {
//                    self.twoLabel.isHidden = _hidden
//                }
//            }).disposed(by: disposeBag)
//
//
//        oneLabel.rx.observe(Bool.self, "hidden")
//            .subscribe(onNext: { [unowned self] hidden in
//                if let _hidden = hidden {
//                    self.hiddenRelay.accept(_hidden)
//                }
//            }).disposed(by: disposeBag)
//
//        self.hiddenRelay.asObservable()
//            .bind(to: self.twoLabel.rx.isHidden)
//            .disposed(by: disposeBag)
        
        
        
        oneLabel.rx.observe(Bool.self, "hidden")
            .map { //unwrapping
                if let hidden = $0 {
                    return hidden
                } else {
                    return false
                }
            }
            .bind(to: self.twoLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        //KVO Test
        self.rx.observe(String.self, "someString")
            .subscribe(onNext: { some in
                if let _some = some {
                    print(_some)
                } else {
                    print("")
                }
            }).disposed(by: disposeBag)
        
        
        self.rx.observe(Bool.self, "someBoolean")
            .subscribe(onNext: { some in
                if let _some = some {
                    print(_some ? "true" : "false")
                } else {
                    print("false")
                }
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isHiddenButtonTest() {
        self.oneLabel.isHidden = !self.oneLabel.isHidden
    }
    
    func kvoTest() {
        self.someBoolean = !self.someBoolean
        self.someString = self.someBoolean ? "KVO Test 1" : "KVO Test 2"
    }
}

