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
let MESSGAE_CELL_ID = "TPMessageCell"


//Font
var MESSAGE_SENDER_FONT : UIFont{
    get{
        return UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: UIFont.Weight.medium)
    }
}

var MESSAGE_TEXT_FONT : UIFont {
    get{
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }
}

var TIMESTAMP_FONT : UIFont {
    get{
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
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

let OUTGOING_MESSAGE_BUBBLE_COLOR = UIColor(red: 214/255.0, green: 254/255.0, blue: 199/255.0, alpha: 1.0)
let OUTGOING_MESSAGE_TEXT_COLOR = UIColor.black
let OUTGOING_TIMESTAMP_TEXT_COLOR = UIColor.gray

//Bubble
let HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL : CGFloat = 5.0
let MESSAGE_BUBBLE_CORNER_RADIUS : CGFloat = 10.0
let PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS : CGFloat = 10.0
let PADDING_BETWEEN_CELLS_FROM_SAME_USER : CGFloat = 2.5
let PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE : CGFloat = 2.5
let HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP : CGFloat = 5.0
let VERTICAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP : CGFloat = 5.0

let MESSAGE_BUBBLE_CAP_INSETS = UIEdgeInsets(top: 17, left: 20, bottom: 17, right: 20)
let INCOMING_MESSAGE_BUBBLE_CONTENT_INSET = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5)
let OUTGING_MESSAGE_BUBBLE_CONTENT_INSET = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 15)
let MESSAGE_BUBBLE_LONG_PRESS_DURATION : CFTimeInterval = 0.5

var MESSAGE_BODY_MAX_WIDTH : CGFloat {
    get{
        return msgBubbleMaxWidth - INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.left - INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.right
    }
}

//Bubble Image Name
let OUTGOING_LEADING_BUBBLE_NAME = "Outgoing_Leading_Bubble_Style1"
let OUTGOING_TRAILING_BUBBLE_NAME = "Outgoing_Trailing_Bubble_Style1"
let INCOMING_LEADING_BUBBLE_NAME = "Incoming_Leading_Bubble_Style1"
let INCOMING_TRAILING_BUBBLE_NAME = "Incoming_Trailing_Bubble_Style1"


//MARK:- TOOLBAR
let TOOLBAR_HEIGHT : CGFloat = 54.0
let TOOLBAR_MAX_HEIGHT : CGFloat = 156.0
let TOOLBAR_BUTTON_HEIGHT : CGFloat = 32.0
let TOOLBAR_BUTTON_WIDTH : CGFloat = 32.0


//MARK:- Strings
let INPUT_FIELD_PLACEHOLDER = "Type a message..."

