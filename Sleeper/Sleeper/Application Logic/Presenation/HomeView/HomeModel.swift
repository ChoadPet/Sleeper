//
//  HomeModel.swift
//  Sleeper
//
//  Created by user on 24.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

final class HomeModel {
 
    var titleState: TitleState
    var buttonState: PrimaryButtonState
    var soundTimerModel: TimerPreferenceModel
    var recordingModel: TimerPreferenceModel
    
    
    init(titleState: HomeModel.TitleState,
         buttonState: HomeModel.PrimaryButtonState,
         soundTimerModel: TimerPreferenceModel,
         recordingModel: TimerPreferenceModel) {
        
        self.titleState = titleState
        self.buttonState = buttonState
        self.soundTimerModel = soundTimerModel
        self.recordingModel = recordingModel
    }
    
}

extension HomeModel {
    
    enum TitleState: String {
        case idle
        case playing
        case recording
        case paused
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

