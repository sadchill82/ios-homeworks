//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Ислам on 17.11.2024.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        let loginFactory = MyLoginFactory()
        loginVC.loginDelegate = loginFactory.makeLoginInspector()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func showProfile(for user: User) {
        let viewModel = ProfileViewModel(user: user, posts: postExamples)
        let profileVC = ProfileViewController()
        profileVC.configure(with: viewModel)
        navigationController.setViewControllers([profileVC], animated: true)
    }
}
