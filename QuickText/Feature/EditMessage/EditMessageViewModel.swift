//
//  EditMessageViewModel.swift
//  QuickText
//
//  Created by Debashree Joshi on 28/11/21.
//

import Foundation


class EditMessageViewModel {
    
    private var index: Int
    
    var title: String
    var message: String
    
    init(index: Int, message: String) {
        self.index = index
        self.message = message
        title = "Edit Message"
    }
    
    func updateMessage(message: String) {
        StoreManager.shared.updateMessage(index: index, newMessage: message)
    }
    
}
