//
//  UNService.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 24/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseDatabase

class UNService: NSObject {
    
    private override init() {}
    
    static let shared = UNService()
    let unCenter = UNUserNotificationCenter.current()
    
    var window: UIWindow?
    let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "There is no UN Authorization Error")
            guard granted else { return }
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
    
    func configure() {
        unCenter.delegate = self
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    
    //This is for Performing Action, when user clicks on notification view.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        //Getting guestUID & guestType from UserInfo & using it for setting values in firebase.
        let guestType = userInfo[Constants.FIREBASE_CHILD_VISITOR_TYPE] as? String
        let guestUID = userInfo[Constants.FIREBASE_CHILD_NOTIFICATION_UID] as? String
        let profilePhoto = userInfo[NAString()._profile_photo()] as? String
        let message = userInfo[NAString()._message_()] as? String
        let mobileNumber = userInfo[NAString().mobile_Number()] as? String
        let useruid = userInfo["user_uid"] as? String
        
        let guestPref = UserDefaults.standard
        guestPref.set(guestType, forKey: Constants.NOTIFICATION_GUEST_TYPE)
        guestPref.set(guestUID, forKey: Constants.NOTIFICATION_GUEST_UID)
        guestPref.set(profilePhoto, forKey: Constants.NOTIFICATION_GUEST_PROFILE_PHOTO)
        guestPref.set(mobileNumber, forKey: Constants.NOTIFICATION_GUEST_MOBILE_NUMBER)
        guestPref.set(message, forKey: Constants.NOTIFICATION_GUEST_MESSAGE)
        guestPref.set(useruid, forKey: Constants.FIREBASE_USERUID)
        guestPref.synchronize()
        
        // self.loadingUserData.retrieveUserDataFromFirebase(userId: userUID)
        let notificationVC = self.storyboard.instantiateViewController(withIdentifier: NAViewPresenter().notificationVC())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = notificationVC
        appDelegate.window?.makeKeyAndVisible()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }
    
    //Created delay function, so we can call our function after specific time.
    func delay(_ delay: Double, closure: @escaping() -> ()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    //This method will call when notification will recieved by the device.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        let userInfo = notification.request.content.userInfo
        
        //Getting guestUID & guestType from UserInfo & using it for setting values in firebase.
        let guestType = userInfo[Constants.FIREBASE_CHILD_VISITOR_TYPE] as? String
        let guestUID = userInfo[Constants.FIREBASE_CHILD_NOTIFICATION_UID] as? String
        
        //retrieving user’sFlat Details
        let userFlatDetails = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_FLATDETAILS)
        userFlatDetails.observeSingleEvent(of: .value) { (flatSnapshot) in
            
            //Getting Data Form Firebase & Adding into Model Class
            let userFlatData = flatSnapshot.value as? [String: AnyObject]
            
            let apartmentName = userFlatData?[UserFlatListFBKeys.apartmentName.key] as! String
            let city = userFlatData?[UserFlatListFBKeys.city.key] as! String
            let flatNumber = userFlatData?[UserFlatListFBKeys.flatNumber.key] as! String
            let societyName = userFlatData?[UserFlatListFBKeys.societyName.key] as! String
            
            if (guestUID != nil) && guestType != nil {
                
                let gateNotificationUserRef = Constants.FIREBASE_USERDATA_PRIVATE.child(city).child(societyName).child(apartmentName).child(flatNumber).child(Constants.FIREBASE_CHILD_GATE_NOTIFICATION).child(userUID)
                
                let gateNotificationRef = gateNotificationUserRef.child(guestType!).child(guestUID!)
                let gateNotificationStatusRef = gateNotificationUserRef.child(guestType!).child(guestUID!).child(Constants.FIREBASE_STATUS)
                
                //This deplay function we are calling to set ignored value in firebase, if user not accept & reject the E-Intercom Visitor.
                self.delay(30) {
                    
                    gateNotificationStatusRef.observeSingleEvent(of: .value, with: { (statusSnapshot) in
                        if !statusSnapshot.exists() {
                            center.removeAllDeliveredNotifications()
                            gateNotificationRef.child(NAString().status()).setValue(NAString().ignored())
                        }
                    })
                }
            }
        }
        completionHandler(options)
    }
}
