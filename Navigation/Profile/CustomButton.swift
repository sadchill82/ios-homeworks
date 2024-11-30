//
//  CustomButton.swift
//  Navigation
//
//  Created by Ислам on 14.11.2024.
//

import UIKit

class CustomButton: UIButton {
    private var action: (() -> Void)?
    
    init(title: String, titleColor: UIColor, backgroundColor: UIColor? = nil, action: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        self.action = action
        
        self.addTarget(self, action: #selector (buttonTapped), for: .touchUpInside)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonTapped() {
        action?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
