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
import Crashlytics
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
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
        
        /*Calling UNService Notification Class for Push Notifications */
        UNService.shared.authorize()
        
        return true
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(Messaging.messaging().fcmToken as Any)
    }
}
