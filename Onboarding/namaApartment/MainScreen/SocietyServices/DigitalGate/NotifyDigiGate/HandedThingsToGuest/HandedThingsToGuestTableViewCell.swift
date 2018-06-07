//
//  HandedThingsToGuestCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 10/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsToGuestTableViewCell: UITableViewCell
{
    @IBOutlet weak var lbl_Visiter: UILabel!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Invited: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var lbl_VisiterName: UILabel!
    @IBOutlet weak var lbl_GuestType: UILabel!
    @IBOutlet weak var lbl_GuestDate: UILabel!
    @IBOutlet weak var lbl_GuestTime: UILabel!
    @IBOutlet weak var lbl_GuestInvitedBy: UILabel!
    @IBOutlet weak var lbl_ThingsGiven: UILabel!
    
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var txt_Description: UITextField!
    @IBOutlet weak var btn_NotifyGate: UIButton!
    
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    //Defining cell Height
    class var expandedHeight: CGFloat { get { return 340 } }
    class var defaultHeight: CGFloat  { get { return 215 } }
    
}


