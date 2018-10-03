//
//  CookCollectionViewCell.swift
//  nammaApartment
//
//  Created by kalpana on 8/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ApartmentServicesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myCookImage: UIImageView!
    @IBOutlet weak var lbl_MyCookName: UILabel!
    @IBOutlet weak var lbl_MyCookRating: UILabel!
    @IBOutlet weak var lbl_MyCookFlat: UILabel!
    @IBOutlet weak var lbl_CookName: UILabel!
    @IBOutlet weak var lbl_CookRating: UILabel!
    @IBOutlet weak var lbl_CookFlat: UILabel!
    
    @IBOutlet weak var lbl_Call: UILabel!
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_WhatsApp: UILabel!
    @IBOutlet weak var lbl_Refer: UILabel!
    
    @IBOutlet weak var activity_Indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Setting Label Fonts
        lbl_MyCookName.font = NAFont().headerFont()
        lbl_MyCookRating.font = NAFont().headerFont()
        lbl_MyCookFlat.font = NAFont().headerFont()
        lbl_CookName.font = NAFont().textFieldFont()
        lbl_CookRating.font = NAFont().textFieldFont()
        lbl_CookFlat.font = NAFont().textFieldFont()
        
        lbl_Call.font = NAFont().cellButtonFont()
        lbl_Message.font = NAFont().cellButtonFont()
        lbl_WhatsApp.font = NAFont().cellButtonFont()
        lbl_Refer.font = NAFont().cellButtonFont()
    }
    
    var actionCall : (() -> Void)? = nil
    var actionMessage : (() -> Void)? = nil
    var actionWhatsAPP : (() -> Void)? = nil
    var actionRefer : (() -> Void)? = nil
    
    //To call your cook directly from app
    @IBAction func btnCall(_ sender: UIButton) {
        if let btnAction = self.actionCall {
            btnAction()
        }
    }
    
    //calling object on WhatsApp button action
    @IBAction func btnWhatsApp(_ sender: UIButton) {
        if let btnAction = self.actionWhatsAPP {
            btnAction()
        }
    }
    
    //calling object on Refer button action
    @IBAction func btnRefer(_ sender: UIButton) {
        if let btnAction = self.actionRefer {
            btnAction()
        }
    }
    
    //To message your Cook directly from app
    @IBAction func btnMessage(_ sender: UIButton) {
        if let btnAction = self.actionMessage {
            btnAction()
        }
    }
}
