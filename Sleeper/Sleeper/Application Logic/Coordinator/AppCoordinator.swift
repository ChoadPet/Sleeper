//
//  AppCoordinator.swift
//  Arkade
//
//  Created by user on 14.02.2020.
//  Copyright © 2020 ArkadeGames. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Public API
    
    func makeRootAccordingToUser() {
        let viewController = homeViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
}

extension AppCoordinator {
    
    private func homeViewController() -> RSNavigationController {
        let navigation = RSNavigationController()
        let router = Router(navigationController: navigation)
        let coordinator = Coordinator(appCoordinator: self, router: router)
        let viewController = coordinator.homeViewController()
        navigation.viewControllers = [viewController]
        return navigation
    }
    
}
