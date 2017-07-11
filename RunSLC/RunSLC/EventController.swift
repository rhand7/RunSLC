//
//  EventController.swift
//  RunSLC
//
//  Created by handje on 7/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//
//    static let baseURLMeetup = URL(string: "https://api.meetup.com/SaltLakeRunningClub/events?photo-host=public&page=20&sig_id=195974553&sig=731153fb91cd71a8c9e8d32d6d1c121a049a37e1")

import Foundation

class EventController {
    
    static let events: [Event] = []
    
    // MARK: - baseURL
    
    static let baseURLEventbrite = URL(string: "https://www.eventbriteapi.com/v3/events/search/")
    
    static let baseURLActive = URL(string: "http://api.amp.active.com/v2/search")
    
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
            
            let events = eventsDictionaries.flatMap { Event(eventbriteJSONDictionary: $0) }
            
            
            let group = DispatchGroup()
            
            var count = 0
            
            for event in events {
                group.enter()
                count += 1
                print(count)
                let imageURL = event.imageEndpoint
                
                ImageController.image(forURL: imageURL, completion: { (eventbriteImage) in
                    event.image = eventbriteImage
                    
                    count -= 1
                    print(count)
                    group.leave()
                })
                
            }
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                completion(events)
            })
            
        }
    }
    
    // MARK: - fetchActive
    
    static func fetchActiveEvents(completion: @escaping ((_: [Event]) -> Void)) {
        
        guard let url = baseURLActive else { fatalError("URL optional is nil") }
        
        let urlParameters = ["api_key": "xfxqgmsu9gpupbbxra7wc5fe",
                             "query": "running",
                             "category": "event",
                             "near": "Salt%20Lake%20City,UT,US",
                             "radius": "50",
                             "start_date": "2017-07-07..",
                             "sort": "date_asc",
                             "per_page": "100"]  
        
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
                let eventsDictionaries = responseDictionary["results"] as? [[String: Any]] else {
                    NSLog("Unable to serialize JSON. \nResponse: \(responseDataString)")
                    completion([])
                    return
            }
            
            let events = eventsDictionaries.flatMap { Event(activeJSONDictionary: $0) }
            
            
            let group = DispatchGroup()
            
            var count = 0
            
            for event in events {
                group.enter()
                count += 1
                print(count)
                let imageURL = event.imageEndpoint
                
                ImageController.image(forURL: imageURL, completion: { (activeImage) in
                    event.image = activeImage
                    
                    count -= 1
                    print(count)
                    group.leave()
                })
                
            }
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                completion(events)
            })
            
        }
    }
    
    
    // MARK: - fetchMeetup
    
    //    static func fetchMeetupEvents(completion: @escaping ((_: [Event]) -> Void)) {
    //        guard let url = baseURLMeetup else { fatalError("URL optional is nil") }
    //
    //        let urlParameters =
    //    }
}
