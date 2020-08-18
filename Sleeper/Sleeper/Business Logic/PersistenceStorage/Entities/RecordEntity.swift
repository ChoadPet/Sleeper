//
//  RecordEntity.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import CoreData

class RecordEntity: NSManagedObject {
    
    var recordModel: RecordModel {
        return RecordModel(unique: UUID(uuidString: unique!)!,
                           status: RecordModel.Status(rawValue: status!)!,
                           timer: timer!,
                           time: time!.timeModel)
    }
    
    class func createRecord(recordModel: RecordModel, in context: NSManagedObjectContext) throws -> RecordEntity {
        let request: NSFetchRequest<RecordEntity> = RecordEntity.fetchRequest()
        
        // https://stackoverflow.com/a/52400493/6057764
        request.predicate = NSPredicate(format: "unique == %K", #keyPath(RecordEntity.unique), recordModel.unique.uuidString)
        
        do {
            let matches = try context.fetch(request)
            if let record = matches.first {
                return record
            }
        } catch {
            throw error
        }
        
        let record = RecordEntity(context: context)
        record.status = recordModel.status.rawValue
        record.unique = recordModel.unique.uuidString
        record.timer = recordModel.timer
        record.time = try? TimeEntity.createTime(timeModel: recordModel.time, in: context)
        return record
    }
}

