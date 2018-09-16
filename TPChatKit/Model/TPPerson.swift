//
//  TPPerson.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/24/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class TPPerson: Equatable {
    
    private var id : String
    var name : String
    var fontColor : UIColor
    
    init(id: String, name: String, senderNameFontColor fontColor: UIColor = .black) {
        self.id = id
        self.name = name
        self.fontColor = fontColor
    }

    static func == (lhs: TPPerson, rhs: TPPerson) -> Bool {
        return lhs.id == rhs.id
    }
    
}
