//
//  MyDatabase.swift
//  HackDavis
//
//  Created by Aryan Vaid on 1/17/21.
//

import Foundation

class MyDatabase {
    static let shared = MyDatabase()

    var currentUserID = ""

    private init() {}
    // Setter functions

    func setCurrentUserID(currentUserID:String) {
        self.currentUserID = currentUserID
    }
    
    // Getter functions

    func getCurrentUserID() -> String {
        return currentUserID
    }
}

