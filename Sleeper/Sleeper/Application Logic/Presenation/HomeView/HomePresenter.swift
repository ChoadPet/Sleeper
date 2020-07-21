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
    
    private var soundTimerOptions: [OptionModel.Option] = [
        .off, .min(1), .min(10), .min(15), .min(20)
    ]
    
    private var recordingDurationOptions: [OptionModel.Option] = [
        .off, .min(5), .hour(1), .hour(2), .hour(3), .hour(4), .hour(5)
    ]
    
    private var soundTimerModel: OptionModel
    private var recordingDurationModel: OptionModel
    
    
    init(view: HomeViewProtocol, coordinator: BaseCoordinator) {
        self.view = view
        self.coordinator = coordinator
        self.soundTimerModel = OptionModel(title: Constants.soundTimer,
                                           availableOptions: soundTimerOptions,
                                           currentSelectedOption: .off)
        self.recordingDurationModel = OptionModel(title: Constants.recordingDuration,
                                                  availableOptions: recordingDurationOptions,
                                                  currentSelectedOption: .off)
    }

    // MARK: Public API
    
    func viewDidLoad() {
        var model = TimerPreferenceModel(title: soundTimerModel.title,
                                         description: soundTimerModel.currentSelectedOption.stringInterpolation)
        view.configureSoundTimerView(model)
        
        model = TimerPreferenceModel(title: recordingDurationModel.title,
                                     description: recordingDurationModel.currentSelectedOption.stringInterpolation)
        view.configureRecordingDurationView(model)
    }
    
    func primaryButtonPressed() {
        
    }
    
    func soundTimerPressed() {
        coordinator.timeViewController()
    }
    
    func recordingDurationPressed() {
        coordinator.timeViewController()
    }
}
