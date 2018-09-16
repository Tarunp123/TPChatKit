//
//  TPTextMessageCollectionViewCell.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 13/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPTextMessageCollectionViewCell: UICollectionViewCell {
    
    private var messageBubble = UIView()
    private let messageTextView = UITextView()
    private let timestampLabel = UILabel()
    private let paddingBetweenMsgBubbleAndText = PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT
    private let verticalPaddingBetweenMsgBubbleAndCell = VERTICAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL
    private let horizontalPaddingBetweenMsgBubbleAndCell = HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.messageTextView.isSelectable = true
        self.messageTextView.isScrollEnabled = false
        self.messageTextView.isEditable = false
        self.messageTextView.backgroundColor = UIColor.clear
        self.messageTextView.textContainerInset = UIEdgeInsets.zero

        self.timestampLabel.textAlignment = .right
    }
    
    
    
    func createMessageBubbleForMessage(message: TPTextMessage){
        
        //Create Message Bubble
        createMsgBubble(size: message.getMessageBubbleSize(), ofCategory: message.category)
        
        //MSG TEXT
        self.messageTextView.text = message.text
        self.messageTextView.frame = CGRect(x: paddingBetweenMsgBubbleAndText, y: paddingBetweenMsgBubbleAndText, width: message.getMessageBodySize().width, height: message.getMessageBodySize().height)
        self.messageTextView.font = UIFont.systemFont(ofSize: MESSAGE_TEXT_FONT_SIZE)
        self.messageTextView.textColor = message.category.getTextColor()
        self.messageBubble.addSubview(self.messageTextView)
        
        //TIMESTAMP
        self.timestampLabel.text = String.getTimeStampForMsgBubbleForDate(date: message.timestamp ?? Date())
        self.timestampLabel.font = UIFont.systemFont(ofSize: TIMESTAMP_FONT_SIZE)
        self.timestampLabel.textColor = message.category.getTimestampColor()
        self.timestampLabel.frame = CGRect(x: self.messageBubble.frame.width - message.getTimestampSize().width - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE, y: self.messageBubble.frame.maxY - paddingBetweenMsgBubbleAndText - message.getTimestampSize().height, width: message.getTimestampSize().width, height: message.getTimestampSize().height)
        self.messageBubble.addSubview(self.timestampLabel)
    }
    
    
    private func createMsgBubble(size: CGSize, ofCategory category: MessageCategory){

        self.messageBubble.removeFromSuperview()
        
        self.messageBubble = UIView(frame:  CGRect(x: (category == .Incoming ? horizontalPaddingBetweenMsgBubbleAndCell : self.contentView.frame.width - horizontalPaddingBetweenMsgBubbleAndCell - size.width), y: verticalPaddingBetweenMsgBubbleAndCell, width: size.width, height: size.height))
        self.messageBubble.backgroundColor = category.getBubbleColor()
        self.messageBubble.layer.cornerRadius = MESSAGE_BUBBLE_CORNER_RADIUS
        self.contentView.addSubview(self.messageBubble)
        self.messageBubble.translatesAutoresizingMaskIntoConstraints = false
        self.messageBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: verticalPaddingBetweenMsgBubbleAndCell).isActive = true
        if(category == .Incoming){
            self.messageBubble.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: horizontalPaddingBetweenMsgBubbleAndCell).isActive = true
        }else{
            self.messageBubble.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -horizontalPaddingBetweenMsgBubbleAndCell).isActive = true
        }
        self.messageBubble.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -verticalPaddingBetweenMsgBubbleAndCell).isActive = true
        self.messageBubble.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    
    
    static func getCellHeightForMsg(message: Messageable) -> CGFloat{
        return message.getMessageBubbleSize().height + VERTICAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL*2
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
