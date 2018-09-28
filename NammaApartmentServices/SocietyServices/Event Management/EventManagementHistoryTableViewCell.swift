//
//  EventManagementHistoryTableViewCell.swift
//  nammaApartment
//
//  Created by kalpana on 9/20/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class EventManagementHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_EventTitle: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_EventDate: UILabel!
    
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var lbl_EventTitle_Details: UILabel!
    @IBOutlet weak var lbl_Status_Details: UILabel!
    @IBOutlet weak var lbl_EventDate_Details: UILabel!
    
    @IBOutlet var lbl_SelectedSlots: [UILabel]!
    
    @IBOutlet var lbl_8AM_11AM: [UILabel]!
    @IBOutlet var lbl_11AM_2PM: [UILabel]!
    @IBOutlet var lbl_2PM_5PM: [UILabel]!
    @IBOutlet var lbl_5PM_8PM: [UILabel]!
    @IBOutlet var lbl_8PM_FullDay: [UILabel]!
    
    @IBOutlet weak var stackView_8AM_11AM: UIStackView!
    @IBOutlet weak var stackView_11AM_2PM: UIStackView!
    @IBOutlet weak var stackView_2PM_5PM: UIStackView!
    @IBOutlet weak var stackView_5PM_8PM: UIStackView!
    @IBOutlet weak var stackView_8PM_FullDay: UIStackView!
}