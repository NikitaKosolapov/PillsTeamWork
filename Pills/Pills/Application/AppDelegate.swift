//
//  AppDelegate.swift
//  Pills
//
//  Created by aprirez on 7/12/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let notificationService = NotificationService()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configure()
        FirebaseApp.configure()
        return true
    }
    
}

extension AppDelegate {
    func configure() {
        instantiateInitialViewController()
        configureNotificationService()
        notificationService.getAllNotifications()
    }
    
    func instantiateInitialViewController() {
        let appCoordinator = AppCoordinator(appDelegate: self)
        appCoordinator.instantiateInitialViewController()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func configureNotificationService() {
        notificationService.registerForNotifications()
        notificationService.notificationCenter.delegate = self        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                    @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
    }
    
}
