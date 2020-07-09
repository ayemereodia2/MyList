//
//  DataStorageProtocol.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

protocol DataStorageProtocol {
    func addTaskUseCase(newUseCase:UserTask, completionHandler:@escaping (Result<UserTask, Error>)->Void)
    
}
