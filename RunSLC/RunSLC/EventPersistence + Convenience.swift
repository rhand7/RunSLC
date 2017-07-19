//
//  Event + Convenience.swift
//  RunSLC
//
//  Created by handje on 7/13/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension EventPersistence {
    
    convenience init(nameText: String, date: String?, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.nameText = nameText
        self.date = date
        self.isCompleted = false
    }
    
}
