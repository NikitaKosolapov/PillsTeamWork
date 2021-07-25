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
