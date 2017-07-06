//
//  EventDetailViewController.swift
//  RunSLC
//
//  Created by handje on 7/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event: Event? 
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    func updateViews() {
        guard let event = event else { return }
        
        eventImage.image = event.image
        eventNameLabel.text = event.nameText
        eventDescriptionLabel.text = event.descriptionText
    }
    
    //
    //    func updateEventbrite() {
    //        if let eventbriteEvent = event {
    //            eventImage?.image = eventbriteEvent.eventbriteImage
    //            eventNameLabel?.text = eventbriteEvent.eventbriteNameText
    //            eventDescriptionLabel?.text = eventbriteEvent.eventbriteDescriptionText
    //        }
    //    }
    //
    //    func updateActiveEvent() {
    //        if let activeEvent = event {
    //            eventImage?.image = activeEvent.activeImage
    //            eventNameLabel.text = activeEvent.activeNameText
    //            eventDescriptionLabel.text = activeEvent.activeDescriptionText
    //        }
    //    }
}
