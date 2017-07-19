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
    @IBOutlet weak var backgroundCardView: UIView!
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let event = event else { return }
        eventNameLabel.text = event.nameText
        eventImage.image = event.image
        
        backgroundCardView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8 

    }
}
