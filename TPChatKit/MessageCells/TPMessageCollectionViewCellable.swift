//
//  TPMessageCollectionViewCellable.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 13/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit


protocol TPMessageCollectionViewCellable {
    
    var messageBubble : UIView { get set }
    var messageHeaderView : UIView { get set }
    var messageBodyView : UIView { get set }
    var timestampLabel : UILabel { get set }
    
    func getMessageHeaderSize(message: TPMessage) -> CGSize
    func getMessageHeaderView(message: TPMessage) -> UIView
    
    func getMessageBodySize(message: TPMessage) -> CGSize
    func getMessageBodyView(message: TPMessage) -> UIView
    
    func getTimestampSize(message: TPMessage) -> CGSize
    
    func getMessageBubbleSize(message: TPMessage) -> CGSize
    
    func createMessageBubbleForMessage(message: TPMessage)
    
    static func getCellHeightForMessage(message: Messageable) -> CGFloat
    
}
