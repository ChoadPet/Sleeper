//
//  RecordSummaryPresenter.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol RecordSummaryViewProtocol: class, NavigationInitializable, TableViewInitializable {
    
}

final class RecordSummaryPresenter {
    
    private unowned let view: RecordSummaryViewProtocol
    private let coordinator: Coordinator
    private let record: RecordModel
    
    private(set) var allSection = SectionType.allCases
    private(set) var dataSource: [Section<String>] = [] {
        didSet {
            view.updateTableView()
        }
    }
    
    
    init(view: RecordSummaryViewProtocol,
         coordinator: Coordinator,
         record: RecordModel) {
        
        self.view = view
        self.coordinator = coordinator
        self.record = record
    }
    
    func viewDidLoad() {
        view.initNavigation()
        view.initTableView()
        
        fillDataSource()
    }
    
    // MARK: Private API
    
    private func fillDataSource() {
        dataSource = allSection.map { createSection($0) }
    }
    
    private func createSection(_ section: SectionType) -> Section<String> {
        let items = section.rows.map { createRow($0) }
        return Section<String>(name: "", items: items)
    }
    
    private func createRow(_ row: SectionType.RowType) -> String {
        switch row {
        case .unique:
            return record.unique.uuidString
        case .timer:
            return record.timer
        case .status:
            return record.status.rawValue
        case .created:
            return "Created: \(record.time.created.stringDateInterpolation)"
        case .finished:
            return "Finished: \(record.time.finished.stringDateInterpolation)"
        }
    }
    
}

