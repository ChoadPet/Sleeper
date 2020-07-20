//
//  HomePresenter.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol HomeViewProtocol: class {
    
}

final class HomePresenter {
    
    private unowned var view: HomeViewProtocol
    private let coordinator: BaseCoordinator
    
    init(view: HomeViewProtocol, coordinator: BaseCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
}
