//
//  UserDefaultsManager.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 04.12.2022.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func saveIsLoggedIn(isLoggedIn: Bool)
    func isLoggedIn() -> Bool
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
        
    private let defaults = UserDefaults.standard
    
    func saveIsLoggedIn(isLoggedIn: Bool) {
        defaults.set(isLoggedIn, forKey: Keys.isLoggedIn)
    }
    
    func isLoggedIn() -> Bool {
        return defaults.bool(forKey: Keys.isLoggedIn)
    }
}

struct Keys {
    static let isLoggedIn = "isLoggedIn"
}
