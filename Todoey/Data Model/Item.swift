//
//  Item.swift
//  Todoey
//
//  Created by Kumoyo Mukunyandela on 01.10.18.
//  Copyright © 2018 tusso. All rights reserved.
//

import Foundation

class Item {
    
    var title : String = ""
    var done : Bool = false
    
    init(_ itemTitle : String, _ itemDone : Bool){
        title = itemTitle
        done = itemDone
    }
}

