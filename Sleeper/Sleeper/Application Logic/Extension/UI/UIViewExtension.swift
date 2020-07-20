//
//  UIViewExtension.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Rounding all corners
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func addTapGestureRecognizer(target: Any, selector: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: selector)
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
}
