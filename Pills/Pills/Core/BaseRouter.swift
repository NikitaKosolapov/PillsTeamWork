//
//  BaseRouter.swift
//  Pills
//
//  Created by Andrey on 18/07/2021.
//

import UIKit

class BaseRouter {
    
    weak var viewController: UIViewController!
    
    init(vc: UIViewController) {
        self.viewController = vc
    }
}

extension BaseRouter {
    final func present(vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(vc, animated: animated, completion: completion)
    }
    
    final func push(vc: UIViewController, animated: Bool = true, isHideTabBar: Bool = false) {
        viewController.hidesBottomBarWhenPushed = isHideTabBar
        viewController.navigationController?.pushViewController(vc, animated: animated)
    }
    
    final func replaceWithPush(vc: UIViewController, animated: Bool = true, isHideTabBar: Bool = false) {
        viewController.hidesBottomBarWhenPushed = isHideTabBar
        guard let navController = viewController.navigationController else {
            viewController.present(vc, animated: animated, completion: nil)
            return
        }
        navController.pushViewController(vc, animated: animated)
        let controllers = navController.viewControllers.filter { $0 != viewController }
        navController.setViewControllers(controllers, animated: animated)
    }
    
    final func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.dismiss(animated: animated, completion: completion)
    }
    
    final func pop(animated: Bool = true) {
        viewController.navigationController?.popViewController(animated: animated)
    }
    
    final func popToRoot(animated: Bool = true) {
        viewController.navigationController?.popToRootViewController(animated: animated)
    }
    
    final func openTabItem(index: Int) {
        viewController.tabBarController?.selectedIndex = index
    }
    
    final func pushVConTab(tabIndex: Int, vc: UIViewController) {
        viewController.tabBarController?.selectedIndex = tabIndex
        (viewController.tabBarController?.children[1] as? UINavigationController)?.pushViewController(vc, animated: false)
    }
    
    final func replaceVConTab(tabIndex: Int, vc: UIViewController, tabBarItem: UITabBarItem) {
        vc.tabBarItem = tabBarItem
        if let tabBarController = viewController.tabBarController, var viewControllers = tabBarController.viewControllers {
            viewControllers.remove(at: tabIndex)
            viewControllers.insert(vc, at: tabIndex)
            tabBarController.viewControllers = viewControllers
        }
    }
}
