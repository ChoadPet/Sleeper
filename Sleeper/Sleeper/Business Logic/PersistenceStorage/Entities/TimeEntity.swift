//
//  TimeEntity.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import CoreData

class TimeEntity: NSManagedObject {
    
    var timeModel: TimeModel {
        return TimeModel(created: created!, finished: finished!)
    }
    
    class func createTime(timeModel: TimeModel, in context: NSManagedObjectContext) throws -> TimeEntity {
        let request: NSFetchRequest<TimeEntity> = TimeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TimeEntity.created), timeModel.created as NSDate)
        
        do {
            let matches = try context.fetch(request)
            if let record = matches.first {
                return record
            }
        } catch {
            throw error
        }
        
        let time = TimeEntity(context: context)
        time.created = timeModel.created
        time.finished = timeModel.finished
        return time
    }
}
