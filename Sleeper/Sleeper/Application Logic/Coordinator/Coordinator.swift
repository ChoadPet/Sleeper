//
//  BaseCoordinator.swift
//  Arkade
//
//  Created by user on 14.02.2020.
//  Copyright © 2020 ArkadeGames. All rights reserved.
//

import UIKit

final class Coordinator {
    
    let router: Router
    
    private let appCoordinator: AppCoordinator
    private var configurator: Configurator!
    
    
    init(appCoordinator: AppCoordinator, router: Router) {
        self.appCoordinator = appCoordinator
        self.router = router
        
        /// Yes, there is retain cycle, should be fixed in the future
        self.configurator = Configurator(coordinator: self)
    }
    
    // MARK: - Initial viewControllers
    
    func homeViewController() -> UIViewController {
        return configurator.configure(.home)
    }
    
    // MARK: - Showing viewControllers
    
    func historyViewController() {
        let viewController = configurator.configure(.history)
        router.present(viewController, animated: true)
    }
}
