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
    
    private unowned var view: HomeViewProtocol
    private let coordinator: BaseCoordinator
    private let homeModel: HomeModel
    private let userDefaultsService: UserDefaultsService
    private let audioService: AudioService
    
    
    init(view: HomeViewProtocol,
         coordinator: BaseCoordinator,
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
        
        let fileURL = Bundle.main.url(forResource: Constants.Sounds.natureFileName,
                                      withExtension: "m4a")!
        self.audioService = try! AudioService(fileURL: fileURL)
        
    }
    
    // MARK: Public API
    
    func viewDidLoad() {
        homeModel.delegate = self
        view.configureSoundTimerView(homeModel.soundTimerModel)
        view.configureRecordingView(homeModel.recordingModel)
    }
    
    func primaryButtonPressed() {
        homeModel.buttonState.toggle()
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
    
    // MARK: Private API
    
}

extension HomePresenter: HomeModelDelegate {
    
    func applicationStateChange(_ newState: HomeModel.ApplicationState) {
        view.changeTitleLabel(newState.title)
    }
    
    func buttonStateDidChange(_ newState: HomeModel.PrimaryButtonState) {
        switch newState {
        case .play:
            homeModel.applicationState = .paused
            audioService.stopPlay()
        case .pause:
            homeModel.applicationState = .playing
            audioService.startPlay(for: 15)
        }
        
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
