//
//  EmptyView.swift
//  Sleeper
//
//  Created by user on 19.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class EmptyView: RSBaseView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var messageLabel: UILabel! {
        didSet {
            messageLabel.textColor = .darkGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        }
    }
   
    
    override func customInit() {
        super.customInit()
        
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func configure(title: String) {
        messageLabel.text = title
    }
}
