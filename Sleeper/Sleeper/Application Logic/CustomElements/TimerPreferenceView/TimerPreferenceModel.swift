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
    
    /// Title used for `soundTimer`view title
    var title: String {
        return Constants.soundTimer
    }
    
    /// Name of option, example: `off`, `1 min` etc
    var optionTitle: String {
        guard let time = time else { return timeType.rawValue }
        return "\(time) \(timeType.rawValue)"
    }
    
    /// Titles used in available option for `UIAlertController`
    var optionsTitles: [String] {
        return [
            TimerPreferenceModel(time: nil, timeType: .off),
            TimerPreferenceModel(time: 10, timeType: .sec),
            TimerPreferenceModel(time: 1, timeType: .min),
            TimerPreferenceModel(time: 5, timeType: .min),
            TimerPreferenceModel(time: 10, timeType: .min),
            TimerPreferenceModel(time: 15, timeType: .min),
            TimerPreferenceModel(time: 20, timeType: .min)
            ].map { $0.optionTitle }
    }
    
    var timeInterval: TimeInterval {
        switch timeType {
        case .off:
            return .infinity
        case .min:
            return TimeInterval(self.time! * 60)
        case .sec:
            return TimeInterval(self.time!)
        case .hours:
            return TimeInterval(self.time! * 60 * 60)
        }
    }
    
    
    /// Time is optional,  when `timeType = off`
    init(time: Int?, timeType: TimeType) {
        self.time = time
        self.timeType = timeType
    }
    
    // :(
    /// This init used when user choose some option from popup and when restore from `userDefaults`
    init(string: String?) {
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
    }
    
}

extension TimerPreferenceModel {
    
    enum TimeType: String {
        
        case off
        case min
        case sec
        case hours
    }
}

extension TimerPreferenceModel: Equatable {
    
    static func == (lhs: TimerPreferenceModel, rhs: TimerPreferenceModel) -> Bool {
        return lhs.time == rhs.time &&
            lhs.timeType == rhs.timeType
    }
}
