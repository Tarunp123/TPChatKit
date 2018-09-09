//
//  TPMessageCollectionViewCell.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 7/25/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPMessageCollectionViewCell: UICollectionViewCell {
    
    private let msgLabel = UILabel()
    private let timestampLabel = UILabel()
    private var msgBubble : UIView!
    private let paddingBetweenMsgBubbleAndText = PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT
    private let verticalPaddingBetweenMsgBubbleAndCell = VERTICAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL
    private let horizontalPaddingBetweenMsgBubbleAndCell = HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.msgLabel.numberOfLines = 0
        self.msgLabel.font = UIFont.systemFont(ofSize: MESSAGE_TEXT_FONT_SIZE)
        
        self.timestampLabel.font = UIFont.systemFont(ofSize: TIMESTAMP_FONT_SIZE)
        self.timestampLabel.textAlignment = .right
    }
    
    
    
    func createMessageBubbleForMessage(message: TPTextMessage){
        
        //Create Message Bubble
        createMsgBubble(size: message.bubbleSize ?? message.getMsgBubbleSize(), ofCategory: message.category)
        
        //MSG TEXT
        self.msgLabel.text = message.text
        self.msgLabel.frame = CGRect(x: paddingBetweenMsgBubbleAndText, y: paddingBetweenMsgBubbleAndText, width: message.msgBodySize!.width, height: message.msgBodySize!.height)
        self.msgLabel.font = UIFont.systemFont(ofSize: MESSAGE_TEXT_FONT_SIZE)
        self.msgLabel.textColor = message.category.getTextColor()
        self.msgBubble.addSubview(self.msgLabel)
        
        //TIMESTAMP
        self.timestampLabel.text = String.getTimeStampForMsgBubbleForDate(date: Date())
        self.timestampLabel.textColor = message.category.getTimestampColor()
        if message.msgBodySize!.width + message.timestampSize!.width  + paddingBetweenMsgBubbleAndText + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE > msgBubbleMaxWidth{
            self.timestampLabel.frame = CGRect(x: self.msgBubble.frame.width - message.timestampSize!.width - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE, y: self.msgLabel.frame.maxY + 2, width: message.timestampSize!.width, height: message.timestampSize!.height)
            
            //checking if msg on last line occupies the whole line
            //if not try to move timestamp a bit on the upperside
//            let lines = self.msgLabel.getLinesArrayOfString()
//            if let lastLine = lines.last{
//                let requiredWidth = UILabel.getSizeToFitText(text: lastLine, fontPointSize: msgLabel.font.pointSize, maxWidth: msgLabel.frame.width, maxHeight: nil).width
//                if requiredWidth + message.timestampSize!.width + paddingBetweenMsgBubbleAndText + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE <= msgBubbleMaxWidth{
//                    
//                }
//            }
            
        }else{  //horizontal placement
            self.timestampLabel.frame = CGRect(x: self.msgBubble.frame.width - message.timestampSize!.width - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE, y: self.msgBubble.frame.maxY - paddingBetweenMsgBubbleAndText - message.timestampSize!.height, width: message.timestampSize!.width, height: message.timestampSize!.height)
        }
        
        self.msgBubble.addSubview(timestampLabel)
    }
    
    
    private func createMsgBubble(size: CGSize, ofCategory category: MessageCategory){
        if msgBubble != nil{
            msgBubble.removeFromSuperview()
        }
        
        msgBubble = UIView(frame:  CGRect(x: (category == .Incoming ? horizontalPaddingBetweenMsgBubbleAndCell : self.contentView.frame.width - horizontalPaddingBetweenMsgBubbleAndCell - size.width), y: verticalPaddingBetweenMsgBubbleAndCell, width: size.width, height: size.height))
        msgBubble.backgroundColor = category.getBubbleColor()
        msgBubble.layer.cornerRadius = MESSAGE_BUBBLE_CORNER_RADIUS
        self.contentView.addSubview(self.msgBubble)
        
    }
    
    

    static func getCellHeightForMsg(message: TPMessage) -> CGFloat{
        message.bubbleSize = message.getMsgBubbleSize()
        return message.bubbleSize!.height + VERTICAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL*2
    }
 
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
