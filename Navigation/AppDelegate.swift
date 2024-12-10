//
//  AppDelegate.swift
//  Navigation
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appConfiguration: AppConfiguration?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appConfiguration = AppConfiguration.allCases.randomElement()
        if let url = appConfiguration?.url {
            NetworkService.request(url: url)
        }
        
        
        let loginVC = LoginViewController()
        loginVC.delegate = LoginInspector()
        let profileNC = UINavigationController(rootViewController: loginVC)
        profileNC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person.crop.circle"),
                                            selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        let feedVC = FeedViewController()
        let feedNC = UINavigationController(rootViewController: feedVC)
        feedNC.tabBarItem = UITabBarItem(title: "Feed",
                                         image: UIImage(systemName: "text.bubble"),
                                         selectedImage: UIImage(systemName: "text.bubble.fill"))
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [profileNC, feedNC]
        
        // activate main window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error)")
        }
    }
}
