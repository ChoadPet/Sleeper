//
//  BaseCoordinator.swift
//  Arkade
//
//  Created by user on 14.02.2020.
//  Copyright © 2020 ArkadeGames. All rights reserved.
//

import UIKit

final class BaseCoordinator {
    
    var router: MainRouter
    
    private var appCoordinator: AppCoordinator
    
    
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

// MARK: Displaying viewController's

extension BaseCoordinator {
    
    func timeViewController() {
        let viewController = createTimeViewController()
        router.present(viewController, animated: false)
    }
}

// MARK: Creation viewController's

extension BaseCoordinator {
    
    private func createHomeViewController() -> HomeViewController {
        let viewController = HomeViewController.init(nibName: HomeViewController.className, bundle: nil)
        let presenter = HomePresenter(view: viewController, coordinator: self)
        viewController.presenter = presenter
        return viewController
    }
    
    private func createTimeViewController() -> TimeViewController {
        let viewController = TimeViewController.init(nibName: TimeViewController.className, bundle: nil)
        let presenter = TimePresenter(view: viewController, coordinator: self)
        viewController.presenter = presenter
        return viewController
    }
    
}
