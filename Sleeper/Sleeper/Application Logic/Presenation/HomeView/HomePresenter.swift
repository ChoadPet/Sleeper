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
    func configureRecordingView(_ model: TimerPreferenceModel)
    func changePrimaryButton(_ title: String)
    func changeTitleLabel(_ title: String)
    func showAlert(title: String,
                   actionsTitles: [String],
                   completion: ((String) -> Void)?)
}

final class HomePresenter {
    
    private unowned let view: HomeViewProtocol
    private let coordinator: Coordinator
    private let homeModel: HomeModel
    private let userDefaultsService: UserDefaultsService
    private let audioPlayerService: AudioPlayingService
    private let audioRecordingService: AudioRecordingService
    
    
    init(view: HomeViewProtocol,
         coordinator: Coordinator,
         userDefaultsService: UserDefaultsService) {
        
        self.view = view
        self.coordinator = coordinator
        
        let soundTimerModel = TimerPreferenceModel(string: userDefaultsService.soundTimer,
                                                   preferenceType: .soundTimer)
        let recordingModel = TimerPreferenceModel(string: userDefaultsService.recording,
                                                  preferenceType: .recording)
        self.homeModel = HomeModel(soundTimerModel: soundTimerModel,
                                   recordingModel: recordingModel)
        
        self.userDefaultsService = userDefaultsService
        
        var fileURL = Bundle.main.url(forResource: Constants.Sounds.natureFileName,
                                      withExtension: "m4a")!
        self.audioPlayerService = try! AudioPlayingService(fileURL: fileURL)
        
        fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!.appendingPathComponent("recording \(Date()).m4a")
        self.audioRecordingService = try! AudioRecordingService(fileURL: fileURL)
    }
    
    // MARK: Public API
    
    func viewDidLoad() {
        homeModel.delegate = self
        audioPlayerService.delegate = self
        audioRecordingService.delegate = self
        
        view.configureSoundTimerView(homeModel.soundTimerModel)
        view.configureRecordingView(homeModel.recordingModel)
    }
    
    func primaryButtonPressed() {
        switch homeModel.buttonState {
        case .play:
            audioPlayerService.play(for: homeModel.soundTimerModel.timeInterval)
        case .pause:
            audioPlayerService.pause()
        }
    }
    
    func soundTimerPressed() {
        let title = homeModel.soundTimerModel.title
        let titles = homeModel.soundTimerModel.optionsTitles
        view.showAlert(title: title, actionsTitles: titles) { [unowned self] chosenOption in
            let newModel = TimerPreferenceModel(string: chosenOption,
                                                preferenceType: .soundTimer)
            guard newModel != self.homeModel.soundTimerModel else { return }
            self.homeModel.soundTimerModel = newModel
        }
    }
    
    func recordingPressed() {
        let title = homeModel.recordingModel.title
        let titles = homeModel.recordingModel.optionsTitles
        view.showAlert(title: title, actionsTitles: titles) { [unowned self] chosenOption in
            let newModel = TimerPreferenceModel(string: chosenOption,
                                                preferenceType: .recording)
            guard newModel != self.homeModel.recordingModel else { return }
            self.homeModel.recordingModel = newModel
        }
    }
}

// MARK: - HomeModelDelegate implementation

extension HomePresenter: HomeModelDelegate {
    
    func applicationStateChange(_ newState: HomeModel.ApplicationState) {
        view.changeTitleLabel(newState.title)
    }
    
    func buttonStateDidChange(_ newState: HomeModel.PrimaryButtonState) {
        view.changePrimaryButton(newState.title)
    }
    
    func soundTimerDidChange(_ newModel: TimerPreferenceModel) {
        userDefaultsService.soundTimer = newModel.optionTitle
        view.configureSoundTimerView(newModel)
    }
    
    func recordingDidChange(_ newModel: TimerPreferenceModel) {
        userDefaultsService.recording = newModel.optionTitle
        view.configureRecordingView(newModel)
    }
}

// MARK: - AudioServiceDelegate implementation

extension HomePresenter: AudioPlayingServiceDelegate {
    
    func audioServiceStartPlaying(_ audioService: AudioPlayingService) {
        homeModel.applicationState = .playing
        homeModel.buttonState = .pause
    }
    
    func audioServicePausePlaying(_ audioService: AudioPlayingService) {
        homeModel.applicationState = .paused
        homeModel.buttonState = .play
    }
    
    func audioServiceStopPlaying(_ audioService: AudioPlayingService) {
        if homeModel.canTransitionToRecording {
            audioRecordingService.record(duration: homeModel.recordingModel.timeInterval)
        } else {
            homeModel.applicationState = .idle
        }
        homeModel.buttonState = .play
    }
}

// MARK: - AudioRecordingServiceDelegate implementation

extension HomePresenter: AudioRecordingServiceDelegate {
    
    func audioServiceStartRecording(_ audioService: AudioRecordingService) {
        homeModel.applicationState = .recording
    }
    
    func audioServiceFinishRecording(_ audioService: AudioRecordingService) {
        homeModel.applicationState = .idle
    }
}
