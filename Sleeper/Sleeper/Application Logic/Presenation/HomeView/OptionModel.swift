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
    let preference: TimePreferenceModel.PreferenceType
    var currentSelectedPreference: TimePreferenceModel
    
    var availablePreferencesTitlesInHumanFormat: [String] {
        return preference.preferences.map { $0.timeAndTimeType }
    }
    
    
    init(title: String, preferences: TimePreferenceModel.PreferenceType, currentSelectedPreference: TimePreferenceModel) {
        self.title = title
        self.preference = preferences
        self.currentSelectedPreference = currentSelectedPreference
    }

}
