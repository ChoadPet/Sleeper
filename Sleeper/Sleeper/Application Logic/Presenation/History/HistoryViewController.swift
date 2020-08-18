//
//  HistoryViewController.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    var presenter: HistoryPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    // MARK: Actions
    
    @objc private func closeAction(_ sender: UIBarButtonItem) {
        presenter.closePressed()
    }

}

extension HistoryViewController: HistoryViewProtocol {
    
    func initNavigation() {
        let image = UIImage(systemName: "xmark")
        let barItem = UIBarButtonItem(image: image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(closeAction))
        navigationItem.rightBarButtonItem = barItem
        navigationItem.title = "History"
    }
}
