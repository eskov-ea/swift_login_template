//
//  ApiRepository.swift
//  LoginTemplate
//
//  Created by john on 22.06.2024.
//

import Foundation

enum ApiError: Error {
    case unknown
}


class ApiRepository {
    private let fakeStorage = RuntimeAccountStorage.shared
    private let authToken: String = "secret_token"
    
    func login(email: String, password: String) async throws -> String? {
        print("authenticating")
        try await Task.sleep(for: .seconds(2))
        
        
        if fakeStorage.authenticate(email, password) {
            return authToken
        } else {
            print("error 1")
            throw ApiError.unknown
        }
    }
    
    func signUp(email: String, password: String, fullname: String) async throws -> Void {
        try await Task.sleep(for: .seconds(2))
        
        return
    }
    
    func verifyOTPCode(_ code: String) async throws -> Void {
        try await Task.sleep(for: .seconds(2))
        
        return
    }
}
