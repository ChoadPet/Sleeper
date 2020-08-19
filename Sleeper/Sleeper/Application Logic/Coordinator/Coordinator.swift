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
    
    func optionsViewController(options: [OptionModel], optionChosen: ((OptionModel) -> Void)?) {
        let viewController = configurator.configure(.options(options: options, optionChosen: optionChosen))
        router.present(viewController, animated: true, modalPresentationStyle: .pageSheet)
    }
    
    func historyViewController() {
        let viewController = configurator.configure(.history)
        router.present(viewController, animated: true)
    }
    
    func recordSummaryViewController(record: RecordModel) {
        let viewController = configurator.configure(.recordSummary(record: record))
        router.push(viewController, animated: true)
    }
}
