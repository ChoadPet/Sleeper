//
//  HomeViewController.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter: HomePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

}

extension HomeViewController: HomeViewProtocol {
    
}
