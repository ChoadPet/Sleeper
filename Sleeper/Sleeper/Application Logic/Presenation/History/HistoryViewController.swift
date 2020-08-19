//
//  HistoryViewController.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    var presenter: HistoryPresenter!
    
    private let identifier = RecordTableViewCell.className
    private let heightForRow: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    // MARK: Actions
    
    @objc private func closeAction(_ sender: UIBarButtonItem) {
        presenter.closePressed()
    }
    
}

// MARK: - TableView delegate

extension HistoryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelect(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
}

// MARK: - TableView dataSource

extension HistoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = presenter.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RecordTableViewCell
        cell.configure(record: record)
        return cell
    }
}

extension HistoryViewController: HistoryViewProtocol {
    
    func initNavigation() {
        navigationItem.title = Constants.NavigationTitles.history
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeAction))
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerNib(with: RecordTableViewCell.className)
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func insert(at indexPaths: [IndexPath]) {
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func displayEmptyState() {
        let view = EmptyView()
        view.configure(title: Constants.History.noRecordsYet)
        tableView.backgroundView = view
    }
    
    func removeEmptyState() {
        tableView.backgroundView = nil
    }
}
