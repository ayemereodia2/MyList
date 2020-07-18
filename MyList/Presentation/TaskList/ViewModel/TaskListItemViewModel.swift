//
//  TaskListItemViewModel.swift
//  MyList
//
//  Created by Ayemere  Odia  on 18/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

struct TaskListItemViewModel {
    let taskTitle:String
    let taskDate:String
}

extension TaskListItemViewModel {
    init(task:UserTask){
        taskTitle = task.taskName
        taskDate = task.createdAt.debugDescription //no formating
    }
}
