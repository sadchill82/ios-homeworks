//
//  FavoritePostCell.swift
//  Navigation
//
//  Created by Ислам on 13.02.2025.
//


import UIKit

class FavoritePostCell: UITableViewCell {
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let postTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postImageView)
        contentView.addSubview(postTextLabel)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            
            postTextLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            postTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with favoritePost: FavoritePost) {
        postTextLabel.text = favoritePost.text
        if let imageName = favoritePost.imageName {
            postImageView.image = UIImage(named: imageName)
        } else {
            postImageView.image = nil
        }
    }
}
