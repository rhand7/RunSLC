//
//  Event.swift
//  RunSLC
//
//  Created by handje on 7/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation

class Event {
    
    // MARK: - Keys 
    
    fileprivate let eventNameKey = "name"
    fileprivate let dateKey = "start"
    fileprivate let addressKey = "vanity_url"
    fileprivate let priceKey = "is_free"
    
    // MARK: - Properties 
    
    let eventName: String
    let date: Date
    let address: String
    let price: Double
    
    //Initializers
    
    init(eventName: String, date: Date, address: String, price: Double) {
        self.eventName = eventName
        self.date = date
        self.address = address
        self.price = price
    }
    
    init?(jsonDictionary: [String: Any]) {
        guard let eventName = jsonDictionary[eventNameKey] as? String,
        let date = jsonDictionary[dateKey] as? Date,
        let address = jsonDictionary[addressKey] as? String,
            let price = jsonDictionary[priceKey] as? Double else { return nil }
        
        self.eventName = eventName
        self.date = date
        self.address = address
        self.price = price
    }
    
}
