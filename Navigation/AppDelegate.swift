//
//  AppDelegate.swift
//  Navigation
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var appConfiguration: AppConfiguration?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        LocalNotificationsService.shared.registerForLatestUpdatesIfPossible()
        
        
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
        
        let favoritesVC = FavoritesViewController()
        let favoritesNC = UINavigationController(rootViewController: favoritesVC)
        favoritesNC.tabBarItem = UITabBarItem(title: "Избранное",
                                              image: UIImage(systemName: "star"),
                                              selectedImage: UIImage(systemName: "star.fill"))
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [profileNC, feedNC, favoritesNC]
        
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
