//
//  RecordSummaryViewController.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class RecordSummaryViewController: UIViewController {
    
    var presenter: RecordSummaryPresenter!

    private let identifier = TitleTableViewCell.className
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

}

// MARK: - TableView delegate

extension RecordSummaryViewController: UITableViewDelegate {
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.allSection[indexPath.section].rows[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.className) as! CustomHeaderView
        view.titleLabel.text = presenter.allSection[section].headerTitle
        view.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.className) as! CustomHeaderView
        view.titleLabel.text = presenter.allSection[section].footerTitle
        view.titleLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return presenter.allSection[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return presenter.allSection[section].footerHeight
    }
}

// MARK: - TableView dataSource

extension RecordSummaryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TitleTableViewCell
        let title = presenter.dataSource[indexPath.section].items[indexPath.row]
        cell.configure(title: title)
        return cell
    }
}

extension RecordSummaryViewController: RecordSummaryViewProtocol {
    
    func initNavigation() {
        navigationItem.title = "Record Summary"
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.separatorColor = .gray
        tableView.registerNib(with: identifier)
        tableView.register(CustomHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: CustomHeaderView.className)
    }
    
    func updateTableView() {
        
    }
    
}
