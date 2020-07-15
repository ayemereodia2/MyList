//
//  CoreDataManager.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import CoreData
class CoreDataManager: DataStorageProtocol {
    
    private let coreDataStorage:CoreDataStorage
    init(coreDataStorage:CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    func addTaskUseCase(newUseCase: UserTask, completionHandler: @escaping (UserTask?, CoreDataStorageError?) -> Void) {
        if newUseCase.taskName.isEmpty || isTaskNameValid(taskname: newUseCase.taskName){
            completionHandler(nil,CoreDataStorageError.newTaskError(description: "Invalid Task Name"))
            return
        }            
           
        let entity = UserTaskEntity(userTaskQuery: newUseCase, insertInto: coreDataStorage.context)
            coreDataStorage.saveContext()
            completionHandler(entity.toDomain(),nil)
            
    }
    
    func getAllTask(completionHandler: @escaping([UserTask]?)->Void){
            do{
               
                   let request:NSFetchRequest<UserTaskEntity> = NSFetchRequest(entityName: "UserTaskEntity")
                 let result = try self.coreDataStorage.context.fetch(request)
                let response = result.compactMap{ result in 
                    return UserTask.init(entity: result)
                }                    
            completionHandler(response)
            }catch(let error){
                print(error)
            }
        
    }
    
    
    private func isTaskNameValid(taskname:String)->Bool{
        
        var isValid = false

        if let _ = taskname.range(of: ".*[^A-Za-z0-9 ]+.*", options: .regularExpression)  {
            isValid = true
        }
        
        
        if taskname.count < 5 || taskname.count > 50 {
            isValid = true
        }
        return isValid
    }
    
}
