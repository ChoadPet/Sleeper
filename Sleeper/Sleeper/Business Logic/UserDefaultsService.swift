//
//  UserDefaultsService.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

private enum Keys: String {
    
    case soundTimer
    case recordingDuration
}

class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    
    private init() { }
    
    private func save<T>(_ value: T, forKey key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    private func value(forKey key: Keys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
}

extension UserDefaultsService {
    
    var soundTimer: String? {
        get { value(forKey: .soundTimer) as? String }
        set { save(newValue, forKey: .soundTimer) }
    }
    
    var recordingDuration: String? {
        get { value(forKey: .recordingDuration) as? String }
        set { save(newValue, forKey: .recordingDuration) }
    }
    
}
