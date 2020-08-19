//
//  HistoryPresenter.swift
//  Sleeper
//
//  Created by user on 17.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol HistoryViewProtocol: class, NavigationInitializable, TableViewInitializable {
    func insert(at indexPaths: [IndexPath])
    
    func displayEmptyState()
    func removeEmptyState()
}

final class HistoryPresenter {
    
    private enum ViewState {
        case empty
        case hasRecords
    }

    private unowned let view: HistoryViewProtocol
    private let coordinator: Coordinator
    private let persistentStorage: PersistenceStorage
    
    private(set) var dataSource: [RecordModel] = [] {
        didSet {
            switch viewState {
            case .empty:
                view.displayEmptyState()
            case .hasRecords:
                view.removeEmptyState()
            }
        }
    }
    
    private var viewState: ViewState {
        return dataSource.isEmpty ? .empty : .hasRecords
    }
    
    
    init(view: HistoryViewProtocol,
         coordinator: Coordinator,
         persistentStorage: PersistenceStorage) {
        
        self.view = view
        self.coordinator = coordinator
        self.persistentStorage = persistentStorage
    }
    
    deinit {
        persistentStorage.removeDidChangeEntityObserving()
    }
    
    func viewDidLoad() {
        view.initNavigation()
        view.initTableView()
        
        dataSource = persistentStorage.fetchAll(entity: RecordEntity.self).map { $0.recordModel }
        
        persistentStorage.addDidChangeEntityObserving()
        persistentStorage.recordEntitiesDidChangeCompletion = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .inserted(let object):
                let records = object.map { $0.recordModel }
                let indexPaths: [IndexPath] = records.map { record in
                    self.dataSource.append(record)
                    return IndexPath(row: self.dataSource.count - 1, section: 0)
                }
                self.view.insert(at: indexPaths)
            default:
                break
            }
        }
    }
    
    func userDidSelect(at indexPath: IndexPath) {
        let record = dataSource[indexPath.row]
        coordinator.recordSummaryViewController(record: record)
    }
    
    func closePressed() {
        coordinator.router.dismissViewController(animated: true)
    }
    

}
