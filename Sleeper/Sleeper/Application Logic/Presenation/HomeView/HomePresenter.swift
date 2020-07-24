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
    func changePrimaryButton(_ title: String)
    func showAlert(title: String, actionsTitles: [String], completion: ((String) -> Void)?)
}

final class HomePresenter {
    
    private unowned var view: HomeViewProtocol
    private let coordinator: BaseCoordinator
    private let userDefaultsService: UserDefaultsService
    private let audioService: AudioService
    private let homeModel: HomeModel
    
    
    init(view: HomeViewProtocol,
         coordinator: BaseCoordinator,
         userDefaultsService: UserDefaultsService) {
        
        self.view = view
        self.coordinator = coordinator
        self.userDefaultsService = userDefaultsService
        let fileURL = Bundle.main.url(forResource: Constants.Sounds.natureFileName, withExtension: "m4a")!
        self.audioService = try! AudioService(fileURL: fileURL)
        
        let soundTimerModel = TimerPreferenceModel(string: userDefaultsService.soundTimer,
                                                   preferenceType: .soundTimer)
        let recordingDurationModel = TimerPreferenceModel(string: userDefaultsService.recordingDuration,
                                                          preferenceType: .recordingDuration)
        self.homeModel = HomeModel(titleState: .idle,
                                   buttonState: .play,
                                   soundTimerModel: soundTimerModel,
                                   recordingDurationModel: recordingDurationModel)
    }
    
    // MARK: Public API
    
    func viewDidLoad() {
        view.configureSoundTimerView(homeModel.soundTimerModel)
        view.configureRecordingDurationView(homeModel.recordingDurationModel)
    }
    
    func primaryButtonPressed() {
        switch homeModel.buttonState {
        case .play:
            audioService.startPlay()
        case .pause:
            audioService.stopPlay()
        }
        homeModel.buttonState.toggle()
        
        /// Update view after we change `buttonState`
        view.changePrimaryButton(homeModel.buttonState.title)
    }
    
    func soundTimerPressed() {
        let title = homeModel.soundTimerModel.preferenceType.title
        let titles = homeModel.soundTimerModel.preferenceType.preferencesTitles
        view.showAlert(title: title, actionsTitles: titles) { [unowned self] chosenOption in
            self.homeModel.soundTimerModel = TimerPreferenceModel(string: chosenOption,
                                                                  preferenceType: .soundTimer)
        }
    }
    
    func recordingDurationPressed() {
        let title = homeModel.recordingDurationModel.preferenceType.title
        let titles = homeModel.recordingDurationModel.preferenceType.preferencesTitles
        view.showAlert(title: title, actionsTitles: titles) { chosenOption in
            self.homeModel.recordingDurationModel = TimerPreferenceModel(string: chosenOption,
                                                                         preferenceType: .recordingDuration)
        }
    }
    
    // MARK: Private API
    
}
