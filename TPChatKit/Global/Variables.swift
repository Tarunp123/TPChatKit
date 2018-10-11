//
//  Variables.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 9/11/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

var msgBubbleMaxWidth : CGFloat!

var viewSizeTransitionedAt : Date?

var currentChatType : TPChatType!

var headerDateHeight : CGFloat{
    get{
        return UILabel.heightForSingleLine(font: HEADER_DATE_FONT, fontPointSize: HEADER_DATE_FONT_SIZE)
    }
}
