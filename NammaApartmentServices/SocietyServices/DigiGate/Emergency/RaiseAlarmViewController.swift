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
    var emergencyType = String()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide description label on view load
        self.lbl_Description.isHidden = true
        
        //Formatting & setting Navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        
        //info Button Action
        infoButton()
    }
    
    @IBAction func btnRaiseAlarm(_ sender: UIButton) {
        
        NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().emergency_alert_Title(), Message: NAString().emergency_Alert_Message(), CancelStyle: .default, OkStyle: .destructive, OK: {(action) in
            self.lbl_Description.isHidden = false
            
            //Created switch for getting proper emergency type according to screen Title.
            switch self.titleName {
            case NAString().medicalEmergency_Title() :
                self.emergencyType = NAString().medical()
                break
                
            case NAString().raise_Fire_Alarm_Title() :
                self.emergencyType = NAString().fire()
                break
                
            case NAString().raise_Theft_Alarm_Title() :
                self.emergencyType = NAString().theft()
                break
                
            case NAString().raise_water_Alarm_Title() :
                self.emergencyType = NAString().water()
                break
                
            default:
                break
            }
           
            //Mapping Emergency UID's under UserData
            self.userDataEmergencyref = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_EMERGENCY)
            
            let emergencyUID : String?
            emergencyUID = (self.userDataEmergencyref?.childByAutoId().key)!
            
            self.userDataEmergencyref?.child(emergencyUID!).setValue(NAString().gettrue())
            
            //Getting User Flat number
            let userFlatDetails = GlobalUserData.shared.flatDetails_Items.first
            
            //Mapping UID's in Emergency Private
            self.privateEmergencyRef = Constants.FIREBASE_EMERGENCY_PRIVATE_ALL
            self.privateEmergencyRef?.child((userFlatDetails?.flatNumber)!).child(emergencyUID!).setValue(NAString().gettrue())
            
            //Storing data in Emergency Public Reference
            self.publicEmergencyRef = Constants.FIREBASE_EMERGENCY_PUBLIC.child(emergencyUID!)
            
            //defining node with type of data in it.
            let dailyServicesData = [
                EmergencyFBKeys.flatNumber.key : GlobalUserData.shared.flatDetails_Items.first?.flatNumber as Any,
                EmergencyFBKeys.apartmentName.key : GlobalUserData.shared.flatDetails_Items.first?.apartmentName as Any,
                EmergencyFBKeys.fullName.key : GlobalUserData.shared.personalDetails_Items.first?.fullName as Any,
                EmergencyFBKeys.phoneNumber.key : GlobalUserData.shared.personalDetails_Items.first?.phoneNumber as Any,
                EmergencyFBKeys.emergencyType.key : self.emergencyType]
            
            self.publicEmergencyRef?.setValue(dailyServicesData)
            
        }, Cancel: {(action) in}, cancelActionTitle: NAString().cancel(), okActionTitle: NAString().ok())
    }
}
