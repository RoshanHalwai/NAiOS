//
//  HandedThingsHistoryCollectionViewCell.swift
//  nammaApartment
//
//  Created by Sundir Talari on 09/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsGuestHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image_View: UIImageView!
    @IBOutlet weak var lbl_Visitor_Type: UILabel!
    @IBOutlet weak var lbl_Date_Type: UILabel!
    @IBOutlet weak var lbl_InTime_Type: UILabel!
    @IBOutlet weak var lbl_Inviter_Type: UILabel!
    @IBOutlet weak var lbl_Things_Type: UILabel!
    
    @IBOutlet weak var lbl_Visitor_Detail: UILabel!
    @IBOutlet weak var lbl_Date_Detail: UILabel!
    @IBOutlet weak var lbl_InTime_Detail: UILabel!
    @IBOutlet weak var lbl_Inviter_Detail: UILabel!
    @IBOutlet weak var lbl_Things_Detail: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        super .layoutSubviews()
        //setting image round
        self.image_View.layer.cornerRadius = self.image_View.frame.size.width/2
        self.image_View.clipsToBounds = true
    }
}
