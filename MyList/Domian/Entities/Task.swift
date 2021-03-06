//
//  Task.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation


struct UserTask:Equatable {
    let taskName:String
    let isTaskDone:Bool
    let createdAt:Date
}

extension UserTask {
    init?(entity:UserTaskEntity) {
        taskName = entity.taskName 
        isTaskDone = entity.isTaskDone 
        createdAt = entity.createdAt
    }
}
