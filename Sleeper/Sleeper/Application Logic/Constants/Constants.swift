//
//  Constants.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

struct Constants {
   
    struct Home {
        static let idle = "Idle"
        static let playing = "Playing"
        static let paused = "Paused"
        static let soundTimer = "Sound Timer"
    }
    
    struct History {
        static let noRecordsYet = "You don't have any records yet."
    }
    
    struct RecordSummary {
        static let identifier = "UUID"
         static let timer = "TIMER"
         static let status = "STATUS"
         static let timerInfo = "TIME INFO"
         
         static let uniqueIdentifierTitle = "Unique identifier for each record."
         static let soundTimerOptionTitle = "Sound timer option, which was used for this record."
         static let statusTitle = "Cancelled: when user press cancel playing.\nFinished: when sound was finished by Sound Timer option."
         static let timeTitle = "Created: when sound was started.\nFinished: when sound was stopped."
        static let created = "Created"
        static let finished = "Finished"
    }
    
    struct ButtonsTitles {
        static let play = "Play"
        static let pause = "Pause"
        static let cancel = "Cancel"
    }
    
    struct NavigationTitles {
        static let history = "History"
        static let recordSummary = "Record Summary"
        static let options = "Options"
    }
    
    struct Sounds {
        static let natureFileName = "nature"
    }
}
