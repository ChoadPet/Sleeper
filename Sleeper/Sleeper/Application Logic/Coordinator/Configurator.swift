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
    
    private let persistentStorage = PersistenceStorage()
    private let userDefaultsService = UserDefaultsService()
    
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func configure(_ screen: Screen) -> UIViewController {
        switch screen {
        case .home:
            let viewController = HomeViewController.initViewControllerFromNib()
            let presenter = HomePresenter(view: viewController,
                                          coordinator: coordinator,
                                          userDefaultsService: userDefaultsService,
                                          persistentStorage: persistentStorage)
            viewController.presenter = presenter
            return viewController
        case .options(let options, let optionChosen):
            let viewController = OptionsViewController.initViewControllerFromNib()
            let presenter = OptionsPresenter(view: viewController,
                                             coordinator: coordinator,
                                             options: options,
                                             optionChosen: optionChosen)
            viewController.presenter = presenter
            return viewController
        case .history:
            let viewController = HistoryViewController.initViewControllerFromNib()
            let presenter = HistoryPresenter(view: viewController,
                                             coordinator: coordinator,
                                             persistentStorage: persistentStorage)
            viewController.presenter = presenter
            return viewController
        case .recordSummary(let record):
            let viewController = RecordSummaryViewController.initViewControllerFromNib()
            let presenter = RecordSummaryPresenter(view: viewController,
                                                   coordinator: coordinator,
                                                   record: record)
            viewController.presenter = presenter
            return viewController
        }
    }
    
}

extension Configurator {
    
    enum Screen {
        case home
        case options(options: [OptionModel], optionChosen: ((OptionModel) -> Void)?)
        case history
        case recordSummary(record: RecordModel)
    }
}
