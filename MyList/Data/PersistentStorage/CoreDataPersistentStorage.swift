//
//  CoreDataPersistentStorage.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

final class CoreDataPersistentStorage {
    
    private var coreDataStorage:UserTaskRepository
    
    init(coreDataStorage:UserTaskRepository) {
        self.coreDataStorage = coreDataStorage
    }
    
    func addTaskUseCase(newUseCase:UserTask,completionHandler: @escaping (UserTask?, CoreDataStorageError?)->Void){
        
        coreDataStorage.addTaskUseCase(newUseCase: newUseCase, completionHandler: completionHandler)
    }
    
    func getSavedTasks(completionHandler:@escaping([UserTask]?)->Void){
        
        coreDataStorage.getAllTask(completionHandler: completionHandler)
    }

}
