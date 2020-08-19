//
//  UserDefaultsService.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol UserSaveable {
    func set(_ value: Any?, forKey defaultName: String)
    func value(forKey key: String) -> Any?
}

class UserDefaultsService {
    
    enum Keys: String {
        case soundTimer
    }
    
    private let userDefaults: UserSaveable
    
    
    init(userSaveable: UserSaveable = UserDefaults.standard) {
        self.userDefaults = userSaveable
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
}

extension UserDefaults: UserSaveable {
    
}
