//
//  SimpleViewModel.swift
//  SimpleTrackActivity
//
//  Created by Young Kim on 2018-05-24.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import RxSwift
import RxCocoa

class SimpleViewModel {
    // Is signing process in progress
    let signingInIndicator = ActivityIndicator()
    let signingIn: Observable<Bool>
    
    init() {
        self.signingIn = signingInIndicator.asObservable()
    }
    
    func simpleObservable() -> Observable<String> {
        return Observable<String>.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                observer.onNext("strawberry")
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
