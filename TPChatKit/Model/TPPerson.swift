//
//  TPPerson.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/24/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

class TPPerson: Equatable {
    
    private var id : String!
    var name : String! 
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    static func == (lhs: TPPerson, rhs: TPPerson) -> Bool {
        return lhs.id == rhs.id
    }
    
}
