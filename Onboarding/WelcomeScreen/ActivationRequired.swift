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

class ActivationRequired: NANavigationViewController {
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var welcomeDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.ConfigureNavBarTitle(title: NAString().accountCreated())
        welcomeDescription.font = NAFont().textFieldFont()
        welcomeDescription.text = NAString().welcomeScreenDescription()
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = nil
        
        //Calling userPrivileges function on load
        userPrivileges()
    }
    
    func userPrivileges() {
        var userUID = String()
        userUID = (Auth.auth().currentUser?.uid)!
        
        var usersVerifiedRef : DatabaseReference?
        usersVerifiedRef = Constants.FIREBASE_USER_PRIVATE.child(userUID)
            .child(Constants.FIREBASE_CHILD_PRIVILEGES)
            .child(Constants.FIREBASE_CHILD_VERIFIED)
        
        usersVerifiedRef?.observe(DataEventType.value, with: { (verifiedSnapshot) in
            if verifiedSnapshot.exists() &&  (verifiedSnapshot.value as? Bool)!{
                
                //Navigating to main screen
                let dest = NAViewPresenter().mainScreenVC()
                self.navigationController?.pushViewController(dest, animated: true)
            }
        })
    }
}