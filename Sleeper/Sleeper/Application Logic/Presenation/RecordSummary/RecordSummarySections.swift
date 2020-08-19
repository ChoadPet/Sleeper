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
                return Constants.RecordSummary.identifier
            case .timer:
                return Constants.RecordSummary.timer
            case .status:
                return Constants.RecordSummary.status
            case .time:
                return Constants.RecordSummary.timerInfo
            }
        }
        
        var footerTitle: String {
            switch self {
            case .identifier:
                return Constants.RecordSummary.uniqueIdentifierTitle
            case .timer:
                return Constants.RecordSummary.soundTimerOptionTitle
            case .status:
                return Constants.RecordSummary.statusTitle
            case .time:
                return Constants.RecordSummary.timeTitle
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
