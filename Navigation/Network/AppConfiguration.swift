//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Ислам on 30.11.2024.
//

import Foundation

enum AppConfiguration {
    case people(String)
    case starship(String)
    case planet(String)
    
    var urlString: String {
        switch self {
        case .people(let url):
            return url
        case .starship(let url):
            return url
        case .planet(let url):
            return url
        }
    }
}
