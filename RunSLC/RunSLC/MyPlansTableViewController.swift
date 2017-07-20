//
//  MyPlansTableViewController.swift
//  RunSLC
//
//  Created by handje on 7/12/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit
import CoreData
import SafariServices


var heightOfHeader: CGFloat = 44

class MyPlansTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var eventPersistence: EventPersistence? 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        EventController.shared.fetchedResultsController.delegate = self
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = EventController.shared.fetchedResultsController.sections else { return 1 }
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = EventController.shared.fetchedResultsController.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scheduledEventCell", for: indexPath) as? MyPlansTableViewCell else { return MyPlansTableViewCell() }
        let event = EventController.shared.fetchedResultsController.object(at: indexPath)
        cell.delegate = self
        cell.event = event
        
        return cell
    }
    
    // TODO: - open safari  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = EventController.shared.fetchedResultsController.object(at: indexPath)
        
        guard let eventURL = event.url,
            let url = URL(string: eventURL) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = EventController.shared.fetchedResultsController.sections,
            let index = Int(sectionInfo[section].name) else { return nil }
        if index == 0 {
            return "UPCOMING"
        } else {
            return "COMPLETED"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightOfHeader
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let event = EventController.shared.fetchedResultsController.object(at: indexPath) 
            EventController.shared.deleteEventFromCalendar(persistedEvent: event)
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}


extension MyPlansTableViewController: MyPlansTableViewCellDelegate {
    
    func didTapCompleteButton(sender: MyPlansTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let event = EventController.shared.fetchedResultsController.object(at: indexPath)
        EventController.shared.toggleEventCompleted(persistedEvent: event)
    }
}
