//
//  ViewController.swift
//  Scan
//
//  Created by Young Kim on 2018-05-26.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var lastNValuesButton: UIButton!
    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //(tap) —> Void —> (scan) —> Bool —> (subscribe)
        self.switchButton.rx.tap
            .scan(false) { lastState, newValue in
                return !lastState
            }
            .subscribe(onNext: { value in
                print("tap: \(value)")
            }).disposed(by: disposeBag)
        
        //(tap) —> Void —> (scan) —> Int —> (subscribe)
        self.counterButton.rx.tap
            .scan(0) { lastCount, newValue in
                return lastCount + 1
            }
            .subscribe(onNext: { value in
                print("taps: \(value)")
            }).disposed(by: disposeBag)
        

        self.lastNValuesButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.testLastNValues()
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testLastNValues() {
        let numbers = Observable.from([0, 1, 2 , 3, 4, 5, 6])
        
        //(numbers) —> Int —> (scan) —> [Int] —> subscribe
        numbers.scan([]) { lastSlice, newValue in
                return Array(lastSlice + [newValue]).suffix(3)
            }
            .subscribe(onNext: { value in
                print("last 3: \(value)")
            }).disposed(by: disposeBag)
    }

}

