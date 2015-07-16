//
//  FeedModel.swift
//  
//
//  Created by Surana, Jigar on 7/16/15.
//
//

import Foundation
import CoreData

class FeedModel: NSManagedObject {

    @NSManaged var uploader: String
    @NSManaged var title: String
    @NSManaged var feed_description: String

}
