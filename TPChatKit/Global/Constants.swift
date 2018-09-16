//
//  Constants.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/24/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

//Cell Id
let MESSGAE_CELL_ID = "messageCell"


//Font
var MESSAGE_SENDER_FONT : UIFont{
    get{
        return UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: UIFont.Weight.medium)
    }
}

var MESSAGE_TEXT_FONT : UIFont {
    get{
        return UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    }
}

var TIMESTAMP_FONT : UIFont {
    get{
        return UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2)
    }
}

//Point Size
var MESSAGE_SENDER_FONT_SIZE : CGFloat{
    get{
        return MESSAGE_SENDER_FONT.pointSize
    }
}

var MESSAGE_TEXT_FONT_SIZE : CGFloat {
    get{
        return MESSAGE_TEXT_FONT.pointSize
    }
}

var TIMESTAMP_FONT_SIZE : CGFloat {
    get{
        return TIMESTAMP_FONT.pointSize
    }
}


var currentFontPointSize : CGFloat?

//Color
let INCOMING_MESSAGE_BUBBLE_COLOR = UIColor.white//UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0)
let INCOMING_MESSAGE_TEXT_COLOR = UIColor.black
let INCOMING_TIMESTAMP_TEXT_COLOR = UIColor.gray

let OUTGOING_MESSAGE_BUBBLE_COLOR = UIColor(red: 181/255.0, green: 252/255.0, blue: 171/255.0, alpha: 1.0)
let OUTGOING_MESSAGE_TEXT_COLOR = UIColor.black
let OUTGOING_TIMESTAMP_TEXT_COLOR = UIColor.gray

//Bubble
let HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL : CGFloat = 10.0
let PADDING_BETWEEN_MESSAGE_BUBBLE_AND_TEXT : CGFloat = 10.0
let MESSAGE_BUBBLE_CORNER_RADIUS : CGFloat = 10.0
let PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS : CGFloat = 10.0
let PADDING_BETWEEN_CELLS_FROM_SAME_USER : CGFloat = 2.5
let PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE : CGFloat = 5.0
let HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP : CGFloat = 5.0
let VERTICAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP : CGFloat = 10.0
//let VERTICAL_PADDING_BETWEEN_MESSAGE_HEADER_AND_BODY : CGFloat = 0

//MARK:- TOOLBAR
let TOOLBAR_HEIGHT : CGFloat = 54.0
let TOOLBAR_MAX_HEIGHT : CGFloat = 156.0
let TOOLBAR_BUTTON_HEIGHT : CGFloat = 32.0
let TOOLBAR_BUTTON_WIDTH : CGFloat = 32.0


//MARK:- Strings
let INPUT_FIELD_PLACEHOLDER = "Type a message..."

