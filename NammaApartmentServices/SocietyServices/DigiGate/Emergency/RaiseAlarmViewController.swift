//
//  RaiseAlarmViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 15/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RaiseAlarmViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Header: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    var userDataEmergencyref : DatabaseReference?
    var privateEmergencyRef : DatabaseReference?
    var publicEmergencyRef : DatabaseReference?
    
    var titleName =  String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide description label on view load
        self.lbl_Description.isHidden = true
        
        //Formatting & setting Navigation bar
        super.ConfigureNavBarTitle(title: titleName)
    }
    
    @IBAction func btnRaiseAlarm(_ sender: UIButton) {
        NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().emergency_alert_Title(), Message: NAString().emergency_Alert_Message(), CancelStyle: .default, OkStyle: .destructive, OK: {(action) in
            self.lbl_Description.isHidden = false
            
            //Mapping Emergency UID's under UserData
            self.userDataEmergencyref = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_EMERGENCY)
            
            let emergencyUID : String?
            emergencyUID = (self.userDataEmergencyref?.childByAutoId().key)!
            
            self.userDataEmergencyref?.child(emergencyUID!).setValue(NAString().gettrue())
            
            //Getting User Flat number
            let userFlatDetails = GlobalUserData.shared.flatDetails_Items.first
            
            //Mapping UID's in Emergency Private
            self.privateEmergencyRef = Database.database().reference()
            self.privateEmergencyRef?.child(Constants.FIREBASE_CHILD_EMERGENCY).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(Constants.FIREBASE_USER_CHILD_ALL).child((userFlatDetails?.flatNumber)!).child(emergencyUID!).setValue(NAString().gettrue())
            
            
            //Storing data in Emergency Public Reference
            self.publicEmergencyRef = Database.database().reference().child(Constants.FIREBASE_CHILD_EMERGENCY).child(Constants.FIREBASE_USER_PUBLIC).child(emergencyUID!)
            
            var emergencyType : String?
            
            if self.titleName == NAString().medical_emergency() {
                emergencyType = NAString().medical()
            } else if self.titleName == NAString().raise_Fire_Alarm_Title() {
                emergencyType = NAString().fire()
            } else {
                emergencyType = NAString().theft()
            }
            
            //defining node with type of data in it.
            let dailyServicesData = [
                EmergencyFBKeys.flatNumber.key : GlobalUserData.shared.flatDetails_Items.first?.flatNumber as Any,
                EmergencyFBKeys.apartmentName.key : GlobalUserData.shared.flatDetails_Items.first?.apartmentName as Any,
                EmergencyFBKeys.fullName.key : GlobalUserData.shared.personalDetails_Items.first?.fullName as Any,
                EmergencyFBKeys.phoneNumber.key : GlobalUserData.shared.personalDetails_Items.first?.phoneNumber as Any,
                EmergencyFBKeys.emergencyType.key : emergencyType as Any] as [String : Any]
            
            self.publicEmergencyRef?.setValue(dailyServicesData)
            
        }, Cancel: {(action) in})
    }
}
