//
//  UserTaskEntity+CoreDataProperties.swift
//  MyList
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//
//

import Foundation
import CoreData


extension UserTaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserTaskEntity> {
        return NSFetchRequest<UserTaskEntity>(entityName: "UserTaskEntity")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var isTaskDone: Bool

}
