//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ислам on 16.08.2024.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var avatarOriginPoint = CGPoint()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let returnAvatarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.backgroundColor = .clear
        button.contentMode = .scaleToFill
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.black, renderingMode: .automatic), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let avatarBackground: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .darkGray
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .darkGray
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Ready to help"

        return textField
    }()
    
    private let setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
        setupTapGesture()
    }
    
    private func setupView() {
        addSubview(avatarImageView)
        addSubview(returnAvatarButton)
        addSubview(avatarBackground)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        returnAvatarButton.addTarget(self, action: #selector(returnAvatarToOrigin), for: .touchUpInside)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func buttonPressed() {
        print(statusLabel.text ?? "No status")
    }
    
    @objc private func avatarTapped() {

        avatarImageView.isUserInteractionEnabled = false
        
        ProfileViewController.tableView.isScrollEnabled = false
        ProfileViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
        
        avatarOriginPoint = avatarImageView.center
        let scale = UIScreen.main.bounds.width / avatarImageView.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                  y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarBackground.isHidden = false
            self.avatarBackground.alpha = 0.7
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.returnAvatarButton.alpha = 1
            }
        }
    }
    
    @objc private func returnAvatarToOrigin() {
        UIImageView.animate(withDuration: 0.5) {
            UIImageView.animate(withDuration: 0.5) {
                self.returnAvatarButton.alpha = 0
                self.avatarImageView.center = self.avatarOriginPoint
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                self.avatarBackground.alpha = 0
            }
        } completion: { _ in
            ProfileViewController.tableView.isScrollEnabled = true
            ProfileViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
            self.avatarImageView.isUserInteractionEnabled = true
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // avatarImageView constraints
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 128),
            avatarImageView.heightAnchor.constraint(equalToConstant: 128),
            
            returnAvatarButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            returnAvatarButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // fullNameLabel constraints
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            fullNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 156),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 28),

            // statusTextField constraints
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 32),
            
            // statusLabel constraints
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            statusLabel.heightAnchor.constraint(equalTo: fullNameLabel.heightAnchor),

            // setStatusButton constraints
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
