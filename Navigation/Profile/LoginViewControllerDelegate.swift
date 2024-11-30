//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Ислам on 11.11.2024.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}
