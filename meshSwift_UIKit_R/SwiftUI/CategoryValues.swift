//
//  Category-Values.swift
//  D&D-Tool
//
//  Created by Michele Simonetti on 29/05/2020.
//  Copyright © 2020 Michele Simonetti. All rights reserved.
//

import Foundation

struct CategoryValues:Codable,Hashable,Identifiable{
    
    var id: Int
    var name:String
    var equipSlot:String
    
}
