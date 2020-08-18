//
//  Constants.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

struct Constants {
    
    static let idle = "Idle"
    static let playing = "Playing"
    static let paused = "Paused"
        
    static let soundTimer = "Sound Timer"
    
    static let play = "Play"
    static let pause = "Pause"
    static let cancel = "Cancel"
    
    static let identifier = "UUID"
    static let timer = "TIMER"
    static let status = "STATUS"
    static let timerInfo = "TIME INFO"
    
    static let uniqueIdentifierTitle = "Unique identifier for this each record."
    static let soundTimerOptionTitle = "Unique identifier for this each record."
    static let timerTitle = "Sound timer option, which was used for this record."
    static let statusTitle = "Cancelled: when user press cancel playing.\nFinished: when sound was finished by Sound Timer option."
    static let timeTitle = "Created: when sound was started.\nFinished: when sound was stopped."
    
    struct Sounds {
        static let natureFileName = "nature"
    }
}
