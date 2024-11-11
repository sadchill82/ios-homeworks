//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Ислам on 12.11.2024.
//

import Foundation

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginViewControllerDelegate {
        LoginInspector()
    }
}
