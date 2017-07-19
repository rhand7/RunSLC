//
//  EventDetailViewController.swift
//  RunSLC
//
//  Created by handje on 7/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit
import SafariServices

protocol AddToCalendarDelegate: class {
    func didTapAddToCalendar(name: String, date: String)
}

class EventDetailViewController: UIViewController {
    
    var upcomingEventDelegate: AddToCalendarDelegate?
    
    var event: Event? 
    
    // MARK: - IB Outlets
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var addToCalendarButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    // MARK: - IB Actions
    @IBAction func addToCalendarButtonTapped(_ sender: UIButton) {
        guard let name = event?.nameText,
            let date = event?.date else { return }
        
        EventController.shared.addEventToUpcoming(nameText: name, date: date)
        upcomingEventDelegate?.didTapAddToCalendar(name: name, date: date)
    }
    
    @IBAction func infoButton(_ sender: Any) {
        guard let eventURL = event?.url,
            let url = URL(string: eventURL) else { return } 
        
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    
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
}

