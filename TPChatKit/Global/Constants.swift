
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
let TEXT_MESSGAE_CELL_ID = "TPTextMessageCell"
let PICTURE_MESSGAE_CELL_ID = "TPPictureMessageCell"
let HEADER_VIEW_ID = "TPMessageHeaderView"

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

var HEADER_DATE_FONT : UIFont{
    get{
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
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

var HEADER_DATE_FONT_SIZE : CGFloat{
    get{
        return HEADER_DATE_FONT.pointSize
    }
}

var currentFontPointSize : CGFloat?

//MARK:- Color
let CHAT_VIEW_BACKGROUND_COLOR = UIColor(named: "chat_view_background_color")
let INCOMING_MESSAGE_BUBBLE_COLOR = UIColor(named: "incoming_message_bubble_color")!
let INCOMING_MESSAGE_TEXT_COLOR = UIColor(named: "incoming_message_text_color")!
let INCOMING_TIMESTAMP_TEXT_COLOR = UIColor.gray
let INCOMING_MEDIA_TIMESTAMP_TEXT_COLOR = UIColor.white

let OUTGOING_MESSAGE_BUBBLE_COLOR = UIColor(named: "outgoing_message_bubble_color")!
let OUTGOING_MESSAGE_TEXT_COLOR = UIColor(named: "outgoing_message_text_color")!
let OUTGOING_TIMESTAMP_TEXT_COLOR = UIColor.gray
let OUTGOING_MEDIA_TIMESTAMP_TEXT_COLOR = UIColor.white

let HEADER_DATE_LABEL_BACKGROUND_COLOR = UIColor(named: "header_date_label_background_color")!
let HEADER_DATE_LABEL_TEXT_COLOR = UIColor(named: "header_date_label_text_color")!

let TOOLBAR_TEXTVIEW_BACKGROUND_COLOR = UIColor(named: "toolbar_textview_background_color")!
let TOOLBAR_TEXTVIEW_TEXT_COLOR = UIColor(named: "toolbar_textview_text_color")!
let TOOLBAR_TEXTVIEW_PLACEHOLDER_COLOR = UIColor.lightGray

//MARK:- Bubble
let HORIZONTAL_PADDING_BETWEEN_MESSAGE_BUBBLE_AND_CELL : CGFloat = 5.0
let MESSAGE_BUBBLE_CORNER_RADIUS : CGFloat = 10.0
let PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS : CGFloat = 10.0
let PADDING_BETWEEN_CELLS_FROM_SAME_USER : CGFloat = 2.5
let PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE : CGFloat = 2.5
let HORIZONTAL_PADDING_BETWEEN_MESSAGE_TEXT_AND_TIMESTAMP : CGFloat = 5.0
let VERTICAL_PADDING_BETWEEN_MESSAGE_BODY_AND_TIMESTAMP : CGFloat = 5.0

let MESSAGE_BUBBLE_CAP_INSETS = UIEdgeInsets(top: 17, left: 20, bottom: 17, right: 20)
let INCOMING_MESSAGE_BUBBLE_CONTENT_INSET = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5)
let OUTGING_MESSAGE_BUBBLE_CONTENT_INSET = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 15)
let MESSAGE_BUBBLE_LONG_PRESS_DURATION : CFTimeInterval = 0.5

var MESSAGE_BODY_MAX_WIDTH : CGFloat {
    get{
        return msgBubbleMaxWidth - INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.left - INCOMING_MESSAGE_BUBBLE_CONTENT_INSET.right
    }
}

//Picture Message Bubble
var MESSAGE_IMAGE_MAX_BODY_SIZE: CGSize {
    return CGSize(width: MESSAGE_BODY_MAX_WIDTH - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE, height: MESSAGE_BODY_MAX_WIDTH - PADDING_BETWEEN_TIMESTAMP_AND_MESSAGE_BUBBLE)
}
let MESSAGE_IMAGE_MIN_BODY_SIZE = CGSize(width: 100, height: 100)

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
let INPUT_FIELD_PLACEHOLDER = "Type a message"



