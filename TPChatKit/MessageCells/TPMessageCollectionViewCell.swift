//
//  TPMessageCollectionViewCell.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 7/25/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPMessageCollectionViewCell: UICollectionViewCell, TPMessageCollectionViewCellable {
    
    var messageBubble: UIView
    
    var messageHeaderView: UIView
    var messageBodyView: UIView
    var timestampLabel: UILabel
    

    override init(frame: CGRect) {
        self.messageBubble = UIView()
        self.messageHeaderView = UIView()
        self.messageBodyView = UIView()
        self.timestampLabel = UILabel()
        super.init(frame: frame)
    }


    func getMessageHeaderSize(message: TPMessage) -> CGSize {
        return .zero
    }

    func getMessageHeaderView(message: TPMessage) -> UIView {
        self.messageHeaderView = UIView()
        self.messageHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return self.messageHeaderView
    }

    func getMessageBodySize(message: TPMessage) -> CGSize {
        return message.getMessageBodySize()
    }

    func getMessageBodyView(message: TPMessage) -> UIView {
        fatalError("getMessageBodyView(message: TPMessage) has not been implemented")
    }

    func getTimestampSize(message: TPMessage) -> CGSize {
        return message.getTimestampSize()
    }

    func getMessageBubbleSize(message: TPMessage) -> CGSize {
        //Calculate Size
        return message.getMessageBubbleSize()
    }

    func createMessageBubbleForMessage(message: TPMessage){
        
        self.messageBubble.removeFromSuperview()
        
        let bubbleSize = self.getMessageBubbleSize(message: message)
        self.messageBubble = UIView(frame:  CGRect(x: (message.category == .Incoming ? HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL : self.contentView.frame.width - HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL - bubbleSize.width), y: 0, width: bubbleSize.width, height: bubbleSize.height))
        self.messageBubble.backgroundColor = message.category.getBubbleColor()
        self.messageBubble.layer.cornerRadius = MESSAGE_BUBBLE_CORNER_RADIUS
        self.contentView.addSubview(self.messageBubble)
        
        self.messageBubble.translatesAutoresizingMaskIntoConstraints = false
        if let isPreviousMessageFromThisSender = message.isPreviousMessageFromThisSender{
            self.messageBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -(isPreviousMessageFromThisSender ? PADDING_BETWEEN_CELLS_FROM_SAME_USER : PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS)).isActive = true
        }else{
            self.messageBubble.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS).isActive = true
        }
        if(message.category == .Incoming){
            self.messageBubble.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL).isActive = true
        }else{
            self.messageBubble.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL).isActive = true
        }
        self.messageBubble.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.messageBubble.widthAnchor.constraint(equalToConstant: bubbleSize.width).isActive = true
    }

    
    static func getCellHeightForMessage(message: Messageable) -> CGFloat {
        if let isPreviousMessageFromThisSender = message.isPreviousMessageFromThisSender{
            return message.getMessageBubbleSize().height + (isPreviousMessageFromThisSender ? PADDING_BETWEEN_CELLS_FROM_SAME_USER : PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS)
        }
        
        return message.getMessageBubbleSize().height + PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
