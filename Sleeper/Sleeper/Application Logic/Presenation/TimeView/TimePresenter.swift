//
//  TimePresenter.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol TimeViewProtocol: class {
    
}

final class TimePresenter {
    
    private unowned var view: TimeViewProtocol
    private let coordinator: BaseCoordinator
    
    
    init(view: TimeViewProtocol, coordinator: BaseCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
}
