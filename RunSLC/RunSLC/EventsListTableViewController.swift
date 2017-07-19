//
//  EventsListTableViewController.swift
//  RunSLC
//
//  Created by handje on 7/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class EventsListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventController.fetchEventbriteEvents { (events) in
            var eventResults: [Event] = []
            eventResults.append(contentsOf: events)
            
            EventController.fetchActiveEvents { (events) in
                eventResults.append(contentsOf: events)
                self.eventResults = eventResults
                
                
                // create group
                let imageGroup = DispatchGroup()
                for event in self.eventResults {
                    // enter
                    imageGroup.enter()
                    EventController.fetchEventImage(event: event, completion: {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        // leave
                        imageGroup.leave()
                    })
                }
            }
        }
    }
    
    //    // reload the tableview cell that corresponds to the event
    //
    //    // Or you could reload the whole tableview if you want to be lazy
    
    var eventResults = [Event]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventsTableViewCell else { return UITableViewCell() }
        
        let event = eventResults[indexPath.row]
        
        cell.event = event
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventDetailView" {
            guard let detailVC = segue.destination as? EventDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.event = eventResults[indexPath.row]
        }
    }
}
