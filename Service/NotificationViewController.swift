//
//  NotificationViewController.swift
//  NotificationServiceExtension
//
//  Created by Vikas Nayak on 30/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase

class NotificationViewController: NANavigationViewController {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnAccept: UIButton!
    
    var guestType = String()
    var guestUID = String()
    var profilePhot = String()
    var mobileNumber = String()
    var message = String()
    var userUID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let UserUID = NAString().userDefault_USERUID()
        
        let guestPref = UserDefaults.standard
         guestType = guestPref.object(forKey: "guestType") as! String
         guestUID = guestPref.object(forKey: "guestUID") as! String
         profilePhot = guestPref.object(forKey: "profilePhot") as! String
         mobileNumber = guestPref.object(forKey: "mobileNumber") as! String
         message = guestPref.object(forKey: "message") as! String
         userUID = guestPref.object(forKey: UserUID) as! String

        //Retrieving Image
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        imageView.sd_setImage(with: URL(string: profilePhot), completed: nil)
        
        guestPref.removeObject(forKey: "guestType")
        guestPref.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Checking Users UID in Firebase under Users ->Private
       let usersPrivateRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
        //Checking userData inside Users/Private
        usersPrivateRef.observe(.value, with: { (snapshot) in
            //If usersUID is Exists then retrievd all the data of user.
            if snapshot.exists() {
                
                let userData = snapshot.value as? NSDictionary
                print("UserData:",userData as Any)
                
                //Retrieving & Adding data in Flat Detail Class
                let flatdetails_data = userData![Constants.FIREBASE_CHILD_FLATDETAILS] as? [String :Any]
                let userFlatDetails = UserFlatDetails.init(
                    apartmentName: flatdetails_data![Constants.FIREBASE_CHILD_APARTMENT_NAME] as? String,
                    city: (flatdetails_data![Constants.FIREBASE_CHILD_CITY] as! String),
                    flatNumber: flatdetails_data![Constants.FIREBASE_CHILD_FLATNUMBER] as? String,
                    societyName: flatdetails_data![Constants.FIREBASE_CHILD_SOCIETY_NAME] as? String,
                    tenantType: flatdetails_data![Constants.FIREBASE_CHILD_TENANT_TYPE] as? String)
                flatDetailsFB.append(userFlatDetails)
                GlobalUserData.shared.flatDetails_Items = flatDetailsFB
            }
        })
    }
    
    @IBAction func btnAccepted(_ sender: UIButton) {
        let guestDataRef = GlobalUserData.shared.getUserDataReference()
        .child(Constants.FIREBASE_CHILD_GATE_NOTIFICATION)
        .child(userUID)
        .child(self.guestType)
        .child(self.guestUID)
        guestDataRef.child(Constants.FIREBASE_STATUS).setValue("Accepted")
    }
}
