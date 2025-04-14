//
//  Planet.swift
//  Navigation
//
//  Created by Ислам on 03.12.2024.
//


struct Planet: Decodable {
    let orbitalPeriod: String
    
    enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
    }
}
