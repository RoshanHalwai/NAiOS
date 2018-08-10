////
////  AppDelegate.swift
////  namaAppartment
////
////  Created by Vikas Nayak on 30/04/18.
////  Copyright © 2018 Vikas Nayak. All rights reserved.

import UIKit
import UserNotifications
import FirebaseInstanceID
import FirebaseCore
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    //GCM is stands fro Google Cloud Messaging
    let gcmMessageIDKey = "gcm.message_id"
    
    //This method will call when application finished its launching state.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
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
        
        //If User Data is empty then we navigate users to Login Screen, else we navigate users to Home screen
        let preferences = UserDefaults.standard
        let currentLevelKey = "USERUID"
        let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
        if preferences.object(forKey: currentLevelKey) == nil {
            let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().splashScreenRootVC())
            self.window?.rootViewController = NavLogin
            self.window?.makeKeyAndVisible()
            return true
        }
        
        let NavMain = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().mainNavigation())
        self.window?.rootViewController = NavMain
        self.window?.makeKeyAndVisible()
        return true
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
    
    // Creating function to establishing channel for FCM
    func connectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    // This method will call when notification will recieved by the device.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        
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
        print(userInfo)
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
