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
}
