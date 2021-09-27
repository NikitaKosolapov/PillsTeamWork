//
//  MainTabBarMaker.swift
//  Pills
//
//  Created by Andrey on 17/07/2021.
//

import UIKit

final class MainTabBarMaker {
    
    func createTabBarController() -> UITabBarController {
        
        let mainVC = CoursesViewController()
        let mainNavig = UINavigationController(rootViewController: mainVC)
        
        // TODO: get text and images from constants when ready
        mainVC.tabBarItem = tabItemBuilder(title: Text.Tabs.aidkit, icon: UIImage(named: "courses"))
        
        let medicationVC = JournalViewController()
        let medicationNC = UINavigationController(rootViewController: medicationVC)
        medicationVC.tabBarItem = tabItemBuilder(title: Text.Tabs.journal, icon: UIImage(named: "journal"))

        let settingsVC = SettingsViewController()
        let settingsNavig = UINavigationController(rootViewController: settingsVC)
        settingsVC.tabBarItem = tabItemBuilder(title: Text.Tabs.settings, icon: UIImage(named: "settings"))
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [mainNavig, medicationNC, settingsNavig]
        tabBarVC.tabBar.tintColor = AppColors.blue // TODO: get from constants when ready
        tabBarVC.tabBar.unselectedItemTintColor = AppColors.semiGrayOnly // TODO: get from constants when ready
        tabBarVC.tabBar.barTintColor = AppColors.whiteSapphire
        tabBarVC.tabBar.clipsToBounds = true
        return tabBarVC
    }
    
    func tabItemBuilder(title: String, icon: UIImage? ) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: icon, selectedImage: icon)
        return item
    }
}
