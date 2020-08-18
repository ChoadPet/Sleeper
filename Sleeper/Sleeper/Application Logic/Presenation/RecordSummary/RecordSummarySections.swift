//
//  RecordSummarySections.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

extension RecordSummaryPresenter {
    
    enum SectionType: Int, CaseIterable {
        
        enum RowType {
            
            case unique
            case timer
            case status
            case created
            case finished
            
            var height: CGFloat {
                return 44
            }
        }
        
        case identifier
        case timer
        case status
        case time
        
        var headerTitle: String {
            switch self {
            case .identifier:
                return "UUID"
            case .timer:
                return "TIMER"
            case .status:
                return "STATUS"
            case .time:
                return "TIME INFO"
            }
        }
        
        var footerTitle: String {
            switch self {
            case .identifier:
                return "Unique identifier for this each record."
            case .timer:
                return "Sound timer option, which was used for this record."
            case .status:
                return "Cancelled: when user press cancel playing.\nFinished: when sound was finished by Sound Timer option."
            case .time:
                return "Created: when sound was started.\nFinished: when sound was stopped."
            }
        }
        
        var headerHeight: CGFloat {
            return 32
        }
        
        var footerHeight: CGFloat {
            switch self {
            case .status:
                return 60
            case .time:
                return 40
            default:
                return 32
            }
        }
        
        var rows: [RowType] {
            switch self {
            case .identifier:
                return [.unique]
            case .timer:
                return [.timer]
            case .status:
                return [.status]
            case .time:
                return [.created, .finished]
            }
        }
    }
}
