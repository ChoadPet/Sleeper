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
    
    class func createTime(_ timeModel: TimeModel, in context: NSManagedObjectContext) -> TimeEntity {
        let time = TimeEntity(context: context)
        time.created = timeModel.created
        time.finished = timeModel.finished
        return time
    }
    
    class func findTime(_ timeModel: TimeModel, in context: NSManagedObjectContext) -> TimeEntity? {
        let request: NSFetchRequest<TimeEntity> = TimeEntity.fetchRequest()
        
        // https://stackoverflow.com/a/52400493/6057764
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TimeEntity.created), timeModel.created as NSDate)
        
        let matches = try? context.fetch(request)
        return matches?.first
    }
}
