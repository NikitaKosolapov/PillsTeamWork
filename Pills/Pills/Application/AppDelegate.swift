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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        return true
    }

}

extension AppDelegate {
    func configure() {
        configureNavigation()
        configureViewControllers()
        configureIQKeyboardManager()
    }

    func configureNavigation() {
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

        let tabBarFont = UIFont.systemFont(ofSize: 10) //TODO: get from constants when done
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : tabBarFont,
                                                            NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    func configureViewControllers() {
        window = UIWindow(frame: UIScreen.main.bounds)
        //TODO: do setup of credentials storage here when ready
        let isOnboardingShowed = true // TODO: put in user defaults storage service when ready
        if isOnboardingShowed == false {
            let vc = DevelopmentViewController() //TODO: put your onboarding viewController when ready
            window?.rootViewController = vc
        } else {
            let tabBarMaker = MainTabBarMaker()
            window?.rootViewController = tabBarMaker.createTabBarController()
        }

        window?.makeKeyAndVisible()
    }
}

private extension AppDelegate {
    func configureIQKeyboardManager() {
        //TODO: do setup of IQKeyboardManager here when pods installed
    }
}

