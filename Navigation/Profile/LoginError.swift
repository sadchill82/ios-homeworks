//
//  LoginError.swift
//  Navigation
//
//  Created by Ислам on 21.11.2024.
//

import Foundation

enum LoginError: Error {
    case emptyFields
    case invalidCredentials
    case userNotFound
    case unknown
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyFields:
            "Логин и пароль не могут быть пустыми."
        case .invalidCredentials:
            "Некорректный логин или пароль"
        case .userNotFound:
            "Пользователь не найден."
        case .unknown:
            "Произошла неизвестная ошибка. Попробуйте снова."
        }
    }
}
