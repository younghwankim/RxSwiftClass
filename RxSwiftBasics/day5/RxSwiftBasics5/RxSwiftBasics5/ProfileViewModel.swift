//
//  RegistrationViewModel.swift
//  LoginDemo
//
//  Created by Young Kim on 2018-05-14.
//  Copyright © 2018 Younghwan Kim. All rights reserved.
//

import Foundation
import RxSwift

class ProfileViewModel: NSObject {
    
    var nameLabel: String { return "Name" }
    var mobilePhoneLabel: String { return "Mobile Phone"}
    var emailLabel: String { return "Email" }
    
    var name: String? { return formatName() }
    var mobilePhone: String? { return formatPhoneNo() }
    var email: String? { return userprofileDTO?.email ?? ""}
    
    var userprofileDTO: UserProfileResponseDto?
    
    override init() {
        
    }
    
    func formatName() -> String {
        guard let _userprofileDTO = userprofileDTO else {
            return ""
        }
        return _userprofileDTO.firstName! + " " + _userprofileDTO.lastName!
    }
    
    func formatPhoneNo() -> String {
        guard let _userprofileDTO = userprofileDTO else {
            return ""
        }
        return _userprofileDTO.mobilePhoneAreaCode! + "-" + _userprofileDTO.mobilePhoneNo!
    }
}

extension ProfileViewModel {
    func getUserProfile(_ username: String) -> Observable<ProfileStatus> {
        return LoginBusinessLogic.shared.profile(user: username)
    }
    
}
