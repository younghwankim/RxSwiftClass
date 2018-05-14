//
//  ObservableViewController.swift
//  RxSwiftBasics1
//
//  Created by Young Kim on 2018-05-12.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ObservableViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func observableOfTest(_ sender: UIButton) {
        Observable.of(1, 2, 3)
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func observableFromTest(_ sender: UIButton) {
        Observable.from([4,5,6])
            .subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func observableCreateTest(_ sender: UIButton) {
        Observable<Int>.create { observer in
            observer.onNext(7)
            observer.onNext(8)
            observer.onNext(9)
            observer.onCompleted()
            
            return Disposables.create()
            }.subscribe(onNext: { some in
                print(some)
            })
            .disposed(by: self.disposeBag)
    }
}
