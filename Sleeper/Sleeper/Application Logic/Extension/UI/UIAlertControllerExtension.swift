//
//  UIAlertControllerExtension.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func addActions(_ actions: [UIAlertAction]) {
        for action in actions {
            addAction(action)
        }
    }
    
}
