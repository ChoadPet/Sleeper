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
    
    private let identifier = RecordTableViewCell.className
    private let heightForRow: CGFloat = 80
    
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

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = presenter.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RecordTableViewCell
        cell.configure(record: record)
        return cell
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
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
}
