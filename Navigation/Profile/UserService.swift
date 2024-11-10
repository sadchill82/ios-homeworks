//
//  UserService.swift
//  Navigation
//
//  Created by Ислам on 10.11.2024.
//

import Foundation

protocol UserService {
    var user: User { get set }
    func fetchUser(login: String) -> User?
}

extension UserService {
    func fetchUser(login: String) -> User? {
        return login == user.login ? user : nil
    }
}
