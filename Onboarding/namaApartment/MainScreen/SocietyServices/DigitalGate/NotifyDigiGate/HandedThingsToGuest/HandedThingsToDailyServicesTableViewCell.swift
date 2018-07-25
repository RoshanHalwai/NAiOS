//
//  HandedThingsToDailyServicesTableViewCell.swift
//  nammaApartment
//
//  Created by Sundir Talari on 13/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsToDailyServicesTableViewCell: UITableViewCell {
    
    //created object to use history button action in cell class
    var objHistoryVC : (() -> Void)? = nil
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var lbl_Rating: UILabel!
    @IBOutlet weak var lbl_InTime: UILabel!
    @IBOutlet weak var lbl_Flats: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var lbl_ServiceName: UILabel!
    @IBOutlet weak var lbl_ServiceType: UILabel!
    @IBOutlet weak var lbl_ServiceRating: UILabel!
    @IBOutlet weak var lbl_ServiceInTime: UILabel!
    @IBOutlet weak var lbl_ServiceFlats: UILabel!
    @IBOutlet weak var lbl_ThingsGiven: UILabel!
    
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var txt_Description: UITextField!
    @IBOutlet weak var btn_NotifyGate: UIButton!
    
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    //Defining cell Height
    class var expandedHeight: CGFloat { get { return 340 } }
    class var defaultHeight: CGFloat  { get { return 215 } }
    
    @IBAction func btn_NotifyGate_Action(_ sender: UIButton) {
        if let btnAction = self.objHistoryVC {
            btnAction()
        }
    }
}
