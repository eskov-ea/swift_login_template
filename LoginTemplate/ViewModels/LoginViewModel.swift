//
//  LoginViewModel.swift
//  LoginTemplate
//
//  Created by Cashalot Worker on 24.06.2024.
//

import Foundation

@Observable
class LoginViewModel{
    var email: String = ""
    var password: String = ""
    var otpText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    var shouldShake: Bool = false
    var askOTPCode: Bool = false
    
    var isLoginDataValid: Bool {
        return email.count > 5 && email.contains("@") && password.count > 4
    }
    
    private func clearState() {
        email = ""
        password = ""
        errorMessage = nil
        otpText = ""
    }
    
    func verifyOTPCode(_ code: String) async throws {
        isLoading = true
        guard let result = try? await ApiRepository().verifyOTPCode(code) else {
            return
        }
        
        await MainActor.run {
            isLoading = false
            askOTPCode = false
            NavigationStorage.shared.show(id: FinalView.navigationID, title: "Final View") {
                FinalView()
            }
        }
        clearState()
    }
    
    func login() async throws -> String? {
        isLoading = true
        errorMessage = nil
        
        guard let result = try? await ApiRepository().login(email: self.email, password: self.password) else {
            isLoading = false
            errorMessage = "Incorrect email or password"
            shouldShake = true
            return nil
        }
        isLoading = false
        return result
    }
}

