//
//  File.swift
//  Navigation
//
//  Created by Ислам on 11.11.2024.
//

import Foundation

class Checker {
    static let shared = Checker()
    
    private let login = "testUser"
    private let password = "12345"
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}
