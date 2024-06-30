//
//  RuntimeAccountStorage.swift
//  LoginTemplate
//
//  Created by john on 29.06.2024.
//

import Foundation


final class RuntimeAccountStorage {
    static let shared = RuntimeAccountStorage(); private init() {}
    
    private var accounts = [String: String]()
    
    func addAccount(_ email: String, _ password: String) {
        print("Add account [\(email): \(password)]")
        accounts[email] = password
    }
    
    func authenticate(_ email: String, _ passwword: String) -> Bool {
        guard let accountPassword = accounts[email] else {
            return false
        }
        
        return accountPassword == passwword
    }
}
