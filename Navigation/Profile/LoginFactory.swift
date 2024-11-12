//
//  LoginFactory.swift
//  Navigation
//
//  Created by Ислам on 12.11.2024.
//

import Foundation
protocol LoginFactory {
    func makeLoginInspector() -> LoginViewControllerDelegate
}
