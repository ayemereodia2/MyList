//
//  ManageTaskUseCaseTests.swift
//  MyListTests
//
//  Created by Ayemere  Odia  on 16/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import XCTest
@testable import MyList
class ManageTaskUseCaseTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    static let userTaskStubs:[UserTask] = {
        let task1 = UserTask(taskName: "Buy Food", isTaskDone: false,createdAt: Date())
        let task2 = UserTask(taskName: "Build first case", isTaskDone: false, createdAt: Date()) 

        return [task1, task2]
    }()
    
    struct UserTaskRepositoryMock: UserTaskRepository {
        var result:UserTask?
        var error:CoreDataStorageError?
        var isError:Bool = false
        var stubTask:[UserTask]?
        
        func addTaskUseCase(newUseCase: UserTask, completionHandler: @escaping (UserTask?, CoreDataStorageError?) -> Void) {
            
            if isError {
             completionHandler(nil,CoreDataStorageError.newTaskError(description: "Error occured"))   
            }else{
                completionHandler(ManageTaskUseCaseTests.userTaskStubs[0],nil)
            }
            
        }
        
        func getAllTask(completionHandler: @escaping ([UserTask]?) -> Void) {
            completionHandler(stubTask)
        }
        
        
    }

    func testManageTaskUseCase_WhenSuccessfullyAddedTask_ShouldReturnDto(){
        
        // Arrange
        let sut = DefaultManageTaskUseCase(taskRepository: UserTaskRepositoryMock(result: ManageTaskUseCaseTests.userTaskStubs[0], error: nil))
        let expectation = self.expectation(description: "should return same DTO")
        
        // Act
        sut.create(newTask: ManageTaskUseCaseTests.userTaskStubs[0]) { (result) in
            
            if case .success(let data) = result {
                XCTAssertEqual(data?.taskName, "Buy Food", "incorrect user-task name was returned")
                expectation.fulfill()
            }
            
        }
            
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testManageTaskUseCase_WhenFailedToAddTask_ShouldReturnTheCorrectErrorMessage(){
        
        // Arrange
        let sut = DefaultManageTaskUseCase(taskRepository: UserTaskRepositoryMock(result: nil, error: CoreDataStorageError.newTaskError(description: "Error occured"), isError: true))
        
        let expectation = self.expectation(description: "should return correct error")
        
        // Act
        sut.create(newTask: ManageTaskUseCaseTests.userTaskStubs[0]) { (result) in
            
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "an error occured", "you returned an incorrect error message")
                expectation.fulfill()
            }
            
        }
            
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testManageTaskCase_WhenGetAllMethodCalled_ShouldReturnUserTasksGreaterThan0(){
        // Arrange
        let sut = DefaultManageTaskUseCase(taskRepository: UserTaskRepositoryMock(result: nil, stubTask:ManageTaskUseCaseTests.userTaskStubs ))
        let expectation = self.expectation(description: "expected to return all created user-task")
        
        // Act
        sut.fetchAllUserTask(){allTask in
            
            if let task = allTask {
                XCTAssertEqual(task[0].taskName, "Buy Food")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
}
