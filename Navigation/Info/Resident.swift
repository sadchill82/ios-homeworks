//
//  Resident.swift
//  Navigation
//
//  Created by Ислам on 03.12.2024.
//


struct PlanetWithResidents: Decodable {
    let name: String
    let residents: [String]
}

struct Resident: Decodable {
    let name: String
}
