//
//  RSNavigationController.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class RSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarBorderLineImage(UIImage())
    }

    /// set to `nil` to restore
    /// set to `UIImage()` to remove
    func navigationBarBorderLineImage(_ image: UIImage?) {
        navigationBar.setBackgroundImage(image, for: .default)
        navigationBar.shadowImage = image
    }
    
}
