//
//  Address.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/11/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class Address: NSObject {
    
    var line1: String
    var line2: String
    var city: String
    var state: String
    var zipcode: String
    var country: String
    
    override init() {
        line1 = ""
        line2 = ""
        city = ""
        state = ""
        zipcode = ""
        country = ""
    }
}
