//
//  TaskListViewModel.swift
//  MyList
//
//  Created by Ayemere  Odia  on 18/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

protocol TaskListViewModelInput {
    func didAdd(task newTask:String)
    func didCompleteTask()
    func didEdit(task editedTask:UserTask)
}

protocol TaskListViewModelOutput {
    var toDoItems:[TaskListItemViewModel] { get }
}

protocol TaskListViewModel:TaskListViewModelInput,TaskListViewModelOutput{}


final class DefaultTaskListViewModel:TaskListViewModel {
    
    private let userTaskUseCase: ManageTaskUseProtocol
    
    init(userTaskUseCase:ManageTaskUseProtocol) {
        self.userTaskUseCase = userTaskUseCase
    }
    
    
    func didAdd(task newTask: String) {
        
        self.userTaskUseCase.create(newTask: UserTask(taskName: newTask, isTaskDone: false, createdAt: Date())){ [weak self] latestTask in
            if case .success(let data) = latestTask, let newData = data {
                let listItem = TaskListItemViewModel.init(task: newData)
                guard let strongSelf = self else { return }
                strongSelf.toDoItems.append(listItem)
            }
        }
    }
    
    func didCompleteTask() {
        
    }
    
    func didEdit(task editedTask: UserTask) {
        
    }
    
    var toDoItems: [TaskListItemViewModel]  = []
    
    
}
