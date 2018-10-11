//
//  SendMessageTableViewCell.swift
//  nammaApartment
//
//  Created by kirtan labs on 11/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SendMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_Messages: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var parentView_Leading: NSLayoutConstraint!
    
    @IBOutlet weak var parentView_Trailing: NSLayoutConstraint!
}
