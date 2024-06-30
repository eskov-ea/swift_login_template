//
//  SignUpViewModel.swift
//  LoginTemplate
//
//  Created by Cashalot Worker on 24.06.2024.
//

import Foundation
import SwiftUI

@Observable
class SignUpViewModel {
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    var otpText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    var askOTPCode: Bool = false
    var isFormValid: Bool {
        return isEmailValid() && isPasswordValid() && fullname.count > 1
    }

    
    private let fakeStorage = RuntimeAccountStorage.shared
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d).{4,10}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
    func signUp() async throws {
        isLoading = true
        
        /// conncet to server and ask to create an account
        try? await ApiRepository().signUp(email: email, password: password, fullname: fullname)
        
        /// save user's Email and Password to enable Login feature
        fakeStorage.addAccount(email, password)
        
        isLoading = false
        askOTPCode = true
    }
    
    func clearState() {
        email = ""
        password = ""
        fullname = ""
        errorMessage = nil
        otpText = ""
    }
}
