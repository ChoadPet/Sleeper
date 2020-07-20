//
//  HomePresenter.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol HomeViewProtocol: class {
    
    func configureSoundTimerView(_ model: TimerPreferenceModel)
    func configureRecordingDurationView(_ model: TimerPreferenceModel)
}

final class HomePresenter {
    
    private unowned var view: HomeViewProtocol
    private let coordinator: BaseCoordinator
    
    
    init(view: HomeViewProtocol, coordinator: BaseCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: Public API
    
    func viewDidLoad() {
        var model = TimerPreferenceModel(title: Constants.soundTimer, description: "Off")
        view.configureSoundTimerView(model)
        
        model = TimerPreferenceModel(title: Constants.recordingDuration, description: "Off")
        view.configureRecordingDurationView(model)
    }
    
    func primaryButtonPressed() {
        
    }
    
    func soundTimerPressed() {
        
    }
    
    func recordingDurationPressed() {
        
    }
}
