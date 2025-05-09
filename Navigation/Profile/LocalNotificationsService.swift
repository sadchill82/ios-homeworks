//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Ислам on 16.04.2025.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    
    static let shared = LocalNotificationsService()
    
    private init() {}
    
    func registerForLatestUpdatesIfPossible() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.sound, .badge, .alert]) { granted, error in
            if granted {
                self.scheduleLatestUpdatesNotification()
            } else {
                print("Permission to send notifications was denied")
                if let error = error {
                    print("Error requesting permission: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func scheduleLatestUpdatesNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: ["latestUpdatesNotification"])
        
        let content = UNMutableNotificationContent()
        content.title = "check_updates".localized
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: "latestUpdatesNotification",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Daily notification at 19:00 successfully scheduled")
            }
        }
    }
}
