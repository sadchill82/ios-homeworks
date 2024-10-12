//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Ислам on 07.10.2024.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let photoImageViews: [UIImageView] = {
        var views = [UIImageView]()
        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            views.append(imageView)
        }
        return views
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(titleLabel)
        for imageView in photoImageViews {
            addSubview(imageView)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            photoImageViews[0].topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            photoImageViews[0].leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            photoImageViews[0].widthAnchor.constraint(equalToConstant: 80),
            photoImageViews[0].heightAnchor.constraint(equalToConstant: 80),

            photoImageViews[1].topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            photoImageViews[1].leadingAnchor.constraint(equalTo: photoImageViews[0].trailingAnchor, constant: 8),
            photoImageViews[1].widthAnchor.constraint(equalToConstant: 80),
            photoImageViews[1].heightAnchor.constraint(equalToConstant: 80),

            photoImageViews[2].topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            photoImageViews[2].leadingAnchor.constraint(equalTo: photoImageViews[1].trailingAnchor, constant: 8),
            photoImageViews[2].widthAnchor.constraint(equalToConstant: 80),
            photoImageViews[2].heightAnchor.constraint(equalToConstant: 80),

            photoImageViews[3].topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            photoImageViews[3].leadingAnchor.constraint(equalTo: photoImageViews[2].trailingAnchor, constant: 8),
            photoImageViews[3].widthAnchor.constraint(equalToConstant: 80),
            photoImageViews[3].heightAnchor.constraint(equalToConstant: 80),

            photoImageViews[3].trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            photoImageViews[3].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    func configure(with images: [UIImage]) {
        for (index, image) in images.enumerated() {
            photoImageViews[index].image = image
        }
    }
}
