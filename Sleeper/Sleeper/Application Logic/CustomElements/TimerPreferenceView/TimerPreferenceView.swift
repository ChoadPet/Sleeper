//
//  TimerPreferenceView.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class TimerPreferenceView: RSBaseView {
    
    @IBOutlet private var contentView: UIView! {
        didSet { contentView.backgroundColor = .clear }
    }
    
    @IBOutlet private weak var chevronImageView: UIImageView! {
        didSet { chevronImageView.tintColor = .accent }
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .accent
            descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
    
    override var shouldHighlightView: Bool {
        return true
    }
    
    override var viewToHighlight: UIView? {
        return contentView
    }

    override func customInit() {
        super.customInit()
        
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func configure(_ model: TimePreferenceModel) {
        titleLabel.text = model.preferenceType.title
        descriptionLabel.text = model.timeAndTimeType
    }
    
}
