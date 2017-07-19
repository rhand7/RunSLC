//
//  Event+CoreDataProperties.swift
//  RunSLC
//
//  Created by handje on 7/13/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var nameText: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var imageEndpoint: String?
    @NSManaged public var image: NSData?
    @NSManaged public var date: String?

}
