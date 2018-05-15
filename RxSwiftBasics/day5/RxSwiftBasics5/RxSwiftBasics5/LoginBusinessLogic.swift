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
    public var firstName: String?
    public var lastName: String?

    public var email: String?
    public var mobilePhoneAreaCode: String?
    public var mobilePhoneNo: String?
    
    override init() {
    }
}

enum AutenticationStatus {
    case success(String)
    case password_error(String)
    case no_user(String)
}

enum ProfileStatus {
    case error
    case userprofile(UserProfileResponseDto)
}

class LoginBusinessLogic {
    static var shared = LoginBusinessLogic()
    
    fileprivate init() {}
    
    func login(username: String, password: String) -> Observable<AutenticationStatus> {
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
    
    func profile(user: String)  -> Observable<ProfileStatus> {
        return Observable.create { observer in
            observer.onNext(ProfileStatus.userprofile(self.createUserprofile(user: user)))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func createUserprofile(user: String) -> UserProfileResponseDto {
        let userProfile = UserProfileResponseDto()
        
        userProfile.firstName = "James"
        userProfile.lastName = "Fox"
        
        userProfile.email = "james.fox@testemail.com"
        userProfile.mobilePhoneAreaCode = "416"
        userProfile.mobilePhoneNo = "2220404"
        
        return userProfile
    }
    
    
    
}
