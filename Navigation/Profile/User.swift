//
//  User.swift
//  Navigation
//
//  Created by Ислам on 10.11.2024.
//

import UIKit

struct User {
    let login: String
    let fullName: String
    let avatar: UIImage
    let status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
