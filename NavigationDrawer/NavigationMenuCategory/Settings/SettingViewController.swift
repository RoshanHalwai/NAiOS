//
//  SettingViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 21/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SettingViewController: NANavigationViewController {
    
    @IBOutlet weak var general_Settings_View: UIView!
    @IBOutlet weak var sound_settings_View: UIView!
    
    @IBOutlet weak var general_Settings_Label: UILabel!
    @IBOutlet weak var language_Label: UILabel!
    @IBOutlet weak var btn_Language: UIButton!
    @IBOutlet weak var btn_signOut: UIButton!
    
    @IBOutlet weak var sound_Settings_Label: UILabel!
    @IBOutlet weak var eIntercom_Notification_Label: UILabel!
    @IBOutlet weak var guest_Notification_Label: UILabel!
    @IBOutlet weak var dailyService_Notification_Label: UILabel!
    @IBOutlet weak var cab_Notification_Label: UILabel!
    @IBOutlet weak var package_Notification_Label: UILabel!
    
    @IBOutlet weak var switch_EIntercom: UISwitch!
    @IBOutlet weak var switch_Guest: UISwitch!
    @IBOutlet weak var switch_DailyServices: UISwitch!
    
    var navTitle = String()
    var selectLanguage = String()
    var userNotificationRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveNotificationSoundFromFirebase()
        
        userNotificationRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_OTHER_DETAILS).child(Constants.FIREBASE_CHILD_NOTIFICATION_SOUND)
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Label Formatting and Setting
        general_Settings_Label.font = NAFont().headerFont()
        sound_Settings_Label.font = NAFont().headerFont()
        language_Label.font = NAFont().textFieldFont()
        eIntercom_Notification_Label.font = NAFont().textFieldFont()
        guest_Notification_Label.font = NAFont().textFieldFont()
        dailyService_Notification_Label.font = NAFont().textFieldFont()
        cab_Notification_Label.font = NAFont().textFieldFont()
        package_Notification_Label.font = NAFont().textFieldFont()
        btn_Language.titleLabel?.font = NAFont().textFieldFont()
        
        //Setting Label Text 
        general_Settings_Label.text = NAString().general_settings()
        sound_Settings_Label.text = NAString().sound_settings()
        language_Label.text = NAString().language()
        eIntercom_Notification_Label.text = NAString().eIntercom_Notification()
        guest_Notification_Label.text = NAString().guest_Notification()
        dailyService_Notification_Label.text = NAString().dailyService_Notification()
        cab_Notification_Label.text = NAString().cab_Notification()
        package_Notification_Label.text = NAString().package_Notification()
        
        //Creating Shadow Effect for Views
        NAShadowEffect().shadowEffectForView(view: general_Settings_View)
        NAShadowEffect().shadowEffectForView(view: sound_settings_View)
        
        //Button Formatting & settings
        btn_signOut.setTitle(NAString().signout(), for: .normal)
        btn_signOut.setTitleColor(NAColor().buttonFontColors(), for: .normal)
        btn_signOut.titleLabel?.font = NAFont().labelFont()
        
        //make button rounded corner
        btn_signOut.layer.cornerRadius = CGFloat(NAString().fifteen())
        
        //setting border width for button
        btn_signOut.layer.borderWidth = CGFloat(NAString().two())
    }
    
    @IBAction func switch_EIntercom(_ sender: UISwitch) {
        if (sender.isOn ==  true) {
           userNotificationRef?.child(Constants.FIREBASE_CHILD_EINTERCOM_SOUND).setValue(NAString().gettrue())
        } else {
             userNotificationRef?.child(Constants.FIREBASE_CHILD_EINTERCOM_SOUND).setValue(NAString().getfalse())
        }
     }
    
    @IBAction func switch_Guest(_ sender: UISwitch) {
        if (sender.isOn ==  true) {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_GUEST_SOUND).setValue(NAString().gettrue())
        } else {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_GUEST_SOUND).setValue(NAString().getfalse())
        }
    }
    
    @IBAction func switch_DailyServices(_ sender: UISwitch) {
        if (sender.isOn ==  true) {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_DAILYSERVICE_SOUND).setValue(NAString().gettrue())
        } else {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_DAILYSERVICE_SOUND).setValue(NAString().getfalse())
        }
    }
    
    @IBAction func switch_Cab(_ sender: UISwitch) {
        if (sender.isOn ==  true) {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_CAB_SOUND).setValue(NAString().gettrue())
        } else {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_CAB_SOUND).setValue(NAString().getfalse())
        }
    }
    
    @IBAction func switch_Package(_ sender: UISwitch) {
        if (sender.isOn ==  true) {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_PACKAGE_SOUND).setValue(NAString().gettrue())
        } else {
            userNotificationRef?.child(Constants.FIREBASE_CHILD_PACKAGE_SOUND).setValue(NAString().getfalse())
        }
    }
    
    //Create Button Actions
    @IBAction func languageButtonAction() {
        let vc = NAViewPresenter().languageVC()
        let nav : UINavigationController = UINavigationController(rootViewController: vc)
        vc.navigationTitle = NAString().selectLanguage()
        vc.settingVC = self
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func signoutButtonAction() {
        self.signoutAction()
    }
    
    //To Signout the current user
    @objc func signoutAction() {
        //Signout Confirmation Alert
        NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().logout_Confirmation_Title(), Message: NAString().logout_Confirmation_Message(), CancelStyle: .default, OkStyle: .destructive, OK: { (action) in
            let preferences = UserDefaults.standard
            let userUID = NAString().userDefault_USERUID()
            let loggedIn = NAString().userDefault_Logged_In()
            preferences.removeObject(forKey: userUID)
            preferences.set(false, forKey: loggedIn)
            preferences.synchronize()
            if self.storyboard != nil {
                let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
                let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().loginNavigation())
                self.present(NavLogin, animated: true)
            }
        }, Cancel: { (action) in}, cancelActionTitle: NAString().no(), okActionTitle: NAString().yes())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.btn_Language.titleLabel?.text = selectLanguage
    }
}

extension SettingViewController {
    
    func retrieveNotificationSoundFromFirebase() {
        
        let notificationSoundRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
            .child(Constants.FIREBASE_CHILD_OTHER_DETAILS)
            .child(Constants.FIREBASE_CHILD_NOTIFICATION_SOUND)
        
        notificationSoundRef.observeSingleEvent(of: .value) { (soundSnapshot) in
            print(soundSnapshot as Any)
            let notificationSoundData = soundSnapshot.value as! [String: Any]
            
            let cabValue = notificationSoundData["cab"] as! Bool
            let PackageValue = notificationSoundData["package"] as! Bool
            let dailyServiceValue = notificationSoundData["dailyService"] as! Bool
            let guestValue = notificationSoundData["guest"] as! Bool
            let eIntercomValue = notificationSoundData["eIntercom"] as! Bool
            
            
            
            
        }
    }
}

