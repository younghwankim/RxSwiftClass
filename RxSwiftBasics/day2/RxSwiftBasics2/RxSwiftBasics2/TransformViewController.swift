//
//  TransformViewController.swift
//  ReactiveStudy
//
//  Created by Young Kim on 2018-04-24.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TransformViewController: UIViewController {

    @IBOutlet weak var mapVsFlatMapButton: UIButton!
    @IBOutlet weak var flatMapArrayButton: UIButton!
    @IBOutlet weak var flatMapRelayButton: UIButton!
    @IBOutlet weak var flatMapSubjectButton: UIButton!
    @IBOutlet weak var flatMapFirstButton: UIButton!
    @IBOutlet weak var flatMapLatestButton: UIButton!
    @IBOutlet weak var flatMapOneObservableButton: UIButton!
    @IBOutlet weak var combineLatest: UIButton!
    @IBOutlet weak var zipButton: UIButton!
    @IBOutlet weak var combineButton: UIButton!
    
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
        self.mapVsFlatMapButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.mapVsFlatMapTest()
            }).disposed(by: disposeBag)
        
        self.flatMapArrayButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.flatMapArrayTest()
            }).disposed(by: disposeBag)
        
        self.flatMapRelayButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.flatMapRelayTest()
            }).disposed(by: disposeBag)
        
        self.flatMapSubjectButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.flatMapSubjectTest()
            }).disposed(by: disposeBag)
        
        self.flatMapFirstButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.flatMapFirstTest()
            }).disposed(by: disposeBag)
        
        self.flatMapLatestButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.flatMapLatestTest()
            }).disposed(by: disposeBag)
        
        self.flatMapOneObservableButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.flatMapOneObservableTest()
            }).disposed(by: disposeBag)
        
        self.combineLatest.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.combineLatestTest()
            }).disposed(by: disposeBag)
        
        self.zipButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.zipTest()
            }).disposed(by: disposeBag)
        self.combineButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.combineTest()
            }).disposed(by: disposeBag)
        
    }

    func mapVsFlatMapTest() {
        let visitors = ["Tom","Jerry","Tweety","Spike"]
        Observable.from(visitors)
            .map{ "Hello \($0)" }
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
        
        Observable.from(visitors)
            .flatMap{ Observable.of("Hello \($0)")}
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
    }
    
    func flatMapArrayTest() {
        let arrInArray = [[11,12,13],[14,15,16]]
        
        let flatenedArray = arrInArray.flatMap{ $0 }
        
        for element in flatenedArray {
            print("\(element)")
        }
        let arrOne = [21,22,23]
        let arrTwo = [24,25,26]
        
        let arrResultOne
            = arrOne
                .filter{ $0 > 21 }
                .map{ _ in arrTwo }
        
        for element in arrResultOne {
            print("\(element)")
        }
        
        let arrResultTwo
            = arrOne
                .filter { $0 > 22 }
                .flatMap { _ in arrTwo }
        
        for element in arrResultTwo {
            print("\(element)")
        }
        
        let arrResultThree
            = arrOne
                .filter { $0 > 20 }
                .map { _ in arrTwo }
        
        for element in arrResultThree {
            print("\(element)")
        }
    }
    
    func flatMapRelayTest() {
        struct Player {
            var score: BehaviorRelay<Int>
        }
        
        let 👦🏻 = Player(score: BehaviorRelay(value: 80))
        let 👧🏼 = Player(score: BehaviorRelay(value: 90))
        
        let player = BehaviorRelay(value: 👦🏻)
        
        player.asObservable()
            .flatMap { $0.score.asObservable() }
            .subscribe(onNext: { print($0) })
            .disposed(by: self.disposeBag)
        
        👦🏻.score.accept(85)
        player.accept(👧🏼)
        👦🏻.score.accept(95)
        👧🏼.score.accept(100)
    }
    
    func flatMapSubjectTest() {
        struct Player {
            var score: BehaviorSubject<Int>
        }
        let 👦🏻 = Player(score: BehaviorSubject(value: 80))
        let 👧🏼 = Player(score: BehaviorSubject(value: 90))
        
        let player = BehaviorSubject(value: 👦🏻)
        
        player.asObservable()
            .flatMap { $0.score.asObservable() }
            .subscribe(onNext: { print($0) })
            .disposed(by: self.disposeBag)
        
        👦🏻.score.onNext(85)
        player.onNext(👧🏼)
        👦🏻.score.onNext(95)
        👧🏼.score.onNext(100)
    }
    
    func flatMapFirstTest() {
        struct Player {
            var score: BehaviorRelay<Int>
        }
        
        let 👦🏻 = Player(score: BehaviorRelay(value: 80))
        let 👧🏼 = Player(score: BehaviorRelay(value: 90))
        
        let player = BehaviorRelay(value: 👦🏻)
        
        player.asObservable()
            .flatMapFirst { $0.score.asObservable() }
            .subscribe(onNext: { print($0) })
            .disposed(by: self.disposeBag)
        
        👦🏻.score.accept(85)
        player.accept(👧🏼)
        👦🏻.score.accept(95)
        👧🏼.score.accept(100)
    }
    
    func flatMapLatestTest() {
        struct Player {
            var score: BehaviorRelay<Int>
        }
        
        let 👦🏻 = Player(score: BehaviorRelay(value: 80))
        let 👧🏼 = Player(score: BehaviorRelay(value: 90))
        
        let player = BehaviorRelay(value: 👦🏻)
        
        player.asObservable()
            .flatMapLatest { $0.score.asObservable() }
            .subscribe(onNext: { print($0) })
            .disposed(by: self.disposeBag)
        
        👦🏻.score.accept(85)
        player.accept(👧🏼)
        👦🏻.score.accept(95)
        👧🏼.score.accept(100)
    }
    
    func flatMapOneObservableTest() {
        struct Player {
            var score: Int
        }
        
        var 👦🏻 = Player(score:  80)
        var 👧🏼 = Player(score: 90)
        
        let player = BehaviorRelay(value: 👦🏻)
        
        player.asObservable()
            .map { $0.score }
            .subscribe(onNext: { print($0) })
            .disposed(by: self.disposeBag)
        
        👦🏻.score = 85
        player.accept(👧🏼)
        👦🏻.score = 95 
        👧🏼.score = 100
    }
    
    func combineLatestTest() {
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        
        // 1
        let observable = Observable.combineLatest(left, right, resultSelector: {
            lastLeft, lastRight in
            "\(lastLeft) \(lastRight)"
        })
        let disposable = observable.subscribe(onNext: { value in
            print(value)
        })
        
        // 2
        print("> Sending a value to Left")
        left.onNext("Hello,")
        print("> Sending a value to Right")
        right.onNext("world")
        print("> Sending another value to Right")
        right.onNext("RxSwift")
        print("> Sending another value to Left")
        left.onNext("Have a good day,")
        
        disposable.dispose()
    }
    
    func zipTest() {
        enum Weather {
            case cloudy
            case sunny
        }
        let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
        let right = Observable.of("Lisbon", "Copenhagen", "London", "Madrid", "Vienna")
        
        let observable = Observable.zip(left, right) { weather, city in
            return "It's \(weather) in \(city)"
        }
        observable.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
    }
    
    func combineTest() {
        let choice : Observable<DateFormatter.Style> = Observable.of(.short, .long)
        let dates = Observable.of(Date())
        
        let observable = Observable.combineLatest(choice, dates) {
            (format, when) -> String in
            let formatter = DateFormatter()
            formatter.dateStyle = format
            return formatter.string(from: when)
        }
        
        observable.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
    }
}

