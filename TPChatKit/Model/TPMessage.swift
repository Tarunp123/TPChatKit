//
//  TPMessage.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/24/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class TPMessage: Equatable {
    
    private var id : String!
    var timestamp : Date?
    var sender: TPPerson!
    var msgBodySize : CGSize?
    var timestampSize : CGSize?
    var bubbleSize : CGSize?
    var type : MessageType!
    var category : MessageCategory!
    
    init(id: String, type: MessageType, timestamp: Date?, sender: TPPerson, category: MessageCategory) {
        self.id = id
        self.type = type
        self.timestamp = timestamp
        self.sender = sender
        self.category = category
    }
    
    static func ==(lhs: TPMessage, rhs: TPMessage) -> Bool {
        return lhs.id == rhs.id
    }
    

    func getMsgBubbleSize() -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    
}
