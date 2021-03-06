//
//  HomeModel.swift
//  Sleeper
//
//  Created by user on 24.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol HomeModelDelegate: class {
    func applicationStateChange(_ newState: HomeModel.ApplicationState)
    func buttonStateDidChange(_ newState: HomeModel.PrimaryButtonState)
    func soundTimerDidChange(_ newModel: TimerPreferenceModel)
}

final class HomeModel {
    
    weak var delegate: HomeModelDelegate?
    
    var applicationState: ApplicationState {
        didSet { delegate?.applicationStateChange(applicationState) }
    }
    var buttonState: PrimaryButtonState {
        didSet { delegate?.buttonStateDidChange(buttonState) }
    }
    var soundTimerModel: TimerPreferenceModel {
        didSet { delegate?.soundTimerDidChange(soundTimerModel) }
    }
    
    
    init(applicationState: HomeModel.ApplicationState = .idle,
         buttonState: HomeModel.PrimaryButtonState = .play,
         soundTimerModel: TimerPreferenceModel) {
        
        self.applicationState = applicationState
        self.buttonState = buttonState
        self.soundTimerModel = soundTimerModel
    }

}

extension HomeModel {
    
    enum PrimaryButtonState {
        case play
        case pause
        
        var title: String {
            switch self {
            case .play: return Constants.ButtonsTitles.play
            case .pause: return Constants.ButtonsTitles.pause
            }
        }
    }
    
}

extension HomeModel {
    
    enum ApplicationState {
        case idle
        case playing
        case paused
        
        var title: String {
            switch self {
            case .idle: return Constants.Home.idle
            case .playing: return Constants.Home.playing
            case .paused: return Constants.Home.paused
            }
        }
    }
    
}
