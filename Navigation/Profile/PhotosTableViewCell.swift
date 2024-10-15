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

        for (index, imageView) in photoImageViews.enumerated() {
            self.addSubview(imageView)
            let leadingAnchor = index == 0 ? self.leadingAnchor : photoImageViews[index - 1].trailingAnchor
//            let trailingConstant: CGFloat = index == 3 ? -16 : 8

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                imageView.widthAnchor.constraint(equalToConstant: 80),
                imageView.heightAnchor.constraint(equalToConstant: 80),
//                index == 3 ? imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingConstant) : NSLayoutConstraint()
            ])
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            photoImageViews.last!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }

    func configure(with images: [UIImage]) {
        for (index, image) in images.enumerated() where index < photoImageViews.count {
            photoImageViews[index].image = image
        }
    }
}
