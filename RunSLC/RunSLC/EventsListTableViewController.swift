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
            self.eventResults = events
            DispatchQueue.main.async {
                self.tableView.reloadData()  
            }
        }
    }

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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventsTableViewCell else { return EventsTableViewCell() }
        
        let event = eventResults[indexPath.row]
        
        cell.updateEventCell(event: event)

        return cell
    }

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
