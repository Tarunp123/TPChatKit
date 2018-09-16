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

    func getMessageHeaderSize() -> CGSize
    func getMessageHeaderView() -> UIView
    
    func getMessageBodySize() -> CGSize
    func getMessageBodyView() -> UIView
    
    func getTimestampSize() -> CGSize
    
    func getMessageBubbleSize() -> CGSize
    
    func createMessageBubbleForMessage(message: TPMessage)
    
}
