//
//  TestUserService.swift
//  Navigation
//
//  Created by Ислам on 10.11.2024.
//

import UIKit

class TestUserService: UserService {
    var user = User(login: "testUser", fullName: "Test User", avatar: UIImage(named: "vkLogo")!, status: "Testing Mode")
}
