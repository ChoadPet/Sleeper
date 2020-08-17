//
//  UIViewExtension.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

extension UIView {
    
    enum Radius {
        
        /// Be aware, that `.circle` option should be set, when final size of view is set
        case circle
        case custom(radius: CGFloat)
    }
    
    /// Rounding all corners.
    func roundCorners(radius: Radius) {
        switch radius {
        case .circle:
            layer.cornerRadius = frame.height / 2
        case .custom(let radius):
            layer.cornerRadius = radius
        }
        clipsToBounds = true
    }
    
    func addTapGestureRecognizer(target: Any, selector: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: selector)
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
}
