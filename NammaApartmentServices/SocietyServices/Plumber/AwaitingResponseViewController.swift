//
//  SocietyServicesDataViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/3/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AwaitingResponseViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Title : UILabel?
    @IBOutlet weak var lbl_message : UILabel?
    @IBOutlet weak var lbl_Accepted : UILabel?
    @IBOutlet weak var lbl_Name : UILabel?
    @IBOutlet weak var lbl_Mobile : UILabel?
    @IBOutlet weak var lbl_OTP: UILabel?
    @IBOutlet weak var lbl_ServiceName : UILabel?
    @IBOutlet weak var lbl_ServiceNumber : UILabel?
    @IBOutlet weak var lbl_ServiceOTP: UILabel?
    
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    @IBOutlet weak var img_Title : UIImageView?
    @IBOutlet weak var cardView : UIView?
    
    //To set navigation title
    var navTitle : String?
    var titleString : String?
    var notificationUID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)
        
        //assigning font & style to cell labels
        lbl_Title?.font = NAFont().headerFont()
        lbl_message?.font = NAFont().headerFont()
        lbl_ServiceName?.font = NAFont().headerFont()
        lbl_ServiceNumber?.font = NAFont().headerFont()
        lbl_ServiceOTP?.font = NAFont().headerFont()
        lbl_Name?.font = NAFont().textFieldFont()
        lbl_Mobile?.font = NAFont().textFieldFont()
        lbl_OTP?.font = NAFont().textFieldFont()
        
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
        
        //created custom back button for goto MainScreen view Controller
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToMainScreenVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to Main Screen View Controller.
    @objc func goBackToMainScreenVC() {
        let mainScreenVC = NAViewPresenter().mainScreenVC()
        self.navigationController?.pushViewController(mainScreenVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Retrieving Society Service Accepted Data
        if !(notificationUID.isEmpty) {
            let societyServiceReference = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL
                .child(notificationUID)
            
            societyServiceReference.observe(DataEventType.value, with: { (snapshot) in
                let societyServiceData = snapshot.value as? [String: AnyObject]
                
                //Checking whether Service Person Accepted the User Request or not
                if (societyServiceData?[NASocietyServicesFBKeys.takenBy.key] != nil &&
                    societyServiceData?[NASocietyServicesFBKeys.endOTP.key] != nil) {
                    let societyServiceUID: String = societyServiceData?[NASocietyServicesFBKeys.takenBy.key] as! String
                    let societyServiceType: String = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
                    
                    let societyServiceDataRef = Constants.FIREBASE_SOCIETY_SERVICES
                        .child(societyServiceType)
                        .child(Constants.FIREBASE_CHILD_PRIVATE)
                        .child(Constants.FIREBASE_CHILD_DATA)
                        .child(societyServiceUID)
                    
                    //Getting Service Person Name and Mobile Number
                    societyServiceDataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.lbl_Title?.isHidden = true
                        self.lbl_message?.isHidden = true
                        self.activityIndicator?.isHidden = true
                        self.cardView?.isHidden = false
                        
                        let serviceData = snapshot.value as? [String: AnyObject]
                        let societyServiceName: String = serviceData?[NASocietyServicesFBKeys.fullName.key] as! String
                        let societyServiceNumber: String = serviceData?[NASocietyServicesFBKeys.mobileNumber.key] as! String
                        
                        self.lbl_ServiceName?.text = societyServiceName
                        self.lbl_ServiceNumber?.text = societyServiceNumber
                        let endOTP: String = societyServiceData?[NASocietyServicesFBKeys.endOTP.key] as! String
                        self.lbl_ServiceOTP?.text = endOTP
                    })
                }
            })
        }
    }
    
    //Create Changing the Society Service Messages Function
    func changingSocietyServiceMessages() {
        if ( titleString == NAString().plumber()) {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().plumber())
        } else if (titleString == NAString().carpenter()) {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().carpenter())
        } else if (titleString == NAString().electrician()) {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().electrician())
        } else {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().garbage_management())
        }
    }
}
