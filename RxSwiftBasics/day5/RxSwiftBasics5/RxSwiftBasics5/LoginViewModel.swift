//
//  LoginViewModel.swift
//  LoginDemo
//
//  Created by Young Kim on 2018-05-14.
//  Copyright © 2018 Younghwan Kim. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    let isValid: Observable<Bool>
    
    init() {
        isValid = Observable.combineLatest(self.username.asObservable(), self.password.asObservable())
        { (username, password) in
            return username.count > 0 && password.count > 0
        }
    }
    
    func login() -> Observable<AutenticationStatus> {
        return LoginBusinessLogic.shared.login(username: username.value, password: password.value)
    }
}
