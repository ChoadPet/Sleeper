//
//  HistoryPresenter.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol HistoryViewProtocol: class, NavigationInitializable {
    
}

final class HistoryPresenter {

    private unowned let view: HistoryViewProtocol
    private let coordinator: Coordinator
    
    
    init(view: HistoryViewProtocol, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        view.initNavigation()
    }
    
    func closePressed() {
        coordinator.router.dismissViewController(animated: true)
    }
}
