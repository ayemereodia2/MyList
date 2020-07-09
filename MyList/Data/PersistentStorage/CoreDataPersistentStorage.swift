//
//  CoreDataPersistentStorage.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

final class CoreDataPersistentStorage {
    
    private var coreDataStorage:DataStorageProtocol
    
    init(coreDataStorage:DataStorageProtocol) {
        self.coreDataStorage = coreDataStorage
    }
    
    func addTaskUseCase(newUseCase:UserTask,completionHandler: @escaping (Result<UserTask, Error>)->Void){
        
        coreDataStorage.addTaskUseCase(newUseCase: newUseCase, completionHandler: completionHandler)
    }
}
