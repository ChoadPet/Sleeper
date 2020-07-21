//
//  TimeViewController.swift
//  Sleeper
//
//  Created by user on 21.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    var presenter: TimePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension TimeViewController: TimeViewProtocol {
    
}
