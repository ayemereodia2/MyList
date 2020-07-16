//
//  CoreDataManager.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager: UserTaskRepository {
    
    private let coreDataStorage:CoreDataStorage
    init(coreDataStorage:CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    func addTaskUseCase(newUseCase: UserTask, completionHandler: @escaping (UserTask?, CoreDataStorageError?) -> Void) {
        if newUseCase.taskName.isEmpty || isTaskNameValid(taskname: newUseCase.taskName){
            completionHandler(nil,CoreDataStorageError.newTaskError(description: "Invalid Task Name"))
            return
        }            
        
        coreDataStorage.performBackgroundTask { (context) in
            do{
                 let entity = UserTaskEntity(userTaskQuery: newUseCase, insertInto: context) 
                self.deleteResponse(for: entity, in: context)
                
                try context.save()
                completionHandler(entity.toDomain(),nil)

            }catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
            
    }
    
    func getAllTask(completionHandler: @escaping([UserTask]?)->Void){
        
        coreDataStorage.performBackgroundTask { (context) in
            do{
                let request:NSFetchRequest<UserTaskEntity> = NSFetchRequest(entityName: "UserTaskEntity")
                let requestEntity = try context.fetch(request)
                let response = requestEntity.compactMap{ result in 
                    return UserTask.init(entity: result)}
                print(response)
                completionHandler(response)
                
            }catch{
                completionHandler([UserTask]())
            }
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
    
    private func fetchRequest(task:UserTaskEntity)-> NSFetchRequest<UserTaskEntity> {
        
        let request:NSFetchRequest<UserTaskEntity> = UserTaskEntity.fetchRequest()

        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(UserTaskEntity.taskName), task.taskName ?? "xc827vc",
                                        #keyPath(UserTaskEntity.isTaskDone), task.isTaskDone)
        return request
    }
    
    private func deleteResponse(for requestDto: UserTaskEntity, in context: NSManagedObjectContext) {
        let request = fetchRequest(task: requestDto)

        do {
            if let result = try context.fetch(request).first {
                print(request)
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
    
}
    

