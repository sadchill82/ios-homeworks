//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Ислам on 16.11.2024.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let tabBarController: UITabBarController
    private var profileCoordinator: ProfileCoordinator?
    private var feedCoordinator: FeedCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        setupTabBar()
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    private func setupTabBar() {
        let profileNavController = UINavigationController()
        let feedNavController = UINavigationController()
        
        profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        feedCoordinator = FeedCoordinator(navigationController: feedNavController)
        
        profileCoordinator?.start()
        feedCoordinator?.start()
        
        tabBarController.viewControllers = [profileNavController, feedNavController]
        
        profileNavController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        
        feedNavController.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "text.bubble"),
            selectedImage: UIImage(systemName: "text.bubble.fill")
        )
    }
}
