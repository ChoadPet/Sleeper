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
    private let userDefaultsService: UserDefaultsService
    private let audioService: AudioService
    private let homeModel: HomeModel
    
    
    init(view: HomeViewProtocol,
         coordinator: BaseCoordinator,
         userDefaultsService: UserDefaultsService) {
        
        self.view = view
        self.coordinator = coordinator
        self.userDefaultsService = userDefaultsService
        let fileURL = Bundle.main.url(forResource: Constants.Sounds.natureFileName,
                                      withExtension: "m4a")!
        self.audioService = try! AudioService(fileURL: fileURL)
        
        let soundTimerModel = TimerPreferenceModel(string: userDefaultsService.soundTimer,
                                                   preferenceType: .soundTimer)
        let recordingModel = TimerPreferenceModel(string: userDefaultsService.recording,
                                                  preferenceType: .recording)
        self.homeModel = HomeModel(titleState: .idle,
                                   buttonState: .play,
                                   soundTimerModel: soundTimerModel,
                                   recordingModel: recordingModel)
    }
    
    // MARK: Public API
    
    func viewDidLoad() {
        view.configureSoundTimerView(homeModel.soundTimerModel)
        view.configureRecordingView(homeModel.recordingModel)
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
    
    func recordingPressed() {
        let title = homeModel.recordingModel.preferenceType.title
        let titles = homeModel.recordingModel.preferenceType.preferencesTitles
        view.showAlert(title: title, actionsTitles: titles) { chosenOption in
            self.homeModel.recordingModel = TimerPreferenceModel(string: chosenOption,
                                                                 preferenceType: .recording)
        }
    }
    
    // MARK: Private API
    
}
