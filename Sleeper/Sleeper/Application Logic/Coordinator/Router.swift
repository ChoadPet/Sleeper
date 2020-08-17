//
//  MainRouter.swift
//  Arkade
//
//  Created by user on 14.02.2020.
//  Copyright © 2020 ArkadeGames. All rights reserved.
//

import UIKit

final class Router: NSObject {
    
    /// This stuck of navigations is all previous, when we present new navigation with viewController
    private var previousNavigationControllers: [RSNavigationController]
    private var currentNavigationController: RSNavigationController
    
    
    init(navigationController: RSNavigationController) {
        self.currentNavigationController = navigationController
        self.previousNavigationControllers = []
    }
    
    // MARK: Public API
    
    func push(_ viewController: UIViewController, animated: Bool) {
        currentNavigationController.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController,
                 animated: Bool,
                 modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                 modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                 completion: (() -> Void)? = nil) {
        
        let newNavigation = RSNavigationController(rootViewController: viewController)
        newNavigation.modalTransitionStyle = modalTransitionStyle
        newNavigation.modalPresentationStyle = modalPresentationStyle
        
        /// This delegate needed for be notifying when user dragging down new iOS 13 presentation style
        newNavigation.presentationController?.delegate = self
        
        /// Now new navigation will start to present and push viewController's
        /// it will be removed, when user dismiss it
        previousNavigationControllers.append(currentNavigationController)
        currentNavigationController = newNavigation
        
        let context = UIApplication.topViewController()
        context?.present(newNavigation, animated: animated, completion: completion)
    }
    
    func dismissViewController(animated: Bool, completion: (() -> Void)? = nil) {
        let context = UIApplication.topViewController()
        context?.dismiss(animated: animated, completion: completion)
        
        removeJustDismissedFlow()
    }
    
    /// Here we take last navigation, which was before we present new
    /// and after, we remove last navigation flow and starting navigating from last
    private func removeJustDismissedFlow() {
        if !previousNavigationControllers.isEmpty {
            currentNavigationController = previousNavigationControllers.removeLast()
        }
    }
}

extension Router: UIAdaptivePresentationControllerDelegate {
    
    /// Called only when user dismiss by dragging down
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        removeJustDismissedFlow()
    }
}
