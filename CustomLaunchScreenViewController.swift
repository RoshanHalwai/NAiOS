//
//  CustomLaunchScreenViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 12/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CustomLaunchScreenViewController: NANavigationViewController {
    
    //Created instance for calling retrieveUserData class function
    var loadingUserData = retrieveUserData()
    
    @IBOutlet weak var launch_ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
        launch_ImageView.clipsToBounds = true
        launch_ImageView.layer.cornerRadius = 30
        
        self.navigationItem.rightBarButtonItem = nil
        dismissLaunchScreen()
    }
    
    func dismissLaunchScreen() {
        //Using userDefaults here we are checking conditions & navigation to particular view according to userDefault values.
        let preferences = UserDefaults.standard
        let UserUID = NAString().userDefault_USERUID()
        let notFirstTime =  NAString().userDefault_Not_First_Time()
        let loggedIn = NAString().userDefault_Logged_In()
        let accountCreated = NAString().userDefault_Account_Created()
        let verified = NAString().userDefault_Verified()
        
        let versionRef = Constants.FIREBASE_DATABASE_REFERENCE.child("versionName")
        versionRef.observe(.value) { (versionSnapshot) in
            let version = versionSnapshot.value as? String
            let presentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String
            if version != presentVersion {
                let alert = UIAlertController(title: NAString().new_Version_Title() , message: NAString().new_version_message(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NAString().update().capitalized, style: .default, handler: nil))
                alert.view.backgroundColor = UIColor.white
                alert.view.layer.cornerRadius = 10
                self.present(alert, animated: true)
            } else {
                if preferences.bool(forKey: notFirstTime) == true {
                    /* Checking Both Conditions to make sure that user is still able to Navigate to main Screen after once he LoggedIn even though if it is different device */
                    if preferences.bool(forKey: accountCreated) == true || preferences.bool(forKey: loggedIn) == true {
                        if preferences.bool(forKey: verified) == true {
                            if preferences.bool(forKey: loggedIn) == true {
                                var userUID = String()
                                userUID = preferences.object(forKey: UserUID) as! String
                                preferences.synchronize()
                                
                                self.loadingUserData.retrieveUserDataFromFirebase(userId: userUID)
                                let NavMain = self.storyboard?.instantiateViewController(withIdentifier:   NAViewPresenter().mainNavigation())
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.window?.rootViewController = NavMain
                                appDelegate.window?.makeKeyAndVisible()
                            } else {
                                let NavLogin = NAViewPresenter().loginVC()
                                self.navigationController?.pushViewController(NavLogin, animated: true)
                            }
                        } else {
                            var userUID = String()
                            userUID = preferences.object(forKey: UserUID) as! String
                            preferences.synchronize()
                            
                            var usersVerifiedRef : DatabaseReference?
                            usersVerifiedRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
                                .child(Constants.FIREBASE_CHILD_PRIVILEGES)
                                .child(Constants.FIREBASE_CHILD_VERIFIED)
                            
                            usersVerifiedRef?.observeSingleEvent(of: .value, with: { (verifiedSnapshot) in
                                if verifiedSnapshot.exists() &&  (verifiedSnapshot.value as? Bool)!{
                                    preferences.set(true, forKey: verified)
                                    preferences.synchronize()
                                    self.loadingUserData.retrieveUserDataFromFirebase(userId: userUID)
                                    let navMain = NAViewPresenter().mainScreenVC()
                                    self.navigationController?.pushViewController(navMain, animated: true)
                                } else {
                                    self.loadingUserData.retrieveUserDataFromFirebase(userId: userUID)
                                    let navWelcomeVC = NAViewPresenter().activationRequiredVC()
                                    self.navigationController?.pushViewController(navWelcomeVC, animated: true)
                                }
                            })
                        }
                    } else {
                        let NavLogin = NAViewPresenter().loginVC()
                        self.navigationController?.pushViewController(NavLogin, animated: true)
                    }
                } else {
                    preferences.set(true, forKey: notFirstTime)
                    preferences.synchronize()
                    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let NavLogin = mainStoryboard.instantiateViewController(withIdentifier: "splashNavID")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = NavLogin
                    appDelegate.window?.makeKeyAndVisible()
                }
            }
        }
    }
}
