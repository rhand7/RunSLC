//
//  EventsTableViewCell.swift
//  RunSLC
//
//  Created by handje on 7/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let event = event else { return }
        eventNameLabel.text = event.nameText
//        eventDateLabel.text = eventbriteEvent.eventbriteDate
        eventImage.image = event.image

    }
//    
//    func updateEventbriteCell(eventbriteEvent: Event) {
//        eventNameLabel.text = eventbriteEvent.eventbriteNameText
//        eventDateLabel.text = eventbriteEvent.eventbriteDate
//        eventImage.image = eventbriteEvent.eventbriteImage
//    }
//    
//    func updateActiveCell(activeEvent: Event) {
//        eventNameLabel.text = activeEvent.activeNameText
//        eventImage.image = activeEvent.activeImage 
//    }
}
