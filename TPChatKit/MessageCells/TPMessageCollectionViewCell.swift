//
//  TPMessageCollectionViewCell.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 7/25/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPMessageCollectionViewCell: UICollectionViewCell {
    
    private let msgTextView = UITextView()
    private let timestampLabel = UILabel()
    private var msgBubble : UIView!
    private let paddingBetweenMsgBubbleAndText = PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT
    private let verticalPaddingBetweenMsgBubbleAndCell = VERTICAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL
    private let horizontalPaddingBetweenMsgBubbleAndCell = HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.msgTextView.isSelectable = true
        self.msgTextView.isScrollEnabled = false
        self.msgTextView.isEditable = false
        self.msgTextView.backgroundColor = UIColor.clear
        self.msgTextView.textContainerInset = UIEdgeInsets.zero
        self.msgTextView.font = UIFont.systemFont(ofSize: MESSAGE_TEXT_FONT_SIZE)
        
        self.timestampLabel.font = UIFont.systemFont(ofSize: TIMESTAMP_FONT_SIZE)
        self.timestampLabel.textAlignment = .right
    }
    
    
    
    func createMessageBubbleForMessage(message: TPTextMessage){
        
        //Create Message Bubble
        createMsgBubble(size: message.getMessageBubbleSize(), ofCategory: message.category)
        
        //MSG TEXT
        self.msgTextView.text = message.text
        self.msgTextView.frame = CGRect(x: paddingBetweenMsgBubbleAndText, y: paddingBetweenMsgBubbleAndText, width: message.getMessageBodySize().width, height: message.getMessageBodySize().height)
        self.msgTextView.font = UIFont.systemFont(ofSize: MESSAGE_TEXT_FONT_SIZE)
        self.msgTextView.textColor = message.category.getTextColor()
        self.msgBubble.addSubview(self.msgTextView)
        
        //TIMESTAMP
        self.timestampLabel.text = String.getTimeStampForMsgBubbleForDate(date: message.timestamp ?? Date())
        self.timestampLabel.font = UIFont.systemFont(ofSize: TIMESTAMP_FONT_SIZE)
        self.timestampLabel.textColor = message.category.getTimestampColor()
        if message.getMessageBodySize().width + message.getTimestampSize().width  + paddingBetweenMsgBubbleAndText + PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE > msgBubbleMaxWidth{
            self.timestampLabel.frame = CGRect(x: self.msgBubble.frame.width - message.getTimestampSize().width - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE, y: self.msgTextView.frame.maxY + 2, width: message.getTimestampSize().width, height: message.getTimestampSize().height)
            
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
            self.timestampLabel.frame = CGRect(x: self.msgBubble.frame.width - message.getTimestampSize().width - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE, y: self.msgBubble.frame.maxY - paddingBetweenMsgBubbleAndText - message.getTimestampSize().height, width: message.getTimestampSize().width, height: message.getTimestampSize().height)
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
        msgBubble.translatesAutoresizingMaskIntoConstraints = false
        msgBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: verticalPaddingBetweenMsgBubbleAndCell).isActive = true
        if(category == .Incoming){
            msgBubble.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: horizontalPaddingBetweenMsgBubbleAndCell).isActive = true
        }else{
            msgBubble.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -horizontalPaddingBetweenMsgBubbleAndCell).isActive = true
        }
        msgBubble.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -verticalPaddingBetweenMsgBubbleAndCell).isActive = true
        msgBubble.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    

    static func getCellHeightForMsg(message: Messageable) -> CGFloat{
        return message.getMessageBubbleSize().height + VERTICAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL*2
    }
 
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
