//
//  LoginBusinessLogic.swift
//  RxSwiftBasics5
//
//  Created by Young Kim on 2018-05-14.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserProfileResponseDto: NSObject {
    var firstName: String?
    var lastName: String?

    var email: String?
    var mobilePhoneAreaCode: String?
    var mobilePhoneNo: String?
    
    override init() {
    }
}

enum AutenticationStatus {
    case success(String)
    case password_error(String)
    case no_user(String)
}

enum ProfileStatus {
    case error(String)
    case userprofile(UserProfileResponseDto)
}

class LoginBusinessLogic {
    static var shared = LoginBusinessLogic()
    let disposeBag = DisposeBag()
    fileprivate init() {}
    var userId = ""
    
    func loginFlow(username: String, password: String) -> Observable<ProfileStatus> {
        return Observable.create { observer in
            self.login(username: username, password: password)
                .filter{
                    switch $0 {
                    case .no_user(let error):
                        observer.onNext(ProfileStatus.error(error))
                        observer.onCompleted()
                        return false
                    case .password_error(let error):
                        observer.onNext(ProfileStatus.error(error))
                        observer.onCompleted()
                        return false
                    case .success(let user_id):
                        self.userId = user_id
                        return true
                    }
            }
            .flatMapLatest { [unowned self] profileStatus -> Observable<ProfileStatus> in
                self.profile(user: self.userId)
            }
            .subscribe(onNext: { profile in
                observer.onNext(profile)
                observer.onCompleted()
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func login(username: String, password: String) -> Observable<AutenticationStatus> {
        return Observable.create { observer in
            if username == "jamesfox" {
                if password == "password" {
                    observer.onNext(AutenticationStatus.success("1001"))
                    observer.onCompleted()
                } else {
                    observer.onNext(AutenticationStatus.password_error("password is wrong"))
                    observer.onCompleted()
                }
            } else {
                observer.onNext(AutenticationStatus.no_user("Invalid User Id"))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    private func profile(user: String)  -> Observable<ProfileStatus> {
        return Observable.create { observer in
            observer.onNext(ProfileStatus.userprofile(self.createUserprofile(user: user)))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func createUserprofile(user: String) -> UserProfileResponseDto {
        let userProfile = UserProfileResponseDto()
        
        userProfile.firstName = "James"
        userProfile.lastName = "Fox"
        
        userProfile.email = "james.fox@testemail.com"
        userProfile.mobilePhoneAreaCode = "416"
        userProfile.mobilePhoneNo = "2220404"
        
        return userProfile
    }
}
