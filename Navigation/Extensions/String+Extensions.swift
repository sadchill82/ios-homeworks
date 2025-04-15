//
//  String+Extensions.swift
//  Navigation
//
//  Created by Ислам on 15.04.2025.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
