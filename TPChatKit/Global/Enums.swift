//
//  MessageType.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/26/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

enum MessageType {
    case Text
}



enum MessageCategory {
    case Incoming
    case Outgoing
    
    func getBubbleColor() -> UIColor {
        switch self{
        case .Incoming:
            return INCOMING_MESSAGE_BUBBLE_COLOR
        case .Outgoing:
            return OUTGOING_MESSAGE_BUBBLE_COLOR
        }
    }
    
    func getTextColor() -> UIColor {
        switch self{
        case .Incoming:
            return INCOMING_MESSAGE_TEXT_COLOR
        case .Outgoing:
            return OUTGOING_MESSAGE_TEXT_COLOR
        }
    }

    func getTimestampColor() -> UIColor {
        switch self{
        case .Incoming:
            return INCOMING_TIMESTAMP_TEXT_COLOR
        case .Outgoing:
            return OUTGOING_TIMESTAMP_TEXT_COLOR
        }
    }
    
}
