//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by Ислам on 12.02.2025.
//


import UIKit

class FavoritesViewController: UIViewController {
    
    private var favoritePosts: [FavoritePost] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritePostCell.self, forCellReuseIdentifier: "FavoritePostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "favorite".localized
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritePosts = CoreDataManager.shared.fetchFavoritePosts()
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritePostCell",
                                                       for: indexPath) as? FavoritePostCell else {
            return UITableViewCell()
        }
        
        let favoritePost = favoritePosts[indexPath.row]
        cell.configure(with: favoritePost)
        
        return cell
    }
}
