//
//  CoreDataStorage.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStorageError:LocalizedError,Equatable {
    
    case readError
    case saveError
    case deleteError
    case newTaskError(description:String)
    
    var errorDescription: String?{
        switch self {
        case .newTaskError(let description):
            return description
        case .readError, .saveError, .deleteError :
            return ""
        }
    }
}

final class CoreDataStorage {
    
    private init(){}
    
    static let shared = CoreDataStorage()
    
    // MARK: - Core Data Stack
    private lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        container.loadPersistentStores {_, error in 
            if let error = error as NSError? {
                // Log to Crashlytics
                assertionFailure("CoreDataStorage unresolved error \(error), \(error.userInfo)")
                
            }
        }
        
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    
    
    // MARK: - Core Data Saving support
       func saveContext() {
           //let context = persistentContainer.viewContext
        if self.context.hasChanges {
               do {
                try self.context.save()
               } catch {
                   // TODO: - Log to Crashlytics
                   assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
               }
           }
       }
    
    func get(){
        do{
            let request:NSFetchRequest<UserTaskEntity> = NSFetchRequest(entityName: "UserTaskEntity")
            guard let result = try self.context.fetch(request) as? [UserTaskEntity] else {return}
            
        }catch(let error){
            print(error)
        }
    }

       func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
           persistentContainer.performBackgroundTask(block)
       }
    
    
    
}
