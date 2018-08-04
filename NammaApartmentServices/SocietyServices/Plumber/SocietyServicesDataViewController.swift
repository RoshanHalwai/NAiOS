//
//  SocietyServicesDataViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/3/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SocietyServicesDataViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Title : UILabel?
    @IBOutlet weak var lbl_message : UILabel?
    @IBOutlet weak var lbl_Accepted : UILabel?
    @IBOutlet weak var lbl_Name : UILabel?
    @IBOutlet weak var lbl_Mobile : UILabel?
    @IBOutlet weak var lbl_ServiceName : UILabel?
    @IBOutlet weak var lbl_ServiceNumber : UILabel?
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    @IBOutlet weak var img_Title : UIImageView?
    @IBOutlet weak var cardView : UIView?
    
    //To set navigation title
    var navTitle : String?
    var titleString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)
        
        //assigning font & style to cell labels
        lbl_Title?.font = NAFont().headerFont()
        lbl_message?.font = NAFont().headerFont()
        lbl_ServiceName?.font = NAFont().headerFont()
        lbl_ServiceNumber?.font = NAFont().headerFont()
        lbl_Name?.font = NAFont().textFieldFont()
        lbl_Mobile?.font = NAFont().textFieldFont()
        
        //cardUIView
        cardView?.layer.cornerRadius = 3
        cardView?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView?.layer.shadowRadius = 1.7
        cardView?.layer.shadowOpacity = 0.45
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
        
        //Hiding CardView
        cardView?.isHidden = true
        
        //Calling Society Service Messages Function
        self.changingSocietyServiceMessages()
    }
    
    //Create Changing the Society Service Messages Function
    func changingSocietyServiceMessages() {
        if ( titleString == NAString().plumber()) {
            lbl_message?.text = NAString().societyServiceLabelMessage(name: "Plumber")
        } else if (titleString == NAString().carpenter()) {
            lbl_message?.text = NAString().societyServiceLabelMessage(name: "Carpenter")
        } else if (titleString == NAString().electrician()) {
            lbl_message?.text = NAString().societyServiceLabelMessage(name: "Electrician")
        } else {
            lbl_message?.text = NAString().societyServiceLabelMessage(name: "Garbage")
        }
    }
}
