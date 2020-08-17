//
//  UIViewControllerExtension.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func initViewControllerFromNib() -> Self {
        return self.init(nibName: self.self.className, bundle: nil)
    }
}
