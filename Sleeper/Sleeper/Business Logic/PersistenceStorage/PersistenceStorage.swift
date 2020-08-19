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
    
    enum ObjectsDidChange<T: NSManagedObject> {
        case updates(object: [T])
        case inserted(object: [T])
        case deleted(objects: [T])
    }
    
    var recordEntitiesDidChangeCompletion: ((ObjectsDidChange<RecordEntity>) -> Void)?
    
    private lazy var persistentContainer: PersistentContainer = {
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
    
    func fetchAll<T: NSManagedObject>(entity: T.Type) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: entity.className)
        return try! viewContext.fetch(fetchRequest)
    }
    
    func addDidChangeEntityObserving() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(managedObjectContextObjectsDidChange),
                                               name: .NSManagedObjectContextObjectsDidChange,
                                               object: viewContext)
    }
    
    func removeDidChangeEntityObserving() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .NSManagedObjectContextObjectsDidChange,
                                                  object: viewContext)
    }
    
    @objc func managedObjectContextObjectsDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let inserted = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> {
            let newObjects = inserted.compactMap { $0 as? RecordEntity }
            recordEntitiesDidChangeCompletion?(.inserted(object: newObjects))
        }
    }
    
}

