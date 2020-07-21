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
    
    private var currentSoundTimerPreference: TimerPreferenceModel {
        didSet {
            if currentSoundTimerPreference == oldValue { return }
            soundTimerModel.currentSelectedPreference = currentSoundTimerPreference
            view.configureSoundTimerView(currentSoundTimerPreference)
        }
    }
    private var currentRecordingDurationPreference: TimerPreferenceModel {
        didSet {
            if currentRecordingDurationPreference == oldValue { return }
            recordingDurationModel.currentSelectedPreference = currentRecordingDurationPreference
            view.configureRecordingDurationView(currentRecordingDurationPreference)
        }
    }
    
    private let soundTimerModel: OptionModel
    private let recordingDurationModel: OptionModel
    
    
    init(view: HomeViewProtocol, coordinator: BaseCoordinator) {
        self.view = view
        self.coordinator = coordinator
        self.currentSoundTimerPreference = TimerPreferenceModel(time: nil, timeType: .off, preferenceType: .soundTimer)
        self.currentRecordingDurationPreference = TimerPreferenceModel(time: nil, timeType: .off, preferenceType: .recordingDuration)
        self.soundTimerModel = OptionModel(title: Constants.soundTimer,
                                           preferences: TimerPreferenceModel.PreferenceType.soundTimer,
                                           currentSelectedPreference: currentSoundTimerPreference)
        self.recordingDurationModel = OptionModel(title: Constants.recordingDuration,
                                                  preferences: TimerPreferenceModel.PreferenceType.recordingDuration,
                                                  currentSelectedPreference: currentRecordingDurationPreference)
    }
    
    // MARK: Public API
    
    func viewDidLoad() {
        view.configureSoundTimerView(currentSoundTimerPreference)
        view.configureRecordingDurationView(currentRecordingDurationPreference)
    }
    
    func primaryButtonPressed() {
        
    }
    
    func soundTimerPressed() {
        let title = soundTimerModel.title
        let titles = soundTimerModel.availablePreferencesTitles
        view.showAlert(title: title, actionsTitles: titles) { [unowned self] chosenOption in
            self.currentSoundTimerPreference = TimerPreferenceModel(string: chosenOption, preferenceType: .soundTimer)
        }
    }
    
    func recordingDurationPressed() {
        let title = recordingDurationModel.title
        let titles = recordingDurationModel.availablePreferencesTitles
        view.showAlert(title: title, actionsTitles: titles) { chosenOption in
            self.currentRecordingDurationPreference = TimerPreferenceModel(string: chosenOption, preferenceType: .recordingDuration)
        }
    }
    
    // MARK: Private API
    
}
