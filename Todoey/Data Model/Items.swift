//
//  Items.swift
//  Todoey
//
//  Created by Kumoyo Mukunyandela on 01.10.18.
//  Copyright © 2018 tusso. All rights reserved.
//

import Foundation

class Items {
    
   var itemList = [Item]()
    
    init(){
        let item1 = Item("Call Zani", false)
        let item2 = Item("Call Mum", false)
        let item3 = Item("Buy Milk", false)
        let item4 = Item("Write Program", false)
    }
}
