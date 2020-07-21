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
    func showAlert(title: String, actionsTitles: [String], completion: ((String) -> Void)?)
}

final class HomePresenter {
    
    private unowned var view: HomeViewProtocol
    private let coordinator: BaseCoordinator
    private let userDefaultsService: UserDefaultsService
    
    private var soundTimerModel: TimerPreferenceModel {
        didSet {
            if soundTimerModel == oldValue { return }
            userDefaultsService.soundTimer = soundTimerModel.timeAndTimeType
            view.configureSoundTimerView(soundTimerModel)
        }
    }
    private var recordingDurationModel: TimerPreferenceModel {
        didSet {
            if recordingDurationModel == oldValue { return }
            userDefaultsService.recordingDuration = recordingDurationModel.timeAndTimeType
            view.configureRecordingDurationView(recordingDurationModel)
        }
    }
    
    init(view: HomeViewProtocol, coordinator: BaseCoordinator, userDefaultsService: UserDefaultsService) {
        self.view = view
        self.coordinator = coordinator
        self.userDefaultsService = userDefaultsService
        self.soundTimerModel = TimerPreferenceModel(string: userDefaultsService.soundTimer,
                                                         preferenceType: .soundTimer)
        self.recordingDurationModel = TimerPreferenceModel(string: userDefaultsService.recordingDuration,
                                                                preferenceType: .recordingDuration)
    }
    
    // MARK: Public API
    
    func viewDidLoad() {
        view.configureSoundTimerView(soundTimerModel)
        view.configureRecordingDurationView(recordingDurationModel)
    }
    
    func primaryButtonPressed() {
        
    }
    
    func soundTimerPressed() {
        let title = soundTimerModel.preferenceType.title
        let titles = soundTimerModel.preferenceType.preferencesTitles
        view.showAlert(title: title, actionsTitles: titles) { [unowned self] chosenOption in
            self.soundTimerModel = TimerPreferenceModel(string: chosenOption,
                                                             preferenceType: .soundTimer)
        }
    }
    
    func recordingDurationPressed() {
        let title = recordingDurationModel.preferenceType.title
        let titles = recordingDurationModel.preferenceType.preferencesTitles
        view.showAlert(title: title, actionsTitles: titles) { chosenOption in
            self.recordingDurationModel = TimerPreferenceModel(string: chosenOption,
                                                                    preferenceType: .recordingDuration)
        }
    }
    
    // MARK: Private API
    
}
