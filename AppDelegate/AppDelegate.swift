////
////  AppDelegate.swift
////  namaAppartment
////
////  Created by Vikas Nayak on 30/04/18.
////  Copyright © 2018 Vikas Nayak. All rights reserved.

import UIKit
import UserNotifications
import FirebaseCore
import FirebaseMessaging
import FirebaseDatabase
import Crashlytics
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    //GCM is stands fro Google Cloud Messaging
    let gcmMessageIDKey = "gcm.message_id"
    
    let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
    
    //This method will call when application finished its launching state.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let launchVC = self.storyboard.instantiateViewController(withIdentifier: "RootVC")
        self.window?.rootViewController = launchVC
        self.window?.makeKeyAndVisible()
        
        //Formatting Navigation Controller From Globally.
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.black
        
        //Firebase app Configuration & assigning delegate to messaging services.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        //Setup firebase Crashlytics here
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        
        //Calling Notification action button function
        setActionCategories()
        
        /*Calling UNService Notification Class for Push Notifications */
        UNService.shared.authorize()
        
        return true
    }
    
    //Notification action button function
    func setActionCategories(){
        let acceptAction = UNNotificationAction(
            identifier: NAString().notificationAcceptIdentifier(),
            title: NAString().accept().capitalized,
            options: [.init(rawValue: 0)])
        
        let rejectAction = UNNotificationAction(
            identifier: NAString().notificationRejectIdentifier(),
            title: NAString().reject().capitalized,
            options: [.init(rawValue: 0)])
        
        let actionCategory = UNNotificationCategory(
            identifier: NAString().notificationActionCategory(),
            actions: [acceptAction,rejectAction],
            intentIdentifiers: [],
            options: [.customDismissAction])
        
        UNUserNotificationCenter.current().setNotificationCategories(
            [actionCategory])
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //Calling establishing channel for FCM function
        connectToFCM()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //Calling establishing channel for FCM function
        connectToFCM()
    }
    
    //Creating function to establishing channel for FCM
    func connectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    //This method will call when notification will recieved by the device.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Change this to your preferred presentation option
        completionHandler([.alert ,.badge ,.sound])
    }
    
    //This is for Performing Action, when user clicks on notification view.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        //On click of particular Notification it will navigate to that particular screen.
        //Created varibale to get Notification Type from UserInfo
        let notificationType = userInfo[Constants.FIREBASE_NOTIFICATION_TYPE] as? String
        
        if notificationType == Constants.FIREBASE_NOTIFICATION_TYPE_NOTICE_BOARD {
            let dest = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().noticeBoardScreen())
            self.window?.rootViewController = dest
            self.window?.makeKeyAndVisible()
            UIApplication.shared.applicationIconBadgeNumber = 0
        } else {
            let launchVC = self.storyboard.instantiateViewController(withIdentifier: "RootVC")
            self.window?.rootViewController = launchVC
            self.window?.makeKeyAndVisible()
        }
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        //Getting guestUID & guestType from UserInfo & using it for setting values in firebase.
        let guestType = userInfo[Constants.FIREBASE_CHILD_VISITOR_TYPE] as? String
        let guestUID = userInfo[Constants.FIREBASE_CHILD_NOTIFICATION_UID] as? String
        let profilePhoto = userInfo[NAString()._profile_photo()] as? String
        let message = userInfo[NAString()._message_()] as? String
        let mobileNumber = userInfo[NAString().mobile_Number()] as? String
        
        //Here we are performing Action on Notification Buttons & We created this buttons in  "setActionCategories" function.
        if response.notification.request.content.categoryIdentifier == NAString().notificationActionCategory() {
            
            //Created Firebase reference to get currently invited visitor by E-Intercom
            var gateNotificationRef : DatabaseReference?
            gateNotificationRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_GATE_NOTIFICATION).child(userUID).child(guestType!).child(guestUID!)
            
            //Performing accept & reject on click of recently invited visitor by E-Intercom from Notification view.
            switch response.actionIdentifier {
                
            //If Accept button will pressed
            case NAString().notificationAcceptIdentifier():
                gateNotificationRef?.child(NAString().status()).setValue(NAString().accepted())
                var visitorType = String()
                if guestType == Constants.FIREBASE_CHILD_GUESTS {
                    visitorType = Constants.FIREBASE_CHILD_VISITORS
                } else if guestType == Constants.FIREBASE_CHILD_CABS {
                    visitorType = Constants.FIREBASE_CHILD_CABS
                } else {
                    visitorType = Constants.FIREBASE_CHILD_DELIVERIES
                }
                let postApprovedRef = Database.database().reference().child(visitorType).child(Constants.FIREBASE_CHILD_PRIVATE).child(guestUID!)
                
                //Getting Current Date and Time when User clicked on Accept
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = NAString().current_Date_Format()
                let currentDate = formatter.string(from: date)
                
                if visitorType == Constants.FIREBASE_CHILD_VISITORS {
                    
                    //Mapping GuestUID with true
                    let userDataGuestRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_VISITORS).child(userUID)
                    userDataGuestRef.child(guestUID!).setValue(NAString().gettrue())
                    
                    let guestMobileRef = Constants.FIREBASE_VISITORS_ALL.child(mobileNumber!)
                    guestMobileRef.setValue(guestUID)
                    //Storing Post Approved Guests
                    let replacedMessage = message?.replacingOccurrences(of: NAString().your_Guest(), with: "")
                    let visitorRef = replacedMessage?.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
                    let postApprovedGuestsData = [
                        VisitorListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                        VisitorListFBKeys.uid.key : guestUID,
                        VisitorListFBKeys.dateAndTimeOfVisit.key : currentDate,
                        VisitorListFBKeys.status.key : NAString().entered(),
                        VisitorListFBKeys.fullName.key : visitorRef,
                        VisitorListFBKeys.inviterUID.key : userUID,
                        VisitorListFBKeys.profilePhoto.key : profilePhoto,
                        VisitorListFBKeys.mobileNumber.key : mobileNumber
                    ]
                    postApprovedRef.setValue(postApprovedGuestsData)
                } else if visitorType == Constants.FIREBASE_CHILD_CABS {
                    
                    //Mapping CabUID with true
                    let userDataCabRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_CABS).child(userUID)
                    userDataCabRef.child(guestUID!).setValue(NAString().gettrue())
                    
                    //Storing PostApproved Cabs
                    let replacedMessage = message?.replacingOccurrences(of: NAString().your_Cab_Numbered(), with: "")
                    let visitorRef = replacedMessage?.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
                    let cabNUmberRef = Constants.FIREBASE_CABS_ALL.child(visitorRef!)
                    cabNUmberRef.setValue(guestUID)
                    let postApprovedCabs = [
                        ArrivalListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                        ArrivalListFBKeys.dateAndTimeOfArrival.key : currentDate,
                        ArrivalListFBKeys.inviterUID.key : userUID,
                        ArrivalListFBKeys.reference.key : visitorRef,
                        ArrivalListFBKeys.status.key :NAString().entered(),
                        ArrivalListFBKeys.validFor.key : NAString()._2_hrs()
                    ]
                    postApprovedRef.setValue(postApprovedCabs)
                } else {
                    
                    //Mapping PackageUID with true
                    let userDataPackageRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DELIVERIES).child(userUID)
                    userDataPackageRef.child(guestUID!).setValue(NAString().gettrue())
                    
                    //Storing PostApproved Packages
                    let replacedMessage = message?.replacingOccurrences(of: NAString().your_package_vendor(), with: "")
                    let visitorRef = replacedMessage?.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
                    let postApprovedPackages = [
                        ArrivalListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                        ArrivalListFBKeys.dateAndTimeOfArrival.key : currentDate,
                        ArrivalListFBKeys.inviterUID.key : userUID,
                        ArrivalListFBKeys.reference.key : visitorRef,
                        ArrivalListFBKeys.status.key :NAString().entered(),
                        ArrivalListFBKeys.validFor.key : NAString()._2_hrs()
                    ]
                    postApprovedRef.setValue(postApprovedPackages)
                }
                break
                
            //If Reject button will pressed
            case NAString().notificationRejectIdentifier():
                gateNotificationRef?.child(NAString().status()).setValue(NAString().rejected())
                break
                
            default:
                break
            }
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(Messaging.messaging().fcmToken as Any)
    }
}
