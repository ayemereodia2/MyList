//
//  PersistentStorageTests.swift
//  MyListTests
//
//  Created by Ayemere  Odia  on 09/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import XCTest
@testable import MyList

class PersistentStorageTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    static let stubTasks:[UserTask] = {
       let stubTask1 = UserTask(taskName: "Task 1 will finish Monday", isTaskDone: false, createdAt: Date())
        let stubTask2 = UserTask(taskName: "Review to be done Friday", isTaskDone: false, createdAt: Date())
        
        return[stubTask1, stubTask2]
    }()
    
    struct MockCoreDataManager : UserTaskRepository {
        
         let stubTask = UserTask(taskName: "Task 1 will finish Monday", isTaskDone: false, createdAt: Date())
        var isError:Bool?
        
        func addTaskUseCase(newUseCase: UserTask, completionHandler: @escaping (UserTask?, CoreDataStorageError?) -> Void) {
            
            if let _ =  isError {
                completionHandler(nil,CoreDataStorageError.saveError)
                return
            }
            completionHandler(stubTask,nil)
            return
        }
        
        func getAllTask(completionHandler: @escaping ([UserTask]?) -> Void) {
            
            print(PersistentStorageTests.stubTasks)
            completionHandler(PersistentStorageTests.stubTasks)
        }
        
        
    }

    func testCoreDataPersistentStorage_WhenAddedaValidDataEntityIsPassed_ShouldReturnNotNil(){
        
        // Arrange
        let newTask = UserTask(taskName: "Task 1 will finish Monday", isTaskDone: false, createdAt: Date())
        let expectation = self.expectation(description: "expected to save new user task")
        let coreDataMan = MockCoreDataManager()
        let sut = CoreDataPersistentStorage(coreDataStorage: coreDataMan)
        // Act
        sut.addTaskUseCase(newUseCase:newTask){response,_ in
            if let data = response {
                XCTAssertEqual(data.taskName,newTask.taskName)
                expectation.fulfill()
            }
        }
        // Assert
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testCoreDataPersistentStorage_WhenErrorOccurs_ShouldReturnValidErrorMessage(){
        
        // Arrange
        let newTask = UserTask(taskName: "Task 1 will finish Monday", isTaskDone: false, createdAt: Date())
        let expectation = self.expectation(description: "expected to return correct error message")
        var coreDataMan = MockCoreDataManager()
        coreDataMan.isError = true
        let sut = CoreDataPersistentStorage(coreDataStorage: coreDataMan)
        // Act
        sut.addTaskUseCase(newUseCase:newTask){_, error in
            if let error = error {
                XCTAssertEqual(error.localizedDescription,CoreDataStorageError.saveError.localizedDescription)
                expectation.fulfill()
            }
        }
        // Assert
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testCoreDataPersistentStorage_WhenGetTaskisCalled_ShouldReturnValuesCountGreaterThan0(){
        // Arrange
        let coreDataMan = MockCoreDataManager()
        let sut = CoreDataPersistentStorage(coreDataStorage: coreDataMan)
        let expectation = self.expectation(description: "expected task count must be greater than 0")
        // Act
        sut.getSavedTasks(){tasks in 
            if let tasks = tasks {
                XCTAssertTrue(tasks.count > 0)
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 5)
    }

}
