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
    
    //Implementing Launch Screen
    private func launchScreen() {
        let launchScreenVC = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        let rootVC = launchScreenVC.instantiateViewController(withIdentifier: "launchScreen")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(dismissLaunchScreen), userInfo: nil, repeats: false)
    }
    
    @objc func dismissLaunchScreen() {
        //Using userDefaults here we are checking conditions & navigation to particular view according to userDefault values.
        let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
        let preferences = UserDefaults.standard
        let UserUID = NAString().userDefault_USERUID()
        let notFirstTime =  NAString().userDefault_Not_First_Time()
        let loggedIn = NAString().userDefault_Logged_In()
        let accountCreated = NAString().userDefault_Account_Created()
        let verified = NAString().userDefault_Verified()
        
        if preferences.bool(forKey: notFirstTime) == true {
            /* Checking Both Conditions to make sure that user is still able to Navigate to main Screen after once he LoggedIn even though if it is different device */
            if preferences.bool(forKey: accountCreated) == true || preferences.bool(forKey: loggedIn) == true {
                if preferences.bool(forKey: verified) == true {
                    if preferences.bool(forKey: loggedIn) == true {
                        let NavMain = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().mainNavigation())
                        self.window?.rootViewController = NavMain
                        self.window?.makeKeyAndVisible()
                    } else {
                        let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().loginNavigation())
                        self.window?.rootViewController = NavLogin
                        self.window?.makeKeyAndVisible()
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
                            
                            let NavMain = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().mainNavigation())
                            self.window?.rootViewController = NavMain
                            self.window?.makeKeyAndVisible()
                        } else {
                            let NavMain = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().welcomeRootVC())
                            self.window?.rootViewController = NavMain
                            self.window?.makeKeyAndVisible()
                        }
                    })
                }
            } else {
                let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().loginNavigation())
                self.window?.rootViewController = NavLogin
                self.window?.makeKeyAndVisible()
            }
        } else {
            preferences.set(true, forKey: notFirstTime)
            preferences.synchronize()
            let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().splashScreenRootVC())
            self.window?.rootViewController = NavLogin
            self.window?.makeKeyAndVisible()
        }
    }
    
    //This method will call when application finished its launching state.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Calling Launch Screen Method
        self.launchScreen()
        //Formatting Navigation Controller From Globally.
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.black
        
        //If iOS version is 10 or later then this will call.
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_,_ in })
            
            //else if iOS version is 9 or earlier then this will call.
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        //Firebase app Configuration & assigning delegate to messaging services.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        //Setup firebase Crashlytics here
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        
        //Calling Notification action button function
        setActionCategories()
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
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //Calling establishing channel for FCM function
        connectToFCM()
        UIApplication.shared.applicationIconBadgeNumber = 0
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
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        //Getting guestUID & guestType from UserInfo & using it for setting values in firebase.
        let guestType = userInfo[Constants.FIREBASE_CHILD_VISITOR_TYPE] as? String
        let guestUID = userInfo[Constants.FIREBASE_CHILD_NOTIFICATION_UID] as? String
        let profilePhoto = userInfo[NAString()._profile_photo()] as? String
        let message = userInfo[NAString()._message_()] as? String
        
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
                        VisitorListFBKeys.profilePhoto.key : profilePhoto
                    ]
                    postApprovedRef.setValue(postApprovedGuestsData)
                } else if visitorType == Constants.FIREBASE_CHILD_CABS {
                    //Storing PostApproved Cabs
                    let replacedMessage = message?.replacingOccurrences(of: NAString().your_Cab_Numbered(), with: "")
                    let visitorRef = replacedMessage?.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
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
    
    // This method is for refreshing the Token ID
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    // This method is called on iOS 10 devices to handle data messages received via FCM
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}
