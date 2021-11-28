//
//  StoreManager.swift
//  QuickText
//
//  Created by Debashree Joshi on 26/11/21.
//

import Foundation

protocol StoreManagerType {
    func addMessage(_ message: String)
    func updateMessages(_ messages: [String])
    func getMessages() -> [String]
    func updateMessage(index: Int, newMessage: String)
    func deleteMessage(index: Int)
}


class StoreManager: StoreManagerType {
    
    private lazy var userDefault = UserDefaults(suiteName: appGroup)
    private let key = "MESSAGES"
    private let appGroup = "group.com.djoshi.quicktext"
    
    static let shared = StoreManager()
    
    private init() {}
    
    public init(userDefault: UserDefaults){
        self.userDefault = userDefault
    }
    
    func addMessage(_ message: String) {
        var messages = getMessages()
        messages.append(message)
        updateMessages(messages)
    }
    
    func getMessages() -> [String] {
        return userDefault?.array(forKey: key) as? [String] ?? []
    }
    
    func updateMessages(_ messages: [String]) {
        userDefault?.set(messages, forKey: key)
    }
    
    func updateMessage(index: Int, newMessage: String) {
        var messages = getMessages()
        messages[index] = newMessage
        updateMessages(messages)
    }
    
    func deleteMessage(index: Int) {
        var messages = getMessages()
        messages.remove(at: index)
        updateMessages(messages)
    }
}
