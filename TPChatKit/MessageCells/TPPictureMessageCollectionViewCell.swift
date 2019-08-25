//
//  TPPictureMessageCollectionViewCell.swift
//  TPChatKit
//
//  Created by Tarun on 01/05/19.
//  Copyright © 2019 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPPictureMessageCollectionViewCell: UICollectionViewCell {
    
    var messageBubble : TPMessageBubbleView!
    private let imageView = UIImageView()
    private let timestampLabel = UILabel()
    private var messageHeaderView : UIView?
    private var senderNameLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.messageTextView.isUserInteractionEnabled = false
        self.imageView.backgroundColor = UIColor.lightGray
        self.imageView.layer.cornerRadius = 6.0
        self.imageView.clipsToBounds = true
        self.timestampLabel.textAlignment = .right
        
    }
    
    func createMessageBubbleForMessage(message: TPPictureMessage){
        
        //Create Message Bubble
        self.createMsgBubbleForMessage(message: message)
        
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
            self.senderNameLabel?.font = MESSAGE_SENDER_FONT.withSize(MESSAGE_SENDER_FONT_SIZE)
            self.senderNameLabel?.textAlignment = .left
            self.senderNameLabel?.lineBreakMode = .byTruncatingTail
            self.senderNameLabel?.textColor = message.sender.fontColor
            self.messageHeaderView?.addSubview(self.senderNameLabel!)
            self.senderNameLabel?.translatesAutoresizingMaskIntoConstraints = false
            self.senderNameLabel?.topAnchor.constraint(equalTo: self.messageHeaderView!.topAnchor, constant: (message.category == .Incoming) ? INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.top : OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.top).isActive = true
            self.senderNameLabel?.leadingAnchor.constraint(equalTo: self.messageHeaderView!.leadingAnchor, constant: (message.category == .Incoming) ? INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.left : OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.left).isActive = true
            self.senderNameLabel?.trailingAnchor.constraint(equalTo: self.messageHeaderView!.trailingAnchor, constant: -1 * ((message.category == .Incoming) ? INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.right : OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.right)).isActive = true
            self.senderNameLabel?.bottomAnchor.constraint(equalTo: self.messageHeaderView!.bottomAnchor).isActive = true
            
        }
        
        //MSG TEXT
        if let url = URL(string: message.imageURL){
//            self.imageView.image.loa
        }
        self.imageView.frame = CGRect(x: ((message.category == .Incoming) ? INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.left : OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.left), y: message.getMessageHeaderSize().height + ((message.category == .Incoming) ? INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.top : OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.top), width: message.getMessageBodySize().width, height: message.getMessageBodySize().height)
        self.messageBubble.addSubview(self.imageView)
        
        //TIMESTAMP
        self.timestampLabel.text = String.getTimeStampForMsgBubbleForDate(date: message.timestamp ?? Date())
        self.timestampLabel.font = TIMESTAMP_FONT.withSize(TIMESTAMP_FONT_SIZE)
        self.timestampLabel.textColor = message.category.getMediaTimestampColor()
        let timestampLabelSize = UILabel.getSizeToFitText(text: String.getTimeStampForMsgBubbleForDate(date: message.timestamp ?? Date()), font: TIMESTAMP_FONT, fontPointSize: TIMESTAMP_FONT_SIZE, maxWidth: MESSAGE_BODY_MAX_WIDTH, maxHeight: nil)
        self.timestampLabel.frame = CGRect(x: self.messageBubble.frame.width - ((message.category == .Incoming) ? INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.right : OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.right) - timestampLabelSize.width - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE * 1.5, y: self.messageBubble.frame.maxY - (((message.category == .Incoming) ? INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.bottom : OUTGING_MESSAGE_BUBBLE_CONTENT_INSET.bottom) * 1.5) - timestampLabelSize.height, width: timestampLabelSize.width, height: timestampLabelSize.height)
        
        self.messageBubble.addSubview(self.timestampLabel)
    }
    
    
    private func createMsgBubbleForMessage(message: TPPictureMessage){
        
        self.messageBubble?.removeFromSuperview()
        
        let bubbleSize = message.getMessageBubbleSize()
        self.messageBubble = TPMessageBubbleView(frame:  CGRect(x: (message.category == .Incoming ? HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL : self.contentView.frame.width - HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL - bubbleSize.width), y: 0, width: bubbleSize.width, height: bubbleSize.height))
        self.messageBubble.clipsToBounds = true
        self.messageBubble.tintColor = message.category.getBubbleColor()
        self.messageBubble.layer.cornerRadius = MESSAGE_BUBBLE_CORNER_RADIUS
        self.contentView.addSubview(self.messageBubble)
        self.messageBubble.translatesAutoresizingMaskIntoConstraints = false
        
        var bubbleImageName = ""
        if message.isPreviousMessageFromThisSender != nil && message.isPreviousMessageFromThisSender!{   //trailing Bubble
            self.messageBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: PADDING_BETWEEN_CELLS_FROM_SAME_USER).isActive = true
            bubbleImageName = (message.category == .Incoming) ? INCOMING_TRAILING_BUBBLE_NAME : OUTGOING_TRAILING_BUBBLE_NAME
        }else{
            //Leading or First Bubble
            self.messageBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS).isActive = true
            bubbleImageName = (message.category == .Incoming) ? INCOMING_LEADING_BUBBLE_NAME : OUTGOING_LEADING_BUBBLE_NAME
        }
        
        if(message.category == .Incoming){  //Incoming Message
            self.messageBubble.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL).isActive = true
        }else{
            //Outgoing Message
            self.messageBubble.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL).isActive = true
        }
        
        
        //Set Bubble Image
        let bubbleImg = UIImage(named: bubbleImageName)?.resizableImage(withCapInsets: MESSAGE_BUBBLE_CAP_INSETS, resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
        self.messageBubble.image = bubbleImg
        
        
        self.messageBubble.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.messageBubble.widthAnchor.constraint(equalToConstant: bubbleSize.width).isActive = true
        
        //enable user interaction
        self.messageBubble.isUserInteractionEnabled = true
    }
    
    
    
    static func getCellHeightForMsg(message: TPMessage) -> CGFloat{
        if let isPreviousMessageFromThisSender = message.isPreviousMessageFromThisSender{
            return message.getMessageBubbleSize().height + (isPreviousMessageFromThisSender ? PADDING_BETWEEN_CELLS_FROM_SAME_USER : PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS)
        }
        
        return message.getMessageBubbleSize().height + PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
