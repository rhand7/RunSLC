//
//  MyPlansTableViewCell.swift
//  RunSLC
//
//  Created by handje on 7/17/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class MyPlansTableViewCell: UITableViewCell {

    var event: EventPersistence? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: MyPlansTableViewCellDelegate?
    
    // MARK: IB Outlets
    @IBOutlet weak var myPlansEventNameLabel: UILabel!
    @IBOutlet weak var myPlansEventDateLabel: UILabel!
    @IBOutlet weak var myPlansEventIsCompleteButton: UIButton!
    
    // MARK: IB Actions
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        delegate?.didTapCompleteButton(sender: self)
    }
    
        
    // MARK: updateViews
    func updateViews() {
        guard let event = event else { return }
        myPlansEventNameLabel.text = event.nameText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let stringFromAPI = event.date else { return }
        let eventDate = dateFormatter.date(from: stringFromAPI)
        
        dateFormatter.dateStyle = .medium
        
        myPlansEventDateLabel.text = "\(dateFormatter.string(from: eventDate!))"
        
        
        if event.isCompleted == false {
            myPlansEventNameLabel.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
            myPlansEventIsCompleteButton.setImage(#imageLiteral(resourceName: "incompletedMedal"), for: .normal)
        } else {
            myPlansEventNameLabel.textColor = UIColor(colorLiteralRed: 235/255, green: 149/255, blue: 89/255, alpha: 1)
            myPlansEventIsCompleteButton.setImage(#imageLiteral(resourceName: "completedMedal"), for: .normal)
        }
    }
}

protocol MyPlansTableViewCellDelegate: class {
    func didTapCompleteButton(sender: MyPlansTableViewCell)
}

extension MyPlansTableViewCell {
    func updateList(event: EventPersistence) {
        myPlansEventNameLabel.text = event.nameText
        myPlansEventDateLabel.text = event.date
        isCompleteButtonTapped(event.isCompleted)
    }
}
