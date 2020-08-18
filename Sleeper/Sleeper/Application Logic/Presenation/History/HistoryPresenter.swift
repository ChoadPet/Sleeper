//
//  HistoryPresenter.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol HistoryViewProtocol: class, NavigationInitializable, TableViewInitializable {
    func updateTableView()
}

final class HistoryPresenter {

    private unowned let view: HistoryViewProtocol
    private let coordinator: Coordinator
    private let persistentStorage: PersistenceStorage
    
    private(set) var dataSource: [RecordModel] = [] {
        didSet {
            view.updateTableView()
        }
    }
    
    
    init(view: HistoryViewProtocol,
         coordinator: Coordinator,
         persistentStorage: PersistenceStorage) {
        
        self.view = view
        self.coordinator = coordinator
        self.persistentStorage = persistentStorage
    }
    
    func viewDidLoad() {
        view.initNavigation()
        view.initTableView()
        
        dataSource = persistentStorage.fetchRecords().map { $0.recordModel }
    }
    
    func closePressed() {
        coordinator.router.dismissViewController(animated: true)
    }
    
    func userDidSelect(at indexPath: IndexPath) {
        
    }
}
