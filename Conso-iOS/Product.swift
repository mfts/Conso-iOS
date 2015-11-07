//
//  Product.swift
//  Conso-iOS
//
//  Created by Bilal Karim Reffas on 07.11.15.
//  Copyright © 2015 Quantum. All rights reserved.
//

import Foundation

struct Product {
    var name : String
    var urlItem : String
    var picture : String
    var deal : Bool
    
    init(name : String,urlItem : String,picture : String,deal : Bool){
        self.name = name
        self.urlItem = urlItem
        self.picture = picture
        self.deal = deal
    }
}