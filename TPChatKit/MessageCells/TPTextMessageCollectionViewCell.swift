//
//  TPTextMessageCollectionViewCell.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 13/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPTextMessageCollectionViewCell: UICollectionViewCell {
    
    private var messageBubble : UIView!
    private let messageTextView = UITextView()
    private let timestampLabel = UILabel()
    private var messageHeaderView : UIView?
    private var senderNameLabel : UILabel?
    
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
        createMsgBubbleForMessage(message: message)
        
        //Header View (Sender name for Incoming Messages in Group Chat)
        if message.getMessageHeaderSize() != .zero{
            self.messageHeaderView = UIView()
            self.messageHeaderView?.backgroundColor = UIColor.clear
            self.messageBubble.addSubview(self.messageHeaderView!)
            self.messageHeaderView?.translatesAutoresizingMaskIntoConstraints = false
            self.messageHeaderView?.topAnchor.constraint(equalTo: self.messageBubble.topAnchor).isActive = true
            self.messageHeaderView?.leadingAnchor.constraint(equalTo: self.messageBubble.leadingAnchor).isActive = true
            self.messageHeaderView?.heightAnchor.constraint(equalToConstant: message.getMessageHeaderSize().height).isActive = true
            self.messageHeaderView?.trailingAnchor.constraint(equalTo: self.messageBubble.trailingAnchor).isActive = true
            
            self.senderNameLabel = UILabel()
            self.senderNameLabel?.text = message.sender.name
            self.senderNameLabel?.font = MESSAGE_SENDER_FONT
            self.senderNameLabel?.font = self.senderNameLabel?.font.withSize(MESSAGE_SENDER_FONT_SIZE)
            self.senderNameLabel?.textAlignment = .left
            self.senderNameLabel?.lineBreakMode = .byTruncatingTail
            self.senderNameLabel?.textColor = message.sender.fontColor
            self.messageHeaderView?.addSubview(self.senderNameLabel!)
            self.senderNameLabel?.translatesAutoresizingMaskIntoConstraints = false
            self.senderNameLabel?.topAnchor.constraint(equalTo: self.messageHeaderView!.topAnchor, constant: PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT).isActive = true
            self.senderNameLabel?.leadingAnchor.constraint(equalTo: self.messageHeaderView!.leadingAnchor, constant: PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT).isActive = true
            self.senderNameLabel?.trailingAnchor.constraint(equalTo: self.messageHeaderView!.trailingAnchor, constant: -PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT).isActive = true
            self.senderNameLabel?.bottomAnchor.constraint(equalTo: self.messageHeaderView!.bottomAnchor).isActive = true

        }
        
        //MSG TEXT
        self.messageTextView.text = message.text
        self.messageTextView.frame = CGRect(x: PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT, y: message.getMessageHeaderSize().height + PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT, width: message.getMessageBodySize().width, height: message.getMessageBodySize().height)
        self.messageTextView.font =  MESSAGE_TEXT_FONT
        self.messageTextView.font = self.messageTextView.font?.withSize(MESSAGE_TEXT_FONT_SIZE)
        self.messageTextView.textColor = message.category.getTextColor()
        self.messageBubble.addSubview(self.messageTextView)
        
        //TIMESTAMP
        self.timestampLabel.text = String.getTimeStampForMsgBubbleForDate(date: message.timestamp ?? Date())
        self.timestampLabel.font = TIMESTAMP_FONT
        self.timestampLabel.font = self.timestampLabel.font.withSize(TIMESTAMP_FONT_SIZE)
        self.timestampLabel.textColor = message.category.getTimestampColor()
        self.timestampLabel.frame = CGRect(x: self.messageBubble.frame.width - message.getTimestampSize().width - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE, y: self.messageBubble.frame.maxY - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE - message.getTimestampSize().height, width: message.getTimestampSize().width, height: message.getTimestampSize().height)
        self.messageBubble.addSubview(self.timestampLabel)
    }
    
    
    private func createMsgBubbleForMessage(message: TPTextMessage){

        self.messageBubble?.removeFromSuperview()
        
        let bubbleSize = message.getMessageBubbleSize()
        self.messageBubble = UIView(frame:  CGRect(x: (message.category == .Incoming ? HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL : self.contentView.frame.width - HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL - bubbleSize.width), y: 0, width: bubbleSize.width, height: bubbleSize.height))
//        self.messageBubble.clipsToBounds = true
        self.messageBubble.backgroundColor = message.category.getBubbleColor()
        self.messageBubble.layer.cornerRadius = MESSAGE_BUBBLE_CORNER_RADIUS
        self.contentView.addSubview(self.messageBubble)
        self.messageBubble.translatesAutoresizingMaskIntoConstraints = false
        if let isPreviousMessageFromThisSender = message.isPreviousMessageFromThisSender{
            self.messageBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: (isPreviousMessageFromThisSender ? PADDING_BETWEEN_CELLS_FROM_SAME_USER : PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS)).isActive = true
        }else{
            self.messageBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS).isActive = true
        }
        if(message.category == .Incoming){
            self.messageBubble.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL).isActive = true
        }else{
            self.messageBubble.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL).isActive = true
        }
        self.messageBubble.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.messageBubble.widthAnchor.constraint(equalToConstant: bubbleSize.width).isActive = true
    }
    
    
    
    static func getCellHeightForMsg(message: Messageable) -> CGFloat{
        if let isPreviousMessageFromThisSender = message.isPreviousMessageFromThisSender{
            return message.getMessageBubbleSize().height + (isPreviousMessageFromThisSender ? PADDING_BETWEEN_CELLS_FROM_SAME_USER : PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS)
        }
        
        return message.getMessageBubbleSize().height + PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
