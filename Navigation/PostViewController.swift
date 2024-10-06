//
//  PostViewController.swift
//  Navigation
//
//  Created by Ислам on 12.08.2024.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = post?.author
        
        let infoButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfo))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func showInfo() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .fullScreen
        present(infoViewController, animated: true, completion: nil)
    }
}
