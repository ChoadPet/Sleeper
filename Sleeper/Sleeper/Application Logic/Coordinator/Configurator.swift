//
//  Configurator.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

final class Configurator {
    
    private let coordinator: Coordinator
    
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func configure(_ screen: Screen) -> UIViewController {
        switch screen {
        case .home:
            let viewController = HomeViewController.initViewControllerFromNib()
            let userDefaultsService = UserDefaultsService()
            let presenter = HomePresenter(view: viewController,
                                          coordinator: coordinator,
                                          userDefaultsService: userDefaultsService)
            viewController.presenter = presenter
            return viewController
        case .history:
            let viewController = HistoryViewController.initViewControllerFromNib()
            let presenter = HistoryPresenter(view: viewController,
                                             coordinator: coordinator)
            viewController.presenter = presenter
            return viewController
        }
    }
    
}

extension Configurator {
    
    enum Screen {
        case home
        case history
    }
}
