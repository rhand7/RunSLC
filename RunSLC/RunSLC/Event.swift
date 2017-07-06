//
//  Event.swift
//  RunSLC
//
//  Created by handje on 7/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import UIKit

class Event {
    
    // MARK: - Keys
    
    fileprivate let eventbriteNameDictionaryKey = "name"
    fileprivate let eventbriteNameTextKey = "text"
    
    fileprivate let eventbriteDateDictionaryKey = "start"
    fileprivate let eventbriteDateTimeKey = "local"
    
    fileprivate let eventbriteDescriptionDictionaryKey = "description"
    fileprivate let eventbriteDescriptionTextKey = "text"
    
    fileprivate let eventbriteImageEndpointKey = "url"
    
    fileprivate let activeEventNameKey = "assetName"
    fileprivate let activeImageURLKey = "logoUrlAdr"
    
    fileprivate let activeEventURLKey = "homePageUrlAdr"
    fileprivate let activeDescriptionDictionaryKey = "assetDescriptions"
    fileprivate let activeDescriptionNumberKey = "0"
    
    //     MARK: - Properties
    
    let nameText: String
    let date: String?
    let descriptionText: String
    let imageEndpoint: String
    var image: UIImage?
    
//    let activeNameText: String
//    let activeDescriptionText: String
//    let activeImageEndpoint: String
//    var activeImage: UIImage?
    
    //Initializers
    
//    init(eventbriteNameText: String, eventbriteDate: String, eventbriteDescriptionText: String, eventbriteImageEndpoint: String, eventbriteImage: UIImage?, activeNameText: String, activeDescriptionText: String, activeImageEndpoint: String, activeImage: UIImage?) {
//        
//        self.eventbriteNameText = eventbriteNameText
//        self.eventbriteDate = eventbriteDate
//        self.eventbriteDescriptionText = eventbriteDescriptionText
//        self.eventbriteImageEndpoint = eventbriteImageEndpoint
//        self.eventbriteImage = eventbriteImage
//        
//        self.activeNameText = activeNameText
//        self.activeDescriptionText = activeDescriptionText
//        self.activeImageEndpoint = activeImageEndpoint
//        self.activeImage = activeImage
//    }
    
    init?(eventbriteJSONDictionary: [String: Any]) {
        
        guard let eventbriteNameDictionary = eventbriteJSONDictionary[eventbriteNameDictionaryKey] as? [String: Any],
            let eventbriteNameText = eventbriteNameDictionary[eventbriteNameTextKey] as? String,
            let eventbriteDateDictionary = eventbriteJSONDictionary[eventbriteDateDictionaryKey] as? [String: Any],
            let eventbriteDate = eventbriteDateDictionary[eventbriteDateTimeKey] as? String,
            let eventbriteDescriptionDictionary = eventbriteJSONDictionary[eventbriteDescriptionDictionaryKey] as? [String: Any],
            let eventbriteDescriptionText = eventbriteDescriptionDictionary[eventbriteDescriptionTextKey] as? String,
            let eventbriteImageEndpoint = eventbriteJSONDictionary[eventbriteImageEndpointKey] as? String else { return nil }
        
        self.nameText = eventbriteNameText
        self.date = eventbriteDate
        self.descriptionText = eventbriteDescriptionText
        self.imageEndpoint = eventbriteImageEndpoint
    }
//    
    init?(activeJSONDictionary: [String: Any]) {
        guard let activeEventText = activeJSONDictionary[activeEventNameKey] as? String,
            let activeImageEndpoint = activeJSONDictionary[activeImageURLKey] as? String,
            let activeDescriptionDict = activeJSONDictionary[activeDescriptionDictionaryKey] as? [[String: Any]],
            let activeDescriptionText = activeDescriptionDict.map { (activeDescriptionNumberKey: $0) } as? String else { return nil }
        
        self.nameText = activeEventText
        self.imageEndpoint = activeImageEndpoint
        self.descriptionText = activeDescriptionText
        self.date = ""
    }
}


