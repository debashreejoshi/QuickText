//
//  MessageListViewModel.swift
//  QuickText
//
//  Created by Debashree Joshi on 28/11/21.
//

import Foundation

class MessageListViewModel {
    
    var title: String
    var datasource: [String]
    
    init() {
        title = "Messages"
        datasource = StoreManager.shared.getMessages()
    }
    
    func refreshData() {
        datasource = StoreManager.shared.getMessages()
    }
    
    func deleteMessage(index: Int) {
        datasource.remove(at: index)
        StoreManager.shared.deleteMessage(index: index)
    }
}
