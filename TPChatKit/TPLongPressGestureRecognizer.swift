//
//  TPLongPressGestureRecognizer.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 02/10/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class TPLongPressGestureRecognizer: UILongPressGestureRecognizer {
    var message : TPMessage?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
}
