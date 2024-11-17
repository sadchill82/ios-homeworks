//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Ислам on 17.11.2024.
//

import UIKit

final class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.pushViewController(feedVC, animated: false)
    }
}
