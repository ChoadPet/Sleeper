//
//  MainRouter.swift
//  Arkade
//
//  Created by user on 14.02.2020.
//  Copyright © 2020 ArkadeGames. All rights reserved.
//

import UIKit

class MainRouter: NSObject {
    
    // This stuck of navigations is all previous, when we present new navigation with viewController
    private var previousNavigationControllers: [UINavigationController]
    private var currentNavigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.currentNavigationController = navigationController
        self.previousNavigationControllers = []
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        currentNavigationController.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController,
                 animated: Bool,
                 modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                 modalPresentationStyle: UIModalPresentationStyle = .overFullScreen,
                 completion: (() -> Void)? = nil) {
        
        let newNavigation = UINavigationController(rootViewController: viewController)
        newNavigation.modalTransitionStyle = modalTransitionStyle
        newNavigation.modalPresentationStyle = modalPresentationStyle
        
        // now new navigation will present and push viewController's
        // it will be removed, when we dismiss it
        previousNavigationControllers.append(currentNavigationController)
        currentNavigationController = newNavigation
        
        let context = topViewController()
        context?.present(newNavigation, animated: animated, completion: completion)
    }
    
    func dismissViewController(animated: Bool, completion: (() -> Void)?) {
        let context = topViewController()
        context?.dismiss(animated: animated, completion: completion)
        
        // here we take last navigation, which was before we present new
        // and after, we remove last navigation and starting navigating from last
        currentNavigationController = previousNavigationControllers.last!
        previousNavigationControllers.removeLast()
    }
    
}

extension MainRouter {
    func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }
        var top: UIViewController? = rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
