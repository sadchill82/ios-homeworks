//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ислам on 16.08.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileHeaderView()
    private let postCellIdentifier = "PostCell"
    private let photoCellIdentifier = "PhotoCell"
    
    static let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private let photoImages: [UIImage] = {
        let images = ["photo1", "photo2", "photo3", "photo4"].compactMap { UIImage(named: $0) }
        return images
    }()

    private func setupTableView() {
        view.addSubview(Self.tableView)
        
        Self.tableView.delegate = self
        Self.tableView.dataSource = self
        Self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postCellIdentifier)
        Self.tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: photoCellIdentifier)

        NSLayoutConstraint.activate([
            Self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            Self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            Self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: photoCellIdentifier, for: indexPath) as! PhotosTableViewCell
            cell.configure(with: photoImages)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            cell.configure(with: post)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosVC = PhotosViewController()
            navigationController?.pushViewController(photosVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? profileHeaderView : nil
    }
}

