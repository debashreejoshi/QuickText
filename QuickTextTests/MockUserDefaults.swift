//
//  MockUserDefaults.swift
//  QuickTextTests
//
//  Created by Debashree Joshi on 28/11/21.
//

import Foundation

class MockUserDefaults: UserDefaults {
    convenience init() {
        self.init(suiteName: "Mock User Defaults")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
}
