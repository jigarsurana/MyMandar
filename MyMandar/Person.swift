//
//  Person.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/11/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class Person: NSObject {
   
    var first_name :String
    var middle_name :String
    var last_name :String
    var phone_regex :String
    var mobile1 :String
    var mobile2 :String
    var landline1 :String
    var landline2 :String
    var office1 :String
    var office2 :String
    var home_address :Address?
    var office_address:Address?
    
    override init() {
        first_name = ""
        middle_name = ""
        last_name = ""
        phone_regex = ""
        mobile1 = ""
        mobile2 = ""
        landline1 = ""
        landline2 = ""
        office1 = ""
        office2 = ""
        home_address = nil
        office_address = nil
    }
}
