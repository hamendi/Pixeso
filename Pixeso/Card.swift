//
//  Card.swift
//  Pixeso
//
//  Created by Mohammed Hamendi on 08/10/2019.
//  Copyright © 2019 Mohammed Hamendi. All rights reserved.
//

import Foundation

struct Card {
    var id: Int
    var isFaceUp = false
    var isMatched = false
    
    static var idFactory = 0
    
    static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
        print("Card init called [\(self.id)]")
    }
    
}
