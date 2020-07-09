//
//  CoreDataStorage.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStorageError:Error {
    case readError
    case saveError
    case deleteError
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
    
    
    // MARK: - Core Data Saving support
       func saveContext() {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   // TODO: - Log to Crashlytics
                   assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
               }
           }
       }

       func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
           persistentContainer.performBackgroundTask(block)
       }
}
