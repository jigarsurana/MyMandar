//
//  Event.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/11/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class Event: NSObject {

    var event_name: String
    var event_venue: String
    var event_date: String
    var event_time: String
    var event_by: String
    var event_image: String
    
    override init() {
        event_name = ""
        event_venue = ""
        event_date = ""
        event_time = ""
        event_by  = ""
        event_image = ""
    }
}
