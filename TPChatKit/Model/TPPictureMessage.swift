//
//  TPPictureMessage.swift
//  TPChatKit
//
//  Created by Tarun on 01/05/19.
//  Copyright © 2019 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class TPPictureMessage: TPMessage{
    
    var imageURL: String!
    var imageSize: CGSize!
    
    init(id: String, imageURL: String, imageSize: CGSize, timestamp: Date?, sender: TPPerson, category: TPMessageCategory) {
        super.init(id: id, type: .Text, timestamp: timestamp, sender: sender, category: category)
        self.type = .Picture
        self.imageURL = imageURL
        self.imageSize = self.getImageSizeForDisplaying(orgSize: imageSize)
    }
    
    private func getImageSizeForDisplaying(orgSize: CGSize) -> CGSize{
        var newSize = MESSAGE_IMAGE_MAX_BODY_SIZE
        if orgSize.width > orgSize.height{
            //landscape
            if orgSize.width > MESSAGE_IMAGE_MAX_BODY_SIZE.width{
                //need to adjust height
                let percentSizeReducedTo = newSize.width/orgSize.width
                newSize.height = orgSize.height * percentSizeReducedTo
                
                //Checking if new height is too small
                if newSize.height < MESSAGE_IMAGE_MIN_BODY_SIZE.height{
                    //now need to re-adjust width
                    newSize.height = MESSAGE_IMAGE_MIN_BODY_SIZE.height
                }
                
            }else if orgSize.width < MESSAGE_IMAGE_MIN_BODY_SIZE.width{
                //both width & height is less than than min body size
                newSize = MESSAGE_IMAGE_MIN_BODY_SIZE
            }else{
                newSize = orgSize
            }
        }else{
            //potrait or square
            if orgSize.height > newSize.height{
                //need to adjust width
                let percentSizeReducedTo = newSize.height/orgSize.height
                newSize.width = orgSize.width * percentSizeReducedTo
                
                //Checking if new width is too small
                if newSize.width < MESSAGE_IMAGE_MIN_BODY_SIZE.width{
                    //now need to re-adjust height
                    newSize.width = MESSAGE_IMAGE_MIN_BODY_SIZE.width
                }
            }else if orgSize.height < MESSAGE_IMAGE_MIN_BODY_SIZE.height{
                //both width & height is less than than min body size
                newSize = MESSAGE_IMAGE_MIN_BODY_SIZE
            }else{
                newSize = orgSize
            }
        }
        
        return newSize
    }
    
    override func getMessageBodySize() -> CGSize {
        
        if let bodySize = messageBodySize{
            if let lastViewTransitionTimestamp = viewSizeTransitionedAt, let bubbleSizeCalculatedAt = messageBubbleSizeCalculatedAt{
                if bubbleSizeCalculatedAt.compare(lastViewTransitionTimestamp) == .orderedDescending{
                    return bodySize
                }
            }else{
                return bodySize
            }
        }
        
        //Storing to avoid re-calculation
        self.messageBodySize = self.imageSize
        
        return self.messageBodySize!
    }
    
    override func getMessageBubbleSize() -> CGSize {
        if let bubbleSize = messageBubbleSize{
            if let lastViewTransitionTimestamp = viewSizeTransitionedAt, let bubbleSizeCalculatedAt = messageBubbleSizeCalculatedAt{
                if bubbleSizeCalculatedAt.compare(lastViewTransitionTimestamp) == .orderedDescending{
                    return bubbleSize
                }
            }else{
                return bubbleSize
            }
        }
        
        _ = getMessageBodySize()
        _ = getTimestampSize()
        
        var msgBubbleWidth : CGFloat = 0
        var msgBubbleHeight : CGFloat  = 0
        
        let horizontalContentPadding = self.category == .Incoming ? (INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.left + INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.right) : (OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.left + OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.right)
        let verticalContentPadding = self.category == .Incoming ? (INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.top) : (OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.top)
        
    
        if (self.messageBodySize!.width + self.category.padding.left + self.category.padding.right) >= (self.timestampSize!.width + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE){
            msgBubbleWidth = self.messageBodySize!.width + self.category.padding.left + self.category.padding.right
        }else{
            msgBubbleWidth = self.timestampSize!.width + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE
        }
        
        msgBubbleHeight = self.messageBodySize!.height + verticalContentPadding + VERTICAL_PADDING_BETWEEN_MESSAGE_BODY_AND_TIMESTAMP + self.timestampSize!.height
        
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

    override func getTimestampSize() -> CGSize {
        self.timestampSize = .zero
        return .zero
    }
    
    
    func downloadImageData(imageURL: String) {
        
    }
    
}


func ==(lhs: TPPictureMessage, rhs: TPPictureMessage) -> Bool {
    return lhs.id == rhs.id //lhs.imageURL == rhs.imageURL
}
