//
//  EventManagementCardViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 21/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventManagementCardViewController: NANavigationViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_TimeSlot: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    
    @IBOutlet weak var lbl_TitleValue: UILabel!
    @IBOutlet weak var lbl_DateValue: UILabel!
    @IBOutlet weak var lbl_TimeSlotValue: UILabel!
    @IBOutlet weak var lbl_StatusValue: UILabel!
    
    @IBOutlet weak var lbl_TopDescription: UILabel!
    @IBOutlet weak var lbl_BottomDescription: UILabel!
    
    var navTitle = String()
    var getEventUID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Assigning Font to UILables
        lbl_Date.font = NAFont().textFieldFont()
        lbl_Date.font = NAFont().textFieldFont()
        lbl_TimeSlot.font = NAFont().textFieldFont()
        lbl_Status.font = NAFont().textFieldFont()
        
        lbl_TitleValue.font = NAFont().headerFont()
        lbl_DateValue.font = NAFont().headerFont()
        lbl_TimeSlotValue.font = NAFont().headerFont()
        lbl_StatusValue.font = NAFont().headerFont()
        
        lbl_TopDescription.font = NAFont().textFieldFont()
        lbl_BottomDescription.font = NAFont().textFieldFont()
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //cardUIView
        cardView?.layer.cornerRadius = 3
        cardView?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView?.layer.shadowRadius = 1.7
        cardView?.layer.shadowOpacity = 0.45
        
        //Calling Function to retrieve Event Data.
        retrieveEventManagement()
        
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
}

//Retrieving data to show event management list in card view
extension EventManagementCardViewController {
    
    func retrieveEventManagement() {
        
        self.cardView.isHidden = true
        NAActivityIndicator.shared.showActivityIndicator(view: self)

        var societyServiceNotificationsRef : DatabaseReference?
        
        societyServiceNotificationsRef = Database.database().reference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(Constants.FIREBASE_USER_CHILD_ALL).child(getEventUID)
        
        societyServiceNotificationsRef?.observe(.value, with: { (eventDataSnapshot) in
            
            //Getting all the event management data & storing in model class
            let eventManagementData = eventDataSnapshot.value as? [String: AnyObject]
            
            let eventTitle = eventManagementData?[NAEventManagementFBKeys.eventTitle.key]
            let eventDate = eventManagementData?[NAEventManagementFBKeys.eventDate.key]
            let eventStatus = eventManagementData?[NAEventManagementFBKeys.status.key]
            let eventTimeSlot = eventManagementData?[NAEventManagementFBKeys.timeSlot.key]
            
            if eventStatus as! String == Constants.FIREBASE_CHILD_IN_PROGRESS {
                self.lbl_DateValue.text = eventDate as? String
                self.lbl_TitleValue.text = eventTitle as? String
                self.lbl_StatusValue.text = eventStatus as? String
                self.lbl_TimeSlotValue.text = eventTimeSlot as? String
                self.lbl_BottomDescription.text = NAString().eventManagementBottomDescription()
                self.lbl_TopDescription.text = NAString().eventManagementTopDescription()
                
                self.cardView.isHidden = false
                NAActivityIndicator.shared.hideActivityIndicator()
            }
        })
    }
}
