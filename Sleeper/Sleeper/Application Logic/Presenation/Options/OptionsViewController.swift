//
//  OptionsViewController.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    var presenter: OptionsPresenter!
    
    private let identifier = TitleTableViewCell.className
    private let heightForRow: CGFloat = 44
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    // MARK: Actions
    
    @objc private func closeAction(_ sender: UIBarButtonItem) {
        presenter.closePressed()
    }
    
}

extension OptionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
}

extension OptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TitleTableViewCell
        let object = presenter.options[indexPath.row]
        cell.configure(title: object.title, isSelected: object.isSelected)
        cell.backgroundColor = .systemGray6
        return cell
    }
}

extension OptionsViewController: OptionsViewProtocol {
    
    func initNavigation() {
        navigationItem.title = Constants.NavigationTitles.options
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeAction))
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let footerHeader = UIView()
        let size = CGSize(width: tableView.frame.width, height: 32)
        footerHeader.frame = CGRect(origin: .zero, size: size)
        tableView.tableHeaderView = footerHeader
        tableView.tableFooterView = footerHeader
        tableView.registerNib(with: identifier)
    }
    
    func updateTableView() {
        
    }
}
