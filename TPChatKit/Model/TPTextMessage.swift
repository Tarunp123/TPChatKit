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
    
        let msgLabelSize = UITextView.getSizeToFitText(text: self.text, font: MESSAGE_TEXT_FONT, fontPointSize: MESSAGE_TEXT_FONT_SIZE, maxWidth: MESSAGE_TEXT_MAX_WIDTH, maxHeight: nil)
    
        //Storing to avoid re-calculation
        self.messageBodySize = msgLabelSize

        return self.messageBodySize!
    }

    
    override func getMessageBubbleSize() -> CGSize {
        if let lastViewTransitionTimestamp = viewSizeTransitionedAt, let bubbleSizeCalculatedAt = messageBubbleSizeCalculatedAt, let bubbleSize = messageBubbleSize{
            if bubbleSizeCalculatedAt.compare(lastViewTransitionTimestamp) == .orderedDescending{
                return bubbleSize
            }
        }
        
        _ = getMessageBodySize()
        _ = getTimestampSize()
        
        var msgBubbleWidth : CGFloat = 0
        var msgBubbleHeight : CGFloat  = 0
        
        let horizontalContentPadding = self.category == .Incoming ? (INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.left + INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.right) : (OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.left + OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.right)
        let verticalContentPadding = self.category == .Incoming ? (INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.top + INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.bottom) : (OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.top + OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.bottom)
        
        if self.messageBodySize!.width + self.timestampSize!.width  + horizontalContentPadding + HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE > msgBubbleMaxWidth{
            //Vertical Placement
            msgBubbleWidth = (self.messageBodySize!.width > self.timestampSize!.width ? self.messageBodySize!.width : self.timestampSize!.width) + horizontalContentPadding
            
            let lastLineWidth = UITextView.getLastLineSize(text: self.text, font: MESSAGE_TEXT_FONT, fontPointSize: MESSAGE_TEXT_FONT_SIZE, maxWidth: MESSAGE_TEXT_MAX_WIDTH)

            if (lastLineWidth.width + self.timestampSize!.width + HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP) <= MESSAGE_TEXT_MAX_WIDTH{
                msgBubbleHeight = self.messageBodySize!.height + verticalContentPadding
            }else{
                msgBubbleHeight = self.messageBodySize!.height + verticalContentPadding + VERTICAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP + self.timestampSize!.height
            }
            
        }else{
            //Horizontal Placement
            msgBubbleWidth = self.messageBodySize!.width + self.timestampSize!.width + HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP + horizontalContentPadding + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE
            msgBubbleHeight = self.messageBodySize!.height + verticalContentPadding
        }
        
        //Adding Message Header View Height to Message Body View Height ONLY for Incoming messages in Group Chat
        if currentChatType == .Group && category == .Incoming{
            msgBubbleHeight += self.getMessageHeaderSize().height
            
            //Checking if message bubble width is less than header view width
            if msgBubbleWidth < self.getMessageHeaderSize().width + horizontalContentPadding{
                msgBubbleWidth = self.getMessageHeaderSize().width + horizontalContentPadding
            }
        }
        
        
        //Storing to avoid re-calculation
        self.messageBubbleSize = CGSize(width: msgBubbleWidth, height: msgBubbleHeight)
        
        
        
        //Update timestamp when message bubble size was calculated
        self.messageBubbleSizeCalculatedAt = Date()
        
        return self.messageBubbleSize!
    }
    
}



func ==(lhs: TPTextMessage, rhs: TPTextMessage) -> Bool {
    return lhs.id == rhs.id //lhs.text == rhs.text
}

