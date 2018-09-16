//
//  TPMessage.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/24/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class TPMessage: Messageable, Equatable {
    
    var id: String!
    
    var timestamp: Date?
    
    var sender: TPPerson!
    
    var messageBodySize: CGSize?
    
    var timestampSize: CGSize?
    
    var messageBubbleSize: CGSize?
    
    var messageBubbleSizeCalculatedAt: Date?
    
    var type: MessageType!
    
    var category: MessageCategory!
    
    
    static var shouldShowSender = false
    
    
    init(id: String, type: MessageType, timestamp: Date?, sender: TPPerson, category: MessageCategory) {
        self.id = id
        self.type = type
        self.timestamp = timestamp ?? Date()
        self.sender = sender
        self.category = category
    }
    
    
    func getMessageHeaderSize() -> CGSize {
        if !TPMessage.shouldShowSender{
            return .zero
        }
        
        let requiredSizeForSenderNameLabel = UILabel.getSizeToFitText(text: self.sender.name, font: MESSAGE_SENDER_FONT, fontPointSize: MESSAGE_SENDER_FONT_SIZE, maxWidth: CGFloat.greatestFiniteMagnitude, maxHeight: nil)
        
        return CGSize(width: requiredSizeForSenderNameLabel.width, height: UILabel.heightForSingleLine(font: MESSAGE_SENDER_FONT, fontPointSize: MESSAGE_SENDER_FONT_SIZE))
    }
    
    func getMessageBodySize() -> CGSize {
        fatalError("func 'getMessageBodySize() -> CGSize' must be overriden by subclass of TPMessage")
    }
    
    func getTimestampSize() -> CGSize {
        
        if let lastViewTransitionTimestamp = viewSizeTransitionedAt, let bubbleSizeCalculatedAt = messageBubbleSizeCalculatedAt, let timestampSize = self.timestampSize{
            if bubbleSizeCalculatedAt.compare(lastViewTransitionTimestamp) == .orderedDescending{
                return timestampSize
            }
        }
        
        let timestampLabelSize = UILabel.getSizeToFitText(text: String.getTimeStampForMsgBubbleForDate(date: self.timestamp ?? Date()), font: TIMESTAMP_FONT, fontPointSize: TIMESTAMP_FONT_SIZE, maxWidth: msgBubbleMaxWidth, maxHeight: nil)
        
        //Storing to avoid re-calculation
        self.timestampSize = timestampLabelSize
    
        return self.timestampSize!
    }
    
    
    func getMessageBubbleSize() -> CGSize{
        if let lastViewTransitionTimestamp = viewSizeTransitionedAt, let bubbleSizeCalculatedAt = messageBubbleSizeCalculatedAt, let bubbleSize = messageBubbleSize{
            if bubbleSizeCalculatedAt.compare(lastViewTransitionTimestamp) == .orderedDescending{
                return bubbleSize
            }
        }
        
        _ = getMessageBodySize()
        _ = getTimestampSize()

        var msgBubbleWidth : CGFloat = 0
        var msgBubbleHeight : CGFloat  = 0
        
        if self.messageBodySize!.width + self.timestampSize!.width  + PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT*2 + HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE > msgBubbleMaxWidth{
            //Vertical Placement
            msgBubbleWidth = (self.messageBodySize!.width > self.timestampSize!.width ? self.messageBodySize!.width : self.timestampSize!.width) + (PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT * 2)
            msgBubbleHeight = self.messageBodySize!.height + (PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT * 2) + self.timestampSize!.height 

        }else{
            //Horizontal Placement
            msgBubbleWidth = self.messageBodySize!.width + self.timestampSize!.width + HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP + PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT*2 + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE
            msgBubbleHeight = self.messageBodySize!.height + (PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT * 2)
        }
        
        
        //Storing to avoid re-calculation
        self.messageBubbleSize = CGSize(width: msgBubbleWidth, height: msgBubbleHeight)
        
        //Update timestamp when message bubble size was calculated
        self.messageBubbleSizeCalculatedAt = Date()
        
        return self.messageBubbleSize!
    }
    
    
    static func ==(lhs: TPMessage, rhs: TPMessage) -> Bool {
        return lhs.id == rhs.id
    }
    
}






