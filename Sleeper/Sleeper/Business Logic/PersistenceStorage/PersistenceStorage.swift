//
//  PersistanceStorage.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import CoreData
import UIKit

final class PersistenceStorage {
    
    lazy var persistentContainer: PersistentContainer = {
        let container = PersistentContainer(name: "Sleeper")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    init() {
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification,
                                               object: nil,
                                               queue: nil,
                                               using: { [weak self] _ in self?.persistentContainer.saveContext() })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @discardableResult
    func createRecord(_ recordModel: RecordModel) -> RecordEntity {
        let record = RecordEntity.createRecord(recordModel, in: viewContext)
        persistentContainer.saveContext()
        return record
    }
    
    @discardableResult
    func removeRecord(_ recordModel: RecordModel) -> RecordEntity? {
        if let record = RecordEntity.findRecord(recordModel: recordModel, in: viewContext) {
            viewContext.delete(record)
            persistentContainer.saveContext()
            return record
        }
        return nil
    }
    
    func fetchRecords() -> [RecordEntity] {
        return try! viewContext.fetch(RecordEntity.fetchRequest())
    }
    
}

