//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ислам on 12.08.2024.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Feed"
        
        let showPostButton = UIButton(type: .system)
        showPostButton.setTitle("Show Post", for: .normal)
        showPostButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        showPostButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showPostButton)
        
        NSLayoutConstraint.activate([
            showPostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func showPost() {
        let post = posts[0]
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
