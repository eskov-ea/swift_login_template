//
//  Password.swift
//  LoginTemplate
//
//  Created by john on 22.06.2024.
//

import SwiftUI

@propertyWrapper
struct Password: DynamicProperty {
    private let key: String
    private let storage: KeychainManager = KeychainManager.shared
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: String? {
        get { storage.getPassword(for: key) }
        nonmutating set {
            if let newValue {
                storage.updatePassword(newValue, for: key)
            } else {
                storage.deletePassword(for: key)
            }
        }
    }
}
