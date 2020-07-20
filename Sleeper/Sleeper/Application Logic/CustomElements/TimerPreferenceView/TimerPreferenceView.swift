//
//  TimerPreferenceView.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class TimerPreferenceView: RSBaseView {
    
    @IBOutlet private var contentView: UIView!
    
    override var shouldHighlightView: Bool {
        return true
    }
    
    override var viewToHighlight: UIView? {
        return self
    }

    override func customInit() {
        super.customInit()
        
        contentView.frame = bounds
        contentView.backgroundColor = .clear
        addSubview(contentView)
    }
    

}
