//
//  Color+Extensions.swift
//  Navigation
//
//  Created by Ислам on 15.04.2025.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
    
    static let palette = Palette()
    
    struct Palette {
        let background: UIColor = UIColor.createColor(
            lightMode: .white,
            darkMode: .black
        )
        
        let textFieldBackground: UIColor = UIColor.createColor(
            lightMode: .systemGray6,
            darkMode: .darkGray
        )
        
        let textColor: UIColor = UIColor.createColor(
            lightMode: .black,
            darkMode: .white
        )
        
        let borderColor: UIColor = UIColor.createColor(
            lightMode: .lightGray,
            darkMode: .gray
        )
        
        let buttonTextColor: UIColor = UIColor.createColor(
            lightMode: .white,
            darkMode: .white
        )
        
        let buttonBackground: UIColor = UIColor.createColor(
            lightMode: .systemBlue,
            darkMode: .systemBlue
        )
        
        let buttonGreenBackground: UIColor = UIColor.createColor(
            lightMode: .systemGreen,
            darkMode: .systemGreen
        )
    }
}
