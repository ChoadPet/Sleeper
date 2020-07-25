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
    func recordingDidChange(_ newModel: TimerPreferenceModel)
}

final class HomeModel {
    
    var applicationState: ApplicationState {
        didSet { delegate?.applicationStateChange(applicationState) }
    }
    var buttonState: PrimaryButtonState {
        didSet { delegate?.buttonStateDidChange(buttonState) }
    }
    var soundTimerModel: TimerPreferenceModel {
        didSet { delegate?.soundTimerDidChange(soundTimerModel) }
    }
    var recordingModel: TimerPreferenceModel {
        didSet { delegate?.recordingDidChange(recordingModel) }
    }
    
    var canTransitionToRecording: Bool {
        return recordingModel.timeType != .off
    }
    
    weak var delegate: HomeModelDelegate?
    
    
    init(applicationState: HomeModel.ApplicationState = .idle,
         buttonState: HomeModel.PrimaryButtonState = .play,
         soundTimerModel: TimerPreferenceModel,
         recordingModel: TimerPreferenceModel) {
        
        self.applicationState = applicationState
        self.buttonState = buttonState
        self.soundTimerModel = soundTimerModel
        self.recordingModel = recordingModel
    }
    
}

extension HomeModel {
    
    enum PrimaryButtonState {
        case play
        case pause
        
        var title: String {
            switch self {
            case .play:
                return Constants.play
            case .pause:
                return Constants.pause
            }
        }
        
        mutating func toggle() {
            self = self == .play ? .pause : .play
        }
    }
    
}

extension HomeModel {
    
    enum ApplicationState {
        case idle
        case playing
        case paused
        case recording
        
        var title: String {
            switch self {
            case .idle: return Constants.idle
            case .playing: return Constants.playing
            case .paused: return Constants.paused
            case .recording: return Constants.recording
            }
        }
        
    }
}
