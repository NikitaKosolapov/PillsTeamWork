//
//  AppCoordinator.swift
//  Pills
//
//  Created by Andrey on 24/07/2021.
//

import UIKit

final class AppCoordinator {
    
    private unowned var app: AppDelegate
    
    init(appDelegate: AppDelegate) {
        self.app = appDelegate
    }
    
    func instantiateInitialViewController() {
        makeWindowVisible()
        // TODO: do setup of credentials storage here when ready
        let isOnboardingShowed = true // TODO: put in user defaults storage service when ready
        if !isOnboardingShowed {
            // TODO: put your onboarding viewController when ready
            let viewController = DevelopmentBuilder.build()
            app.window?.rootViewController = viewController
        } else {
            let tabBarMaker = MainTabBarMaker()
            app.window?.rootViewController = tabBarMaker.createTabBarController()
        }
    }
    
    private func makeWindowVisible() {
        app.window = UIWindow(frame: UIScreen.main.bounds)
        app.window?.backgroundColor = UIColor.white
        app.window?.makeKeyAndVisible()
    }

}
