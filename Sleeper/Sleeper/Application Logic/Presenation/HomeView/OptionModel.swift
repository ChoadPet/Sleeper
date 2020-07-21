//
//  OptionModel.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

final class OptionModel {
        
    let title: String
    let preference: TimerPreferenceModel.PreferenceType
    var currentSelectedPreference: TimerPreferenceModel
    
    var availablePreferencesTitles: [String] {
        return preference.preferences.map { $0.timeAndTimeType }
    }
    
    
    init(title: String, preferences: TimerPreferenceModel.PreferenceType, currentSelectedPreference: TimerPreferenceModel) {
        self.title = title
        self.preference = preferences
        self.currentSelectedPreference = currentSelectedPreference
    }

}
