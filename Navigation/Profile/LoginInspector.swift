//
//  LoginInspector.swift
//  Navigation
//
//  Created by Ислам on 11.11.2024.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}
