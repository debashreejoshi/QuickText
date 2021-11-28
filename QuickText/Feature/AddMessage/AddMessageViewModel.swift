//
//  AddMessageViewModel.swift
//  QuickText
//
//  Created by Debashree Joshi on 28/11/21.
//

import Foundation

class AddMessageViewModel {
    var title: String
    
    init() {
        title = "Add Message"
    }
    
    func save(message: String) {
        StoreManager.shared.addMessage(message)
    }
}
