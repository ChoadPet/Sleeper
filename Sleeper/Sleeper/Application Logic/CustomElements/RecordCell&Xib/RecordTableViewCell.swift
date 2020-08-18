//
//  RecordTableViewCell.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
            titleLabel.textColor = UIColor.accent
        }
    }
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(record: RecordModel) {
        titleLabel.text = record.timer
        statusLabel.text = record.status.rawValue
        switch record.status {
        case .finished:
            statusLabel.textColor = .systemGreen
        case .cancelled:
            statusLabel.textColor = .systemRed
        }
    }
    
}
