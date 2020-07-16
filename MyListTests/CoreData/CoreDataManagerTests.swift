//
//  CoreDataManagerTests.swift
//  MyListTests
//
//  Created by Ayemere  Odia  on 14/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import XCTest
@testable import MyList

class CoreDataManagerTests: XCTestCase {

    var sut:CoreDataManager!
    
    override func setUp() {
     sut = CoreDataManager()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoreDataManager_WhenValidDataIsPassed_ShouldReturnExpectedTaskName(){
        // Arrange
        let validTask = UserTask(taskName: "Going for coffee", isTaskDone: false)

         sut = CoreDataManager()
        let expectation = self.expectation(description: "expected to save new valid user tast")
        // Act
        sut.addTaskUseCase(newUseCase: validTask){ response, _ in
            if let result = response {
                
                XCTAssertEqual(result.taskName, "Going for coffee")
                expectation.fulfill()
            }
        }
        // Assert
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testCoreDataManager_WhenInvalidDataIsPassed_ShouldReturnExpectedError(){
        // Arrange 
        let invalidTask = UserTask(taskName: "@ night", isTaskDone: false)
        let expectedError = "Invalid Task Name"
        let expectation = self.expectation(description: "expected to return valid error")
        
        // Act
        sut.addTaskUseCase(newUseCase: invalidTask){_, error in
            if let error = error {
                XCTAssertEqual(error.localizedDescription, expectedError)
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 2)
    }

    
    func testCoreDataManger_WhenGetTaskIsCalled_ShouldReturnTotalNumberTaskGreaterthanZero(){
        
        // Arrange 
        let expectation = self.expectation(description: "total task returned should be greater than 0")
        // Act
        sut.getAllTask(){ tasks in
            
            if let taskCount = tasks {
                XCTAssertTrue(taskCount.count > 0)
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    

}
