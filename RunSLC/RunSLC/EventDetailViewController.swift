//
//  EventDetailViewController.swift
//  RunSLC
//
//  Created by handje on 7/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if let event = event {
            eventImage?.image = event.originalImage 
            eventNameLabel?.text = event.eventNameText
            eventDescriptionLabel?.text = event.descriptionText
        }
    }
}
