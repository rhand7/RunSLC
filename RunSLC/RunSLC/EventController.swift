//
//  EventController.swift
//  RunSLC
//
//  Created by handje on 7/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//
//    static let baseURLMeetup = URL(string: "https://api.meetup.com/SaltLakeRunningClub/events?photo-host=public&page=20&sig_id=195974553&sig=731153fb91cd71a8c9e8d32d6d1c121a049a37e1")

// MARK: - fetchMeetup

//    static func fetchMeetupEvents(completion: @escaping ((_: [Event]) -> Void)) {
//        guard let url = baseURLMeetup else { fatalError("URL optional is nil") }
//
//        let urlParameters =
//    }

import Foundation
import CoreData

class EventController {
    
    var events = [Event]() 
    static let persistedEvents: [EventPersistence] = []
    
    static let shared = EventController()
    
    // MARK: - NSFetchedResultsController
    
    let fetchedResultsController: NSFetchedResultsController<EventPersistence>
    
    init() {
        let request: NSFetchRequest<EventPersistence> = EventPersistence.fetchRequest()
        let eventIsCompleteSortDescriptior = NSSortDescriptor(key: "isCompleted", ascending: true)
        let eventDateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [eventIsCompleteSortDescriptior, eventDateSortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isCompleted", cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Unable to perform fetch request: \(error.localizedDescription)")
        }
    }
    
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
                             "location.within": "100mi",
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
            
            completion(events)
            
        }
    }
    
    // MARK: - fetchActive
    
    static func fetchEventImage(event: Event, completion: () -> Void) {
        
        ImageController.image(forURL: event.imageEndpoint) { (image) in
            guard let image = image else { return }
            
            event.image = image
        }
        
    }
    
    static func fetchActiveEvents(completion: @escaping ((_: [Event]) -> Void)) {
        
        guard let url = baseURLActive else { fatalError("URL optional is nil") }
        
        let urlParameters = ["api_key": "xfxqgmsu9gpupbbxra7wc5fe",
                             "query": "running",
                             "category": "event",
                             "near": "Salt Lake City, UT, US",
                             "radius": "100",
                             "start_date": "2017-07-19..",
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
                    NSLog("Unable to serialize activeJSON. \nResponse: \(responseDataString)")
                    completion([])
                    return
            }
            
            let events = eventsDictionaries.flatMap { Event(activeJSONDictionary: $0) }
            
            completion(events)
            
        }
    }
    
    
    // MARK: - CRUD
    
    func addEventToUpcoming(nameText: String, date: String) {
        let _ = EventPersistence(nameText: nameText, date: date) 
        saveToPersistentStorage()
        try? fetchedResultsController.performFetch()
    }
    
    func toggleEventCompleted(persistedEvent: EventPersistence) {
        persistedEvent.isCompleted = !persistedEvent.isCompleted
        saveToPersistentStorage()
        try? fetchedResultsController.performFetch()
    }
    
    func deleteEventFromCalendar(persistedEvent: EventPersistence) {
        persistedEvent.managedObjectContext?.delete(persistedEvent)
        saveToPersistentStorage()
    }
    
    // MARK: - saveToPersistentStorage()
    
    func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving to persistent storage: \(error)")
        }
    }
    
}
