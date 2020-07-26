//
//  BaseCoordinator.swift
//  Arkade
//
//  Created by user on 14.02.2020.
//  Copyright © 2020 ArkadeGames. All rights reserved.
//

import UIKit

final class BaseCoordinator {
    
    let router: MainRouter
    
    private let appCoordinator: AppCoordinator
    
    
    init(appCoordinator: AppCoordinator, router: MainRouter) {
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

extension BaseCoordinator {
    
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
