//
//  AppDelegate.swift
//  Pills
//
//  Created by aprirez on 7/12/21.
//

import UIKit

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
        return true
    }
    
}

extension AppDelegate {
    func configure() {
        configureNavigationAppearance()
        instantiateInitialViewController()
        configureIQKeyboardManager()
        configureNotificationService()
    }
    
    func configureNavigationAppearance() {
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.clear],
            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.clear],
            for: .selected)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.clear],
            for: .highlighted)
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .white
        
        let tabBarFont = UIFont.systemFont(ofSize: 10) // TODO: get from constants when done
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : tabBarFont,
                                                            NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    func instantiateInitialViewController() {
        let appCoordinator = AppCoordinator(appDelegate: self)
        appCoordinator.instantiateInitialViewController()
    }
}

private extension AppDelegate {
    func configureIQKeyboardManager() {
        // TODO: do setup of IQKeyboardManager here when pods installed
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func configureNotificationService() {
        notificationService.registerForNotifications()
        notificationService.notificationCenter.delegate = self
    }
}

extension AppDelegate { // added just for demo purposes to show that local notifications work fine
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let view: UIView = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.subviews.last?.viewWithTag(101) {
            view.removeFromSuperview()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        let view = UIView(frame: self.window!.bounds)
        view.tag = 101
        view.backgroundColor = UIColor.white
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.subviews.last?.addSubview(view)
        
        createNotification()
    }
    
    func createNotification() {
        notificationService.send(title: "Pills Reminder", subtitle: "Waiting for your comeback", content: "Time to take your pills")
        
    }
}
