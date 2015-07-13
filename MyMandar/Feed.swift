//
//  Feed.swift
//  MyMandar
//
//  Created by Surana, Jigar on 7/11/15.
//  Copyright (c) 2015 Surana, Jigar. All rights reserved.
//

import UIKit

class Feed: NSObject {
    var feed_title :String
    var feed_text :String
    var feed_image :String
    var upload_date :String
    var uploaded_by :String
    
    override init() {
        feed_image = ""
        feed_text = ""
        feed_title = ""
        upload_date = ""
        uploaded_by = ""
    }
}
