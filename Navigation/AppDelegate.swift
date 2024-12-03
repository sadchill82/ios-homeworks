//
//  AppDelegate.swift
//  Navigation
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appConfiguration: AppConfiguration?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let randomIndex = Int.random(in: 0...2)
        switch randomIndex {
        case 0:
            appConfiguration = .people("https://swapi.dev/api/people/8")
        case 1:
            appConfiguration = .starship("https://swapi.dev/api/starships/3")
        case 2:
            appConfiguration = .planet("https://swapi.dev/api/planets/5")
        default:
            break
        }
        
        if let configuration = appConfiguration {
            NetworkService.request(for: configuration)
        }
        
        let loginVC = LoginViewController()
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
        
        return true
    }
}
