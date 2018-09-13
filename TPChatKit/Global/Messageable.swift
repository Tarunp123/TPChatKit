//
//  Messageable.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 9/11/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import CoreGraphics


protocol Messageable {
    var id : String! { get set }
    var timestamp : Date? { get set }
    var sender: TPPerson! { get set }
    
    var messageBodySize : CGSize? { get set }
    var timestampSize : CGSize? { get set }
    var messageBubbleSize : CGSize? { get set }
    var messageBubbleSizeCalculatedAt : Date? { get set }
    
    var type : MessageType! { get set }
    var category : MessageCategory! { get set }
    
    func getMessageBodySize() -> CGSize
    func getTimestampSize() -> CGSize
    func getMessageBubbleSize() -> CGSize
    
}

