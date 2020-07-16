//
//  ManageTaskUseCase.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation


protocol ManageTaskUseProtocol {
    
    func create(newTask:UserTask,  completionHandler: @escaping (Result<UserTask?, Error>) -> Void)
    
}

final class DefaultManageTaskUseCase {
    
    private let taskRepository:UserTaskRepository
    
    init(taskRepository:UserTaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func create(newTask:UserTask,  completionHandler: @escaping (Result<UserTask?, Error>) -> Void){
        
        self.taskRepository.addTaskUseCase(newUseCase: newTask) { (task, error) in
            //guard let strongSelf = self else { return }
            if let latestTask = task {
                
                completionHandler(.success(latestTask))
                return
            }else {
            completionHandler(.failure(CoreDataStorageError.newTaskError(description: "an error occured")))
            }
        }
    }
}
