//
//  Todo.swift
//  Navigation
//
//  Created by Ислам on 02.12.2024.
//

import Foundation

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
