//
//  RecordModel.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

struct RecordModel {
    
    enum Status: String {
        case cancelled
        case finished
    }
    
    let unique: UUID
    let status: Status
    let timer: String
    let time: TimeModel
    
}
