//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Ислам on 10.11.2024.
//

import UIKit

class CurrentUserService: UserService {
    private let currentUser: User
    
    init() {
        let defaultAvatar = UIImage(named: "teo") ?? UIImage()
        currentUser = User(login: "user123", fullName: "John Doe", avatar: defaultAvatar, status: "Hello, World!")
    }
    
    func fetchUser(login: String) -> User? {
        return login == currentUser.login ? currentUser : nil
    }
}
