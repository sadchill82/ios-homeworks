//
//  UserService.swift
//  Navigation
//
//  Created by Ислам on 10.11.2024.
//

import Foundation

protocol UserService {
    func fetchUser(login: String) -> User?
}
