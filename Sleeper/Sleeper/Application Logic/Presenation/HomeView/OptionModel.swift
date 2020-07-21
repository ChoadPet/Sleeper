//
//  OptionModel.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation


final class OptionModel {
    
    enum Option {
        
        case off
        case min(Int)
        case hour(Int)
        
        var stringInterpolation: String {
            switch self {
            case .off: return "Off"
            case .min(let minutes): return "\(minutes) min"
            case .hour(let hours): return "\(hours) hours"
            }
        }
        
    }
    
    let title: String
    let availableOptions: [Option]
    var currentSelectedOption: Option
    
    
    init(title: String, availableOptions: [Option], currentSelectedOption: Option) {
        self.title = title
        self.availableOptions = availableOptions
        self.currentSelectedOption = currentSelectedOption
    }
    
}
