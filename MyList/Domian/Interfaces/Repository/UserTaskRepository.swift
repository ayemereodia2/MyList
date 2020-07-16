//
//  ManageTaskProtocol.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

protocol UserTaskRepository {
    
    func addTaskUseCase(newUseCase:UserTask, completionHandler:@escaping (UserTask?, CoreDataStorageError?)->Void)
    
    func getAllTask(completionHandler: @escaping([UserTask]?)->Void)
}
