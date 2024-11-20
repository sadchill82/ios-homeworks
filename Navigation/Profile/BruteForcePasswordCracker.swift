//
//  BruteForcePasswordCracker.swift
//  Navigation
//
//  Created by Ислам on 19.11.2024.
//

import Foundation

class BruteForcePasswordCracker {
    
    private let allowedCharacters: [String] = String().printable.map { String($0) }
    
    func bruteForce(passwordToUnlock: String, progressHandler: ((String) -> Void)? = nil) -> String {
        var password = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            progressHandler?(password)
        }
        
        return password
    }
    
    func generateRandomPassword(length: Int) -> String {
        let characters = String().printable
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
    
    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        
        if str.isEmpty {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        
        return str
    }
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        array.firstIndex(of: String(character))!
    }
    
    private func characterAt(index: Int, _ array: [String]) -> Character {
        index < array.count ? Character(array[index]) : Character("")
    }
}

// MARK: - Расширение для работы с символами

extension String {
    var digits: String { "0123456789" }
    var lowercase: String { "abcdefghijklmnopqrstuvwxyz" }
    var uppercase: String { "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters: String { lowercase + uppercase }
    var printable: String { digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
