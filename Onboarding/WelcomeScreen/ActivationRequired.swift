//
//  WelcomeViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 25/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseMessaging

class ActivationRequired: NANavigationViewController {
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var welcomeDescription: UILabel!
    
    //Created instance for calling function from retrieveUserData class
    var loadingUserData = retrieveUserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeImage.isHidden = true
        self.welcomeDescription.isHidden = true
        
        super.ConfigureNavBarTitle(title: NAString().accountCreated())
        welcomeDescription.font = NAFont().textFieldFont()
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = nil
        
        //Calling userPrivileges function on load
        userPrivileges()
    }
    
    func userPrivileges() {
        var userUID = String()
        userUID = (Auth.auth().currentUser?.uid)!
        
        //Created Token ID & Storing in Firebase
        let token = Messaging.messaging().fcmToken
        
        var usersTokenRef : DatabaseReference?
        usersTokenRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
        usersTokenRef?.child(NAUser.NAUserStruct.tokenId).setValue(token)
        
        var usersVerifiedRef : DatabaseReference?
        usersVerifiedRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
            .child(Constants.FIREBASE_CHILD_PRIVILEGES)
            .child(Constants.FIREBASE_CHILD_VERIFIED)
        
        usersVerifiedRef?.observe(DataEventType.value, with: { (verifiedSnapshot) in
            let isVerified = verifiedSnapshot.value as! Int
            
            switch isVerified {
            case 1 :
                self.loadingUserData.retrieveUserDataFromFirebase(userId: userUID)
                let dest = NAViewPresenter().mainScreenVC()
                self.navigationController?.pushViewController(dest, animated: true)
                break
            case 2 :
                self.welcomeImage.isHidden = true
                self.welcomeDescription.isHidden = true
                self.navigationController?.isNavigationBarHidden = false
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().userRejectedByAdminDescription())
                break
            default:
                self.welcomeImage.isHidden = false
                self.welcomeDescription.isHidden = false
                self.welcomeDescription.text = NAString().welcomeScreenDescription()
            }
        })
    }
}
