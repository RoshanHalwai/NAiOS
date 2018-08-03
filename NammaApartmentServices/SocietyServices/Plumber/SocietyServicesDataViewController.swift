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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)
        
        //cardUIView
        cardView?.layer.cornerRadius = 3
        cardView?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView?.layer.shadowRadius = 1.7
        cardView?.layer.shadowOpacity = 0.45
        
        //Hiding CardView
        cardView?.isHidden = true
    }
}
