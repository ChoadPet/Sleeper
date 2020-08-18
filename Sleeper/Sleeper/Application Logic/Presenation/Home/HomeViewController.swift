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
            soundTimerView.roundCorners(radius: .custom(radius: 8))
            soundTimerView.addTapGestureRecognizer(target: self, selector: #selector(soundTimerAction))
            soundTimerView.backgroundColor = .darkGray
        }
    }
    @IBOutlet weak var primaryButton: UIButton! {
        didSet {
            primaryButton.setTitle(Constants.play, for: .normal)
            primaryButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            primaryButton.setTitleColor(.white, for: .normal)
            primaryButton.setBackgroundImage(UIImage(color: UIColor.accent, size: CGSize(width: 1, height: 1)), for: .normal)
        }
    }
    @IBOutlet weak var secondaryButton: UIButton! {
        didSet {
            secondaryButton.setTitle(Constants.cancel, for: .normal)
            secondaryButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            secondaryButton.setTitleColor(.white, for: .normal)
            secondaryButton.setBackgroundImage(UIImage(color: UIColor.systemGray5, size: CGSize(width: 1, height: 1)), for: .normal)
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        primaryButton.roundCorners(radius: .circle)
        secondaryButton.roundCorners(radius: .circle)
    }
    
    // MARK: Actions
    
    @IBAction func primaryButtonAction(_ sender: UIButton) {
        presenter.primaryButtonPressed()
    }
    
    @IBAction func secondaryButtonAction(_ sender: UIButton) {
        presenter.secondaryButtonPressed()
    }
    
    @objc private func soundTimerAction(_ sender: UITapGestureRecognizer) {
        presenter.soundTimerPressed()
    }
    
    @objc private func historyAction(_ sender: UIBarButtonItem) {
        presenter.historyPressed()
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func initNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.badge.person.crop"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(historyAction))
    }
    
    func configureSoundTimerView(_ model: TimerPreferenceModel) {
        soundTimerView.configure(model)
    }
    
    func changePrimaryButton(_ title: String) {
        primaryButton.setTitle(title, for: .normal)
    }
    
    func changeTitleLabel(_ title: String) {
        titleLabel.text = title
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
