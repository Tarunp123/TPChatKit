//
//  TPTextMessage.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/26/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class TPTextMessage: TPMessage {
    
    var text : String!

    init(id: String, text: String, timestamp: Date?, sender: TPPerson, category: TPMessageCategory) {
        super.init(id: id, type: .Text, timestamp: timestamp, sender: sender, category: category)
        self.text = text
    }
    
    
   override func getMessageBodySize() -> CGSize {
    
        if let lastViewTransitionTimestamp = viewSizeTransitionedAt, let bubbleSizeCalculatedAt = messageBubbleSizeCalculatedAt, let bodySize = messageBodySize{
            if bubbleSizeCalculatedAt.compare(lastViewTransitionTimestamp) == .orderedDescending{
                return bodySize
            }
        }
    
        let msgLabelSize = UITextView.getSizeToFitText(text: self.text, font: MESSAGE_TEXT_FONT, fontPointSize: MESSAGE_TEXT_FONT_SIZE, maxWidth: msgBubbleMaxWidth, maxHeight: nil)
    
        //Storing to avoid re-calculation
        self.messageBodySize = msgLabelSize

        return self.messageBodySize!
    }
    
}


func ==(lhs: TPTextMessage, rhs: TPTextMessage) -> Bool {
    return lhs.id == rhs.id //lhs.text == rhs.text
}

