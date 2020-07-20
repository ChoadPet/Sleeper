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
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Constants.idle
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont.systemFont(ofSize: 27, weight: .black)
        }
    }
    @IBOutlet weak var soundTimerView: TimerPreferenceView! {
        didSet {
            soundTimerView.roundCorners(radius: 8)
            soundTimerView.backgroundColor = .darkGray
        }
    }
    @IBOutlet weak var recordingDurationView: TimerPreferenceView! {
        didSet {
            recordingDurationView.roundCorners(radius: 8)
            recordingDurationView.backgroundColor = .darkGray
        }
    }
    @IBOutlet weak var primaryButton: UIButton! {
        didSet {
            primaryButton.roundCorners(radius: 8)
            primaryButton.setTitle(Constants.play, for: .normal)
            primaryButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            primaryButton.setTitleColor(.white, for: .normal)
            primaryButton.setBackgroundImage(UIImage(color: UIColor.accent, size: CGSize(width: 1, height: 1)), for: .normal)
        }
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Actions

    @IBAction func primaryButtonAction(_ sender: UIButton) {
        
    }
    
}

extension HomeViewController: HomeViewProtocol {
    
}
