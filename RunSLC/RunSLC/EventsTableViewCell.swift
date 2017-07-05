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
    
    func updateEventCell(event: Event) {
        eventNameLabel.text = event.eventNameText
        eventDateLabel.text = event.date
        eventImage.image = event.croppedImage 
    } 
}
