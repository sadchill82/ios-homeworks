//
//  LoginError.swift
//  Navigation
//
//  Created by Ислам on 16.04.2025.
//

import Foundation

enum LoginError: Error, Equatable {
    case emptyFields
    case invalidCredentials
    case userAlreadyExists
}
