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
    
    // MARK: Initial welcome controller
    
    func homeViewController() -> HomeViewController {
        let viewController = createHomeViewController()
        return viewController
    }
}

extension BaseCoordinator {
    
    private func createHomeViewController() -> HomeViewController {
        let viewController = HomeViewController.init(nibName: String(describing: HomeViewController.self), bundle: nil)
        let presenter = HomePresenter(view: viewController, coordinator: self)
        viewController.presenter = presenter
        return viewController
    }
    
}
