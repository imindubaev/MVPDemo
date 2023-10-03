//
//  User.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 21.11.2022.
//

import Foundation

import Foundation

struct User {
    let login: String?
    let passwords: String?
}

extension User {
    static var logins = [
        User(login: "Ilnur", passwords: "12345")
    ]
}
