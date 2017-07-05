//
//  EventController.swift
//  RunSLC
//
//  Created by handje on 7/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation

class EventController {
    
    static let events: [Event] = []
    
    // MARK: - baseURL
    
    static let baseURLEventbrite = URL(string: "https://www.eventbriteapi.com/v3/events/search/")
    
//    static let baseURLMeetup = URL(string: "https://api.meetup.com/SaltLakeRunningClub/events?photo-host=public&page=20&sig_id=195974553&sig=731153fb91cd71a8c9e8d32d6d1c121a049a37e1")
    
    // MARK: - fetchEventbrite
    
    static func fetchEventbriteEvents(completion: @escaping ((_: [Event]) -> Void)) {
        
        guard let url = baseURLEventbrite else { fatalError("URL optional is nil") }
        
        let urlParameters = ["token": "GEMP6TBTBXPDRATETQ6T",
                             "q": "running",
                             "sort_by": "date",
                             "location.address": "SaltLakeCity",
                             "location.within": "50mi",
                             "categories": "108"]
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters, body: nil) { (data, error) in
                
                if let error = error {
                    NSLog("\(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let data = data,
                    let responseDataString = String(data: data, encoding: .utf8) else {
                        NSLog("No data returned from data request")
                        completion([])
                        return
                }
                
                guard let responseDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                    let eventsDictionaries = responseDictionary["events"] as? [[String: Any]] else {
                        NSLog("Unable to serialize JSON. \nResponse: \(responseDataString)")
                        completion([])
                        return
                }
            
            let events = eventsDictionaries.flatMap { Event(jsonDictionary: $0) }
            
            guard let imageURL = events.imageEndpoint else { completion([]); return }
            
            ImageController.image(forURL: imageURL, completion: { (image) in
                events?.image = image
                completion(events)
            })
        }
    }
    
    // MARK: - fetchMeetup
    
//    static func fetchMeetupEvents(completion: @escaping ((_: [Event]) -> Void)) {
//        guard let url = baseURLMeetup else { fatalError("URL optional is nil") }
//        
//        let url
//    }
}
