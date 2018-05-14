//
//  OperatorViewController.swift
//  RxSwiftBasics1
//
//  Created by Young Kim on 2018-05-12.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OperatorViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func filterTest(_ sender: UIButton) {
        let arrNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let arrEvenNumber = arrNumber.filter{ $0 % 2 == 0}
        
        for number in arrEvenNumber {
            print("i = \(number)")
        }
    }
    
    @IBAction func mapTest(_ sender: UIButton) {
        let visitors = ["Tom","Jerry","Tweety","Spike"]
        
        Observable.from(visitors)
            .map{ "Hello \($0)" }
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
        
        let arrOne = [21,22,23]
        let arrTwo = [24,25,26]
        
        let arrResultOne
            = arrOne
                .filter{ $0 > 21 }
                .map{ _ in arrTwo }
        
        for element in arrResultOne {
            print("\(element)")
        }
    }
    
    @IBAction func flatMapTest(_ sender: UIButton) {
        let visitors = ["Tom","Jerry","Tweety","Spike"]
        
        Observable.from(visitors)
            .flatMap{ Observable.of("Hello \($0)")}
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
        
        let arrInArray = [[11,12,13],[14,15,16]]
        let flatenedArray = arrInArray.flatMap{ $0 }
        
        for element in flatenedArray {
            print("\(element)")
        }
        
        let arrOne = [21,22,23]
        let arrTwo = [24,25,26]
        
        let arrResultTwo
            = arrOne
                .filter { $0 > 22 }
                .flatMap { _ in arrTwo }
        
        for element in arrResultTwo {
            print("\(element)")
        }
    }
    
    @IBAction func mergeTest(_ sender: UIButton) {
        let oneObservable = Observable.of(1, 2, 3)
        let twoObservable = Observable.of(4, 5, 6)
        
        Observable.of(oneObservable,twoObservable)
            .merge()
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func concatTest(_ sender: UIButton) {
        let oneObservable = Observable.of(1, 2, 3)
        let twoObservable = Observable.of(4, 5, 6)
        
        Observable.from([oneObservable,twoObservable])
            .concat()
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func zipTest(_ sender: UIButton) {
        enum Weather {
            case cloudy
            case sunny
        }
        let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
        let right = Observable.of("Lisbon", "Copenhagen", "London", "Madrid", "Vienna")

        let observable = Observable.zip(left, right) {
            weather, city in
            return "It's \(weather) in \(city)"
        }
        
        observable.subscribe(onNext:{ value in
            print(value)
        })
        .disposed(by: self.disposeBag)
        
        
        //Lab
        let oneObservable = Observable.of(1, 2, 3)
        let twoObservable = Observable.of(4, 5, 6)
        
        let observableNumber = Observable.zip(oneObservable, twoObservable) {
            one, two in
            return one + two
        }
        
        observableNumber.subscribe(onNext:{ value in
            print("\(value)")
        })
            .disposed(by: self.disposeBag)
    }
}
