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
    
    fileprivate let eventNameDictionaryKey = "name"
    fileprivate let eventNameTextKey = "text"
    
    fileprivate let dateDictionaryKey = "start"
    fileprivate let dateTimeKey = "local"
    
    fileprivate let descriptionDictionaryKey = "description"
    fileprivate let descriptionTextKey = "text"
    
    fileprivate let logoDictionaryKey = "logo"
    fileprivate let imageDictionaryKey = "original"
    fileprivate let imageEndpointKey = "url"
    
    //     MARK: - Properties
    
    let eventNameText: String
    let date: String
    let descriptionText: String
    let imageCroppedEndpoint: String
    let imageOriginalEndpoint: String
    var croppedImage: UIImage?
    var originalImage: UImage? 
    
    //Initializers
    
    init?(jsonDictionary: [String: Any]) {
        
        guard let eventNameDictionary = jsonDictionary[eventNameDictionaryKey] as? [String: Any],
            let eventNameText = eventNameDictionary[eventNameTextKey] as? String,
            
            let dateDictionary = jsonDictionary[dateDictionaryKey] as? [String: Any],
            let date = dateDictionary[dateTimeKey] as? String,
            
            let descriptionDictionary = jsonDictionary[descriptionDictionaryKey] as? [String: Any],
            let descriptionText = descriptionDictionary[descriptionTextKey] as? String,
            
            let logoDictionary = jsonDictionary[logoDictionaryKey] as? [String: Any],
            let imageDictionary = logoDictionary[imageDictionaryKey] as? [String: Any],
            let imageOriginalURL = imageDictionary[imageDictionaryKey] as? String,
            let imageCroppedURL = logoDictionary[imageEndpointKey] as? String else { return nil }
        
        self.eventNameText = eventNameText
        self.date = date
        self.descriptionText = descriptionText
        self.imageCroppedEndpoint = imageCroppedURL
        self.imageOriginalEndpoint = imageOriginalURL  
    }
    
}
