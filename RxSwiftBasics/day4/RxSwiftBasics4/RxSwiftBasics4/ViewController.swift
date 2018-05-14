//
//  ViewController.swift
//  RxSwiftBasics4
//
//  Created by Young Kim on 2018-05-13.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var seqControlButton: UIButton!
    @IBOutlet weak var multiSeqControlButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.seqControlButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.seqControlTest()
            }).disposed(by: disposeBag)
        
        self.multiSeqControlButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.multiSeqControlTest()
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func seqControlTest() {
        let fruitObservable = Observable.of("apple", "pineapple", "strawberry")
        let coffeeObservable = Observable.of("McCafe", "TimHorton", "StarBucks")
        let carObservable = Observable.of("Toyota", "Nissan", "Ford","GM")
        
        fruitObservable
            .filter{
                if $0 == "apple" {
                    print($0)
                    return true
                } else {
                    return false
                }
            }
            .flatMap { _ -> Observable<String> in
                coffeeObservable
            }
            .filter{
                if $0 == "TimHorton" {
                    print($0)
                    return true
                } else {
                    return false
                }
            }
            .flatMap { _ -> Observable<String> in
                carObservable
            }
            .subscribe(onNext: { car in
                print(car)
            })
            .disposed(by: self.disposeBag)
    }
    
    func multiSeqControlTest() {
        let fruitObservable = Observable.of("apple","pineapple","strawberry")
        let coffeeObservable = Observable.of("McCafe", "TimHorton", "StarBucks")
        let carObservable = Observable.of("Toyota", "Nissan", "Ford","GM")
        
        Observable<Bool>.create { observer in
            Observable.merge([fruitObservable,
                              coffeeObservable])
                .subscribe(onNext: { thing in
                    print(thing)
                }, onCompleted: {
                    observer.onNext(true)
                    observer.onCompleted()
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
        .filter{
            $0
        }
        .flatMap { _ -> Observable<String> in
            carObservable
        }
        .subscribe(onNext: { car in
            print(car)
        }).disposed(by: self.disposeBag)
    }
}

