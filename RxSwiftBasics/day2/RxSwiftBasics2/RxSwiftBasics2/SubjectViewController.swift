//
//  SubjectViewController.swift
//  ReactiveStudy
//
//  Created by Young Kim on 2018-04-24.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectViewController: UIViewController {

    @IBOutlet weak var publishSubjectButton: UIButton!
    @IBOutlet weak var behaviorSubjectButton: UIButton!
    @IBOutlet weak var replaySubjectButton: UIButton!
    @IBOutlet weak var variableButton: UIButton!
    @IBOutlet weak var behaviorRelayButton: UIButton!
    @IBOutlet weak var publishRelayButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureButtons() {
        self.publishSubjectButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.pubishSubjectTest()
            }).disposed(by: disposeBag)
        
        self.behaviorSubjectButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.behaviorSubjectTest()
            }).disposed(by: disposeBag)
        
        self.replaySubjectButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.replaySubjectTest()
            }).disposed(by: disposeBag)
        
        self.variableButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.variableTest()
            }).disposed(by: disposeBag)
        
        self.behaviorRelayButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.behaviorRelayTest()
            }).disposed(by: disposeBag)
        
        self.publishRelayButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.publishRelayTest()
            }).disposed(by: disposeBag)
    }
    
    func pubishSubjectTest() {
        let subject = PublishSubject<String>()
        subject.onNext("Is anyone listening?")
        
        let subscriptionOne = subject
            .subscribe(onNext: { string in
                print(string)
            })
        
        subject.on(.next("1"))
        subject.onNext("2")
        
        let subscriptionTwo = subject
            .subscribe { event in
                print(event)
        }
        
        subject.onNext("3")
        subscriptionOne.dispose()
        subject.onNext("4")
        
        // 1
        subject.onCompleted()
        // 2
        subject.onNext("5")
        // 3
        subscriptionTwo.dispose()
        let disposeBag = DisposeBag()
        
        // 4
        subject
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        subject.onNext("?")
    }
    
    func behaviorSubjectTest() {
        let subject = BehaviorSubject(value: "Initial value")
        
        let disposeBag = DisposeBag()
        
        subject.onNext("X")
        subject.asObservable()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        // 1
        subject.onError(MyError.anError)
        
        // 2
        subject
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func replaySubjectTest() {
        // 1
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        let disposeBag = DisposeBag()
        
        // 2
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        // 3
        subject
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        subject
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        subject.onNext("4")
        subject.onError(MyError.anError)
        subject.dispose()
        
        subject
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func variableTest() {
        // 1
        let variable = Variable("Initial value")
        
        let disposeBag = DisposeBag()
        
        // 2
        variable.value = "New initial value"
        
        // 3
        variable.asObservable()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        // 1
        variable.value = "1"
        
        // 2
        variable.asObservable()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        // 3
        variable.value = "2"
    }
    
    func behaviorRelayTest() {
        let variable = BehaviorRelay(value: "Initial value")
        
        let disposeBag = DisposeBag()
        
        // 2
        variable.accept("New initial value")
        
        // 3
        variable.asObservable()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        // 1
        variable.accept("1")
        
        // 2
        variable.asObservable()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        // 3
        variable.accept("2")
    }
    
    func publishRelayTest() {
        let variable = PublishRelay<String>()
        
        let disposeBag = DisposeBag()
        
        // 2
        variable.accept("New initial value")
        
        // 3
        variable.asObservable()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        // 1
        variable.accept("1")
        
        // 2
        variable.asObservable()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        // 3
        variable.accept("2")
    }
}
