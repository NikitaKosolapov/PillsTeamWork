//
//  MainTabBarMaker.swift
//  Pills
//
//  Created by Andrey on 17/07/2021.
//

import UIKit

class MainTabBarMaker {
    
    func createTabBarController() -> UITabBarController {
        
        let mainVC = DevelopmentViewController()
        let mainNavig = UINavigationController(rootViewController: mainVC)
        // TODO: get text and images from constants when ready
        mainVC.tabBarItem = tabItemBuilder(title: "main", icon: UIImage(named: "test"))
        
        let medicationVC = CoursesViewController()
        let medicationNavig = UINavigationController(rootViewController: medicationVC)
        medicationVC.tabBarItem = tabItemBuilder(title: "medications", icon: UIImage(named: "test"))
        
        let settingsVC = SettingsViewController()
        let settingsNavig = UINavigationController(rootViewController: settingsVC)
        settingsVC.tabBarItem = tabItemBuilder(title: Text.Tabs.settings, icon: UIImage(named: "test"))
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [mainNavig, medicationNavig, settingsNavig]
        tabBarVC.tabBar.tintColor = UIColor.systemRed // TODO: get from constants when ready
        tabBarVC.tabBar.unselectedItemTintColor = UIColor.systemGray // TODO: get from constants when ready
        tabBarVC.tabBar.barTintColor = .white

        return tabBarVC
    }
    
    func tabItemBuilder(title: String, icon: UIImage? ) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: icon, selectedImage: icon)
        return item
    }
}
