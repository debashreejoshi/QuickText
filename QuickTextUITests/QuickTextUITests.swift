//
//  QuickTextUITests.swift
//  QuickTextUITests
//
//  Created by Debashree Joshi on 28/11/21.
//

import XCTest

class QuickTextUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
    func testAddMessage() {
        let testMessageToAdd = "UI TEST MESSAGE"
        
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Messages"].buttons["add"].tap()
        
        app.textViews.element.typeText(testMessageToAdd)
        
        app.buttons["Save"].tap()
        
        let addedMessage = app.tables.cells.staticTexts[testMessageToAdd]
        
                XCTAssertTrue(addedMessage.exists)
    }
    
    func testAddMessageValidation() {
        
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Messages"].buttons["add"].tap()
        app.buttons["Save"].tap()
        app.alerts["Error"].scrollViews.otherElements.buttons["OK"].tap()
        
    }
}
