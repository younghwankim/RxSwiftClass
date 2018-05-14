//
//  TwoOptionsObservableVC.swift
//  ReactiveStudy
//
//  Created by Young Kim on 2018-04-27.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TwoOptionsObservableVC: UIViewController {

    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    private let selectedOptionSubject = PublishSubject<Int>()
    var selectedOption: Observable<Int> {
        return selectedOptionSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let oneObservable = optionOneButton.rx.tap.map { _ in return 1 }
        let twoObservable = optionTwoButton.rx.tap.map { _ in return 2 }
        
        Observable.of(oneObservable, twoObservable)
            .merge()
            .subscribe(onNext: { [unowned self] option in
                self.complete(action: option)
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func complete(action: Int) {
        dismiss(animated: true) { [unowned self] in
            self.selectedOptionSubject.onNext(action)
            self.selectedOptionSubject.onCompleted()
        }
    }
    
}
