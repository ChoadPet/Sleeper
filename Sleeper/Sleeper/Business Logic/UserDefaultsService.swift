//
//  UserDefaultsService.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

class UserDefaultsService {
    
    enum Keys: String {
        
        case soundTimer
        case recording
    }
    
    private let userDefaults: UserDefaults
    
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    private func save<T>(_ value: T, forKey key: Keys) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    private func value(forKey key: Keys) -> Any? {
        return userDefaults.value(forKey: key.rawValue)
    }
}

extension UserDefaultsService {
    
    var soundTimer: String? {
        get { value(forKey: .soundTimer) as? String }
        set { save(newValue, forKey: .soundTimer) }
    }
    
    var recording: String? {
        get { value(forKey: .recording) as? String }
        set { save(newValue, forKey: .recording) }
    }
    
}
