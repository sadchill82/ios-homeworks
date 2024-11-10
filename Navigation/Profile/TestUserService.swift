//
//  TestUserService.swift
//  Navigation
//
//  Created by Ислам on 10.11.2024.
//

import UIKit

class TestUserService: UserService {
    private let testUser: User
    
    init() {
        let testAvatar = UIImage(named: "testAvatar") ?? UIImage()
        testUser = User(login: "testUser", fullName: "Test User", avatar: testAvatar, status: "Testing Mode")
    }
    
    func fetchUser(login: String) -> User? {
        return testUser
    }
}
