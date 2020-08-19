//
//  HomePresenter.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol HomeViewProtocol: class, NavigationInitializable {
    func configureSoundTimerView(_ model: TimerPreferenceModel)
    func changePrimaryButton(_ title: String)
    func changeTitleLabel(_ title: String)
}

final class HomePresenter {
    
    private unowned let view: HomeViewProtocol
    private let coordinator: Coordinator
    private let homeModel: HomeModel
    private let userDefaultsService: UserDefaultsService
    private let audioPlayerService: AudioPlayingService
    private let persistentStorage: PersistenceStorage
    
    private var startPlay: Date!
    
    
    init(view: HomeViewProtocol,
         coordinator: Coordinator,
         userDefaultsService: UserDefaultsService,
         persistentStorage: PersistenceStorage) {
        
        self.view = view
        self.coordinator = coordinator
        self.userDefaultsService = userDefaultsService
        self.persistentStorage = persistentStorage
        
        let soundTimerModel = TimerPreferenceModel(string: userDefaultsService.soundTimer)
        self.homeModel = HomeModel(soundTimerModel: soundTimerModel)
        
        let fileURL = Bundle.main.url(forResource: Constants.Sounds.natureFileName,
                                      withExtension: "m4a")!
        self.audioPlayerService = try! AudioPlayingService(fileURL: fileURL)
    }
    
    // MARK: Public API
    
    func viewDidLoad() {
        homeModel.delegate = self
        audioPlayerService.delegate = self
        
        view.initNavigation()
        view.configureSoundTimerView(homeModel.soundTimerModel)
    }
    
    func historyPressed() {
        coordinator.historyViewController()
    }
    
    func primaryButtonPressed() {
        switch homeModel.buttonState {
        case .play:
            audioPlayerService.play(for: homeModel.soundTimerModel.timeInterval)
        case .pause:
            audioPlayerService.pause()
        }
    }
    
    func secondaryButtonPressed() {
        switch homeModel.applicationState {
        case .playing, .paused:
            audioPlayerService.stop(forceCancel: true)
        default:
            break
        }
    }
    
    func soundTimerPressed() {
        let optionChosenHandler: (OptionModel) -> Void = { chosenOption in
            let newModel = TimerPreferenceModel(string: chosenOption.title)
            guard newModel != self.homeModel.soundTimerModel else { return }
            self.homeModel.soundTimerModel = newModel
        }
        let options = homeModel.soundTimerModel.optionsTitles.map {
            OptionModel(title: $0,
                        isSelected: $0 == homeModel.soundTimerModel.optionTitle)
        }
        coordinator.optionsViewController(options: options, optionChosen: optionChosenHandler)
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
        
        if homeModel.applicationState == .playing {
            print("should we add more time?")
        }
    }
    
}

// MARK: - AudioServiceDelegate implementation

extension HomePresenter: AudioPlayingServiceDelegate {
    
    func audioServiceStartPlaying(_ audioService: AudioPlayingService) {
        homeModel.applicationState = .playing
        homeModel.buttonState = .pause
        
        startPlay = Date()
    }
    
    func audioServicePausePlaying(_ audioService: AudioPlayingService) {
        homeModel.applicationState = .paused
        homeModel.buttonState = .play
    }
    
    func audioServiceStopPlaying(_ audioService: AudioPlayingService, forceCancel: Bool) {
        homeModel.applicationState = .idle
        homeModel.buttonState = .play
        
        let time = TimeModel(created: startPlay, finished: Date())
        let record = RecordModel(unique: UUID(),
                                 status: forceCancel ? .cancelled : .finished,
                                 timer: homeModel.soundTimerModel.optionTitle,
                                 time: time)
        persistentStorage.createRecord(record)
    }
}
