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
    
    fileprivate let eventbriteLogoKey = "logo"
    fileprivate let eventbriteImageEndpointKey = "url"
    
    fileprivate let activeEventNameKey = "assetName"
    fileprivate let activeImageURLKey = "logoUrlAdr"
    
    fileprivate let activeEventURLKey = "homePageUrlAdr"
    fileprivate let activeDescriptionDictionaryKey = "assetDescriptions"
    
    //     MARK: - Properties
    
    let nameText: String
    let descriptionText: String
    let imageEndpoint: String
    var image: UIImage?
    
    init?(eventbriteJSONDictionary: [String: Any]) {
        
        guard let eventbriteNameDictionary = eventbriteJSONDictionary[eventbriteNameDictionaryKey] as? [String: Any],
            let eventbriteNameText = eventbriteNameDictionary[eventbriteNameTextKey] as? String,
            let eventbriteDescriptionDictionary = eventbriteJSONDictionary[eventbriteDescriptionDictionaryKey] as? [String: Any],
            let eventbriteDescriptionText = eventbriteDescriptionDictionary[eventbriteDescriptionTextKey] as? String,
            let eventbriteLogo = eventbriteJSONDictionary[eventbriteLogoKey] as? [String: Any],
            let eventbriteImageEndpoint = eventbriteLogo[eventbriteImageEndpointKey] as? String else { return nil }
        
        self.nameText = eventbriteNameText
        self.descriptionText = eventbriteDescriptionText
        self.imageEndpoint = eventbriteImageEndpoint
    }
    
    init?(activeJSONDictionary: [String: Any]) {
        guard let activeEventText = activeJSONDictionary[activeEventNameKey] as? String,
            let activeImageEndpoint = activeJSONDictionary[activeImageURLKey] as? String,
            let activeDescriptionDict = activeJSONDictionary[activeDescriptionDictionaryKey] as? [[String: Any]] else { return nil }
        let activeDescriptionText = activeDescriptionDict.flatMap { $0["description"] as? String }
        guard let activeDescription = activeDescriptionText.first else { print("description is nil"); return nil }
        
        self.nameText = activeEventText
        self.descriptionText = activeDescription
        self.imageEndpoint = activeImageEndpoint
    }
}


