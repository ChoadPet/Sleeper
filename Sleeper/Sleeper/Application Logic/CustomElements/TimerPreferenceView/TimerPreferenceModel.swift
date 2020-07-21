//
//  TimeOption.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

final class TimerPreferenceModel {
    
    let time: Int?
    let timeType: TimeType
    let preferenceType: PreferenceType
    
    var timeAndTimeType: String {
        guard let time = time else { return timeType.rawValue }
        return "\(time) \(timeType.rawValue)"
    }
    
    
    init(time: Int?, timeType: TimeType, preferenceType: PreferenceType) {
        self.time = time
        self.timeType = timeType
        self.preferenceType = preferenceType
    }
    
    init(string: String?, preferenceType: PreferenceType) {
        let array = string?.components(separatedBy: .whitespaces)
        if let options = array, options.count > 1 {
            
            /// option with time
            self.time = Int(options[0])
            self.timeType = TimeType(rawValue: options[1])!
        } else {
            
            /// `off` option
            self.time = nil
            self.timeType = .off
        }
        self.preferenceType = preferenceType
    }
    
}

extension TimerPreferenceModel: Equatable {
    
    static func == (lhs: TimerPreferenceModel, rhs: TimerPreferenceModel) -> Bool {
        return lhs.time == rhs.time &&
            lhs.timeType == rhs.timeType &&
            lhs.preferenceType == rhs.preferenceType
    }
}

extension TimerPreferenceModel {
    
    enum TimeType: String {
        
        case off
        case min
        case hours
    }
    
}

extension TimerPreferenceModel {
    
    enum PreferenceType {
        
        case soundTimer
        case recordingDuration
        
        var title: String {
            switch self {
            case .soundTimer: return Constants.soundTimer
            case .recordingDuration: return Constants.recordingDuration
            }
        }
        
        var preferences: [TimerPreferenceModel] {
            switch self {
            case .soundTimer:
                return [
                    TimerPreferenceModel(time: nil, timeType: .off, preferenceType: self),
                    TimerPreferenceModel(time: 1, timeType: .min, preferenceType: self),
                    TimerPreferenceModel(time: 5, timeType: .min, preferenceType: self),
                    TimerPreferenceModel(time: 10, timeType: .min, preferenceType: self),
                    TimerPreferenceModel(time: 15, timeType: .min, preferenceType: self),
                    TimerPreferenceModel(time: 20, timeType: .min, preferenceType: self)
                ]
            case .recordingDuration:
                return [
                    TimerPreferenceModel(time: nil, timeType: .off, preferenceType: self),
                    TimerPreferenceModel(time: 5, timeType: .min, preferenceType: self),
                    TimerPreferenceModel(time: 1, timeType: .hours, preferenceType: self),
                    TimerPreferenceModel(time: 2, timeType: .hours, preferenceType: self),
                    TimerPreferenceModel(time: 3, timeType: .hours, preferenceType: self),
                    TimerPreferenceModel(time: 4, timeType: .hours, preferenceType: self),
                    TimerPreferenceModel(time: 5, timeType: .hours, preferenceType: self)
                ]
            }
        }
        
    }
    
}
