//
//  UserRegistrationModel.swift
//  LibraryManagementSystemTests
//
//  Created by Beehub on 09/12/20.
//

import Foundation

struct UserRegistrationModel {
    let FullName: String
    let email: String
    let password: String
    let confirmPassword: String
}

extension UserRegistrationModel {
    func isValidFullName() -> Bool {
        return FullName.count > 1
    }

    func isValidEmail() -> Bool {
        return email.contains("@") && email.contains(".")
    }

    func isValidPasswordLength() -> Bool {
        return password.count >= 8 && password.count <= 16
    }
    
    func doPasswordsMatch() -> Bool {
        return password == confirmPassword
    }
    
    func isValidPassword() -> Bool {
        return isValidPasswordLength() && doPasswordsMatch()
    }
    
    func isDataValid() -> Bool {
        return isValidFullName() && isValidEmail() && isValidPasswordLength() &&
        doPasswordsMatch()
    }
}
