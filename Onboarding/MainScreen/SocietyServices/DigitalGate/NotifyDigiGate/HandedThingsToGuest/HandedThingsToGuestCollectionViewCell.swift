//
//  HandedThingsToGuestCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 10/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsToGuestCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var lbl_Visiter: UILabel!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Invited: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var lbl_VisiterName: UILabel!
    @IBOutlet weak var lbl_GuestType: UILabel!
    @IBOutlet weak var lbl_GuestDate: UILabel!
    @IBOutlet weak var lbl_GuestTime: UILabel!
    @IBOutlet weak var lbl_GuestInvitedBy: UILabel!
    
    @IBOutlet weak var lbl_ThingsGiven: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var txt_Description: UITextField!
    
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    @IBAction func btnSegment(_ sender: Any)
    {
       
        
        switch segmentSelect.selectedSegmentIndex {
        case 0:
            lbl_Description.isHidden = false
            txt_Description.isHidden = false
            break
        case 1:
            lbl_Description.isHidden = true
            txt_Description.isHidden = true
            
        default:
            break
        }
    }
}


