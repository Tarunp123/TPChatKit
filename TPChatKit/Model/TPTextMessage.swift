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
    
    
    init(id: String, text: String, timestamp: Date?, sender: TPPerson, category: MessageCategory) {
        super.init(id: id, type: .Text, timestamp: timestamp, sender: sender, category: category)
        self.text = text
    }
    
    
    override func getMsgBubbleSize() -> CGSize{
        let msgLabelSize = UILabel.getSizeToFitText(text: self.text, font: MESSAGE_TEXT_FONT, fontPointSize: MESSAGE_TEXT_FONT_SIZE, maxWidth: msgBubbleMaxWidth, maxHeight: nil)
        
        let timestampLabelSize = UILabel.getSizeToFitText(text: String.getTimeStampForMsgBubbleForDate(date: self.timestamp ?? Date()), font: TIMESTAMP_FONT, fontPointSize: TIMESTAMP_FONT_SIZE, maxWidth: msgBubbleMaxWidth, maxHeight: nil)
        
        var msgBubbleWidth : CGFloat = 0
        var msgBubbleHeight : CGFloat  = 0

        if msgLabelSize.width + timestampLabelSize.width  + PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT*2 + PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE > msgBubbleMaxWidth{
            msgBubbleWidth = (msgLabelSize.width > timestampLabelSize.width ? msgLabelSize.width : timestampLabelSize.width) + (PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT * 2)
            
       
            msgBubbleHeight = (msgLabelSize.height + timestampLabelSize.height) + (PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT * 2)
        }else{  //Horizontal Placement
            msgBubbleWidth = msgLabelSize.width + timestampLabelSize.width + PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP + PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT*2 + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE
            msgBubbleHeight = msgLabelSize.height + (PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT * 2)
        }
        
        //Storing to avoid re-calculation
        self.msgBodySize = msgLabelSize
        self.timestampSize = timestampLabelSize
        self.bubbleSize = CGSize(width: msgBubbleWidth, height: msgBubbleHeight)
        
        return self.bubbleSize!
        
    }
    
    
    
}
