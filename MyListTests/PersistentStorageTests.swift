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

    func testCoreDataPersistentStorage_WhenAddedaValidDataEntityIsPassed_ShouldReturnTrue(){
        
        // Arrange
        let newTask = UserTask(taskName: "Task 1", isTaskDone: false)
        let expectation = self.expectation(description: "expected to save new user task")
        let coreDataMan = CoreDataManager()
        let sut = CoreDataPersistentStorage(coreDataStorage: coreDataMan)
        // Act
        sut.addTaskUseCase(newUseCase:newTask){ result in
            if case .success(let data) = result {
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
        }
        // Assert
        self.wait(for: [expectation], timeout: 5)
    }
    

}
