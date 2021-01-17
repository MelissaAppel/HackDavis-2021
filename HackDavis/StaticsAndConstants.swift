//
//  StaticsAndConstants.swift
//  HackDavis
//
//  Created by Melissa Appel on 1/16/21.
//

import Foundation

struct StaticsAndConstants{
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct fStore{
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let theirField = "their"
    }
}
