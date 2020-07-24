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
            soundTimerView.addTapGestureRecognizer(target: self, selector: #selector(soundTimerAction))
            soundTimerView.backgroundColor = .darkGray
        }
    }
    @IBOutlet weak var recordingDurationView: TimerPreferenceView! {
        didSet {
            recordingDurationView.roundCorners(radius: 8)
            recordingDurationView.addTapGestureRecognizer(target: self, selector: #selector(recordingDurationAction))
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

        presenter.viewDidLoad()
    }
    
    // MARK: Actions

    @IBAction func primaryButtonAction(_ sender: UIButton) {
        presenter.primaryButtonPressed()
    }
    
    @objc private func soundTimerAction(_ sender: UITapGestureRecognizer) {
        presenter.soundTimerPressed()
    }
    
    @objc private func recordingDurationAction(_ sender: UITapGestureRecognizer) {
        presenter.recordingDurationPressed()
    }
    
}

extension HomeViewController: HomeViewProtocol {
    
    func configureSoundTimerView(_ model: TimerPreferenceModel) {
        soundTimerView.configure(model)
    }
    
    func configureRecordingDurationView(_ model: TimerPreferenceModel) {
        recordingDurationView.configure(model)
    }
    
    func changePrimaryButton(_ title: String) {
        primaryButton.setTitle(title, for: .normal)
    }
    
    func showAlert(title: String, actionsTitles: [String], completion: ((String) -> Void)?) {
        let alert = RSAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let optionsActions = actionsTitles.map { // :(
            UIAlertAction(title: $0, style: .default) { action in
                completion?(action.title!)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addActions(optionsActions)
        present(alert, animated: true)
    }
    
}
