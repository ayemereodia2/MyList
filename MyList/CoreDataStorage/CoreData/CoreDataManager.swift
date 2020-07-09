//
//  CoreDataManager.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

class CoreDataManager: DataStorageProtocol {
    
    private let coreDataStorage:CoreDataStorage
    init(coreDataStorage:CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    func addTaskUseCase(newUseCase: UserTask, completionHandler: @escaping (Result<UserTask, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { (context) in
            
            do{
                let entity = UserTaskEntity(userTaskQuery: newUseCase, insertInto: context)
                try context.save()
                completionHandler(.success(entity.toDomain()))
            }catch{
                completionHandler(.failure(CoreDataStorageError.saveError))
            }
        }
    }
    
    
}
