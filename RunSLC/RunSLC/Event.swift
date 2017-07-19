//
//  Event.swift
//  RunSLC
//
//  Created by handje on 7/13/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import UIKit

class Event {
    
    // MARK: - Keys
    
    fileprivate let eventbriteNameDictionaryKey = "name"
    fileprivate let eventbriteNameTextKey = "text"
    
    fileprivate let eventbriteURLKey = "url"
    
    fileprivate let eventbriteDateDictionaryKey = "start"
    fileprivate let eventbriteDateTimeKey = "local"
    
    fileprivate let eventbriteDescriptionDictionaryKey = "description"
    fileprivate let eventbriteDescriptionTextKey = "text"
    
    fileprivate let eventbriteLogoKey = "logo"
    fileprivate let eventbriteImageEndpointKey = "url"
    
    fileprivate let activeEventNameKey = "assetName"
    fileprivate let activeImageURLKey = "logoUrlAdr"
    
    fileprivate let activeEventURLKey = "homePageUrlAdr"
    fileprivate let activeDescriptionDictionaryKey = "assetDescriptions"
    
    fileprivate let activeEventDate = "activityEndDate"
    
    // MARK: - Properties
    
    let nameText: String
    let descriptionText: String
    let imageEndpoint: String
    var image: UIImage?
    let date: String
    let url: String
    var eventURL: URL? 
    
    init?(eventbriteJSONDictionary: [String: Any]) {
        
        guard let eventbriteNameDictionary = eventbriteJSONDictionary[eventbriteNameDictionaryKey] as? [String: Any],
            let eventbriteNameText = eventbriteNameDictionary[eventbriteNameTextKey] as? String,
            let eventbriteDescriptionDictionary = eventbriteJSONDictionary[eventbriteDescriptionDictionaryKey] as? [String: Any],
            let eventbriteDescriptionText = eventbriteDescriptionDictionary[eventbriteDescriptionTextKey] as? String,
            let eventbriteLogo = eventbriteJSONDictionary[eventbriteLogoKey] as? [String: Any],
            let eventbriteImageEndpoint = eventbriteLogo[eventbriteImageEndpointKey] as? String,
            let eventbriteDateDict = eventbriteJSONDictionary[eventbriteDateDictionaryKey] as? [String: Any],
            let eventbriteDate = eventbriteDateDict[eventbriteDateTimeKey] as? String,
            let eventbriteURL = eventbriteJSONDictionary[eventbriteURLKey] as? String else { return nil }
        
        self.nameText = eventbriteNameText
        self.descriptionText = eventbriteDescriptionText
        self.imageEndpoint = eventbriteImageEndpoint
        self.date = eventbriteDate
        self.url = eventbriteURL
    }
    
    init?(activeJSONDictionary: [String: Any]) {
        guard let activeEventText = activeJSONDictionary[activeEventNameKey] as? String,
            let activeImageEndpoint = activeJSONDictionary[activeImageURLKey] as? String,
            let activeDescriptionDict = activeJSONDictionary[activeDescriptionDictionaryKey] as? [[String: Any]],
            let activeEventURL = activeJSONDictionary[activeEventURLKey] as? String,
            let activeEventDate = activeJSONDictionary[activeEventDate] as? String else { return nil }
        let activeDescriptionText = activeDescriptionDict.flatMap { $0["description"] as? String }
        guard let activeDescription = activeDescriptionText.first else { print("description is nil"); return nil }
        
        self.nameText = activeEventText
        self.descriptionText = activeDescription
        self.imageEndpoint = activeImageEndpoint
        self.date = activeEventDate
        self.url = activeEventURL 
    }
}


