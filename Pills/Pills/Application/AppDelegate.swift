//
//  AppDelegate.swift
//  Pills
//
//  Created by aprirez on 7/12/21.
//

import UIKit
import DropDown

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
        DropDown.startListeningToKeyboard()
        return true
    }
    
}

extension AppDelegate {
    func configure() {
        instantiateInitialViewController()
        configureNotificationService()
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
}
