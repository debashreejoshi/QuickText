//
//  StoreManagerTests.swift
//  QuickTextTests
//
//  Created by Debashree Joshi on 28/11/21.
//

import XCTest
@testable import QuickText

class StoreManagerTests: XCTestCase {

    private var manager: StoreManager!
    
    
    override func setUpWithError() throws {
        manager = StoreManager(userDefault: MockUserDefaults())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        manager = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddMessages() {
        let message = "Message"
                
        manager.addMessage(message)
        
        let count = manager.getMessages().count
        XCTAssertEqual(count, 1)
    }
    
    func testUpdateMessages() {
        let messages = ["message1" , "message2"]
        
        manager.updateMessages(messages)
        
        XCTAssertEqual(messages, manager.getMessages())
    }
    
    func testGetMessages() {
        let message = "Message"
        manager.addMessage(message)
        
        let messages = manager.getMessages()
        
        XCTAssertEqual([message], messages)
    }
    
    func testUpdateMessage() {
        let message1 = "Message 1"
        let message2 = "Message 2"
        let message3 = "Message 3"
                
        manager.addMessage(message1)
        manager.addMessage(message2)
        
        manager.updateMessage(index: 1, newMessage: message3)

        XCTAssertEqual([message1, message3], manager.getMessages())
    }
    
    func testDeleteMessage() {
        let message1 = "Message 1"
        let message2 = "Message 2"
                
        manager.addMessage(message1)
        manager.addMessage(message2)
        
        manager.deleteMessage(index: 1)

        XCTAssertEqual([message1], manager.getMessages())
    }
    

}
