//
//  BaseCoordinator.swift
//  Arkade
//
//  Created by user on 14.02.2020.
//  Copyright © 2020 ArkadeGames. All rights reserved.
//

import Foundation

final class Coordinator {
    
    let router: Router
    
    private let appCoordinator: AppCoordinator
    
    
    init(appCoordinator: AppCoordinator, router: Router) {
        self.appCoordinator = appCoordinator
        self.router = router
    }
    
    // MARK: Initial home controller
    
    func homeViewController() -> HomeViewController {
        let viewController = createHomeViewController()
        return viewController
    }
    
}

// MARK: Creation viewController's

extension Coordinator {
    
    private func createHomeViewController() -> HomeViewController {
        let viewController = HomeViewController.init(nibName: HomeViewController.className, bundle: nil)
        let userDefaultsService = UserDefaultsService.shared
        let presenter = HomePresenter(view: viewController,
                                      coordinator: self,
                                      userDefaultsService: userDefaultsService)
        viewController.presenter = presenter
        return viewController
    }
    
}
