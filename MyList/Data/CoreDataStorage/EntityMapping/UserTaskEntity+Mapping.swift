//
//  UserTaskEntity+Mapping.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import CoreData

extension UserTaskEntity {
    convenience init(userTaskQuery: UserTask, insertInto context: NSManagedObjectContext) {
           self.init(context: context)
        taskName = userTaskQuery.taskName
        isTaskDone = userTaskQuery.isTaskDone
        createdAt = userTaskQuery.createdAt
        
       }
}

extension UserTaskEntity {
    func toDomain() -> UserTask {
        print(taskName,isTaskDone,createdAt)
        return .init(taskName: taskName , isTaskDone: isTaskDone, createdAt: createdAt)
    }
}
