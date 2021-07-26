//
//  BaseRouter.swift
//  Pills
//
//  Created by Andrey on 18/07/2021.
//

import UIKit

class BaseRouter {
    
    private unowned var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension BaseRouter {
    final func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(viewController, animated: animated, completion: completion)
    }
    
    final func push(viewController: UIViewController, animated: Bool = true, isHideTabBar: Bool = false) {
        viewController.hidesBottomBarWhenPushed = isHideTabBar
        viewController.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    final func replaceWithPush(viewController: UIViewController, animated: Bool = true, isHideTabBar: Bool = false) {
        viewController.hidesBottomBarWhenPushed = isHideTabBar
        guard let navController = viewController.navigationController else {
            viewController.present(viewController, animated: animated, completion: nil)
            return
        }
        navController.pushViewController(viewController, animated: animated)
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
    
    final func pushVConTab(tabIndex: Int, viewController: UIViewController) {
        viewController.tabBarController?.selectedIndex = tabIndex
        (viewController.tabBarController?.children[1] as?
            UINavigationController)?.pushViewController(viewController, animated: false)
    }
    
    final func replaceVConTab(tabIndex: Int, viewController: UIViewController, tabBarItem: UITabBarItem) {
        viewController.tabBarItem = tabBarItem
        if let tabBarController = viewController.tabBarController,
           var viewControllers = tabBarController.viewControllers {
            viewControllers.remove(at: tabIndex)
            viewControllers.insert(viewController, at: tabIndex)
            tabBarController.viewControllers = viewControllers
        }
    }
}
