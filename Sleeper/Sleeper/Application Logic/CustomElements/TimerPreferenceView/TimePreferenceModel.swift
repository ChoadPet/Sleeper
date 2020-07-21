//
//  TimeOption.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

final class TimePreferenceModel {
    
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
    
    init(string: String, preferenceType: PreferenceType) {
        let array = string.components(separatedBy: .whitespaces)
        if array.count == 1 {
            
            /// `off` option
            self.time = nil
            self.timeType = TimeType(rawValue: array[0])!
        } else {
            
            /// option with time
            self.time = Int(array[0])
            self.timeType = TimeType(rawValue: array[1])!
        }
        self.preferenceType = preferenceType
    }
    
}

extension TimePreferenceModel: Equatable {
    
    static func == (lhs: TimePreferenceModel, rhs: TimePreferenceModel) -> Bool {
        return lhs.time == rhs.time &&
            lhs.timeType == rhs.timeType &&
            lhs.preferenceType == rhs.preferenceType
    }
}

extension TimePreferenceModel {
    
    enum TimeType: String {
        
        case off
        case min
        case hours
    }
    
}

extension TimePreferenceModel {
    
    enum PreferenceType {
        
        case soundTimer
        case recordingDuration
        
        var title: String {
            switch self {
            case .soundTimer: return Constants.soundTimer
            case .recordingDuration: return Constants.recordingDuration
            }
        }
        
        var preferences: [TimePreferenceModel] {
            switch self {
            case .soundTimer:
                return [
                    TimePreferenceModel(time: nil, timeType: .off, preferenceType: self),
                    TimePreferenceModel(time: 1, timeType: .min, preferenceType: self),
                    TimePreferenceModel(time: 5, timeType: .min, preferenceType: self),
                    TimePreferenceModel(time: 10, timeType: .min, preferenceType: self),
                    TimePreferenceModel(time: 15, timeType: .min, preferenceType: self),
                    TimePreferenceModel(time: 20, timeType: .min, preferenceType: self)
                ]
            case .recordingDuration:
                return [
                    TimePreferenceModel(time: nil, timeType: .off, preferenceType: self),
                    TimePreferenceModel(time: 5, timeType: .min, preferenceType: self),
                    TimePreferenceModel(time: 1, timeType: .hours, preferenceType: self),
                    TimePreferenceModel(time: 2, timeType: .hours, preferenceType: self),
                    TimePreferenceModel(time: 3, timeType: .hours, preferenceType: self),
                    TimePreferenceModel(time: 4, timeType: .hours, preferenceType: self),
                    TimePreferenceModel(time: 5, timeType: .hours, preferenceType: self)
                ]
            }
        }
        
    }
    
}
