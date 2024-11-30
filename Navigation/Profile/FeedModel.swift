//
//  FeedModel.swift
//  Navigation
//
//  Created by Ислам on 14.11.2024.
//

import Foundation

class FeedModel {
    private let secretWord: String
    
    init(secretWord: String) {
        self.secretWord = secretWord
    }
    
    func check(word: String) -> Bool {
        word.lowercased() == secretWord.lowercased()
    }
}
