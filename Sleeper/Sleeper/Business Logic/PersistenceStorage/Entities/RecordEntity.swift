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
    
    class func createRecord(_ recordModel: RecordModel, in context: NSManagedObjectContext) -> RecordEntity {
        let record = RecordEntity(context: context)
        record.status = recordModel.status.rawValue
        record.unique = recordModel.unique.uuidString
        record.timer = recordModel.timer
        record.time = TimeEntity.createTime(recordModel.time, in: context)
        return record
    }
    
    class func findRecord(recordModel: RecordModel, in context: NSManagedObjectContext) -> RecordEntity? {
        let request: NSFetchRequest<RecordEntity> = RecordEntity.fetchRequest()
        
        // https://stackoverflow.com/a/52400493/6057764
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(RecordEntity.unique), recordModel.unique.uuidString)
        
        let matches = try? context.fetch(request)
        return matches?.first
    }
}

