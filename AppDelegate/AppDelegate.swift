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
    
    //Databse URL Variables
    var FIREBASE_ENV = String()
    var APP_ENV = String()
    var DATABASE_URL = String()
    let DEFAULT_DEV_DATABASE_URL = "https://nammaapartments-development.firebaseio.com/"
    let DEFAULT_BETA_DATABASE_URL = "https://nammaapartments-beta.firebaseio.com/"
    
    //This method will call when application finished its launching state.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Formatting Navigation Controller From Globally.
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.black
        
        //Navigating to LaunchScreen
        let launchVC = self.storyboard.instantiateViewController(withIdentifier: NAViewPresenter().rootVC())
        self.window?.rootViewController = launchVC
        self.window?.makeKeyAndVisible()
        
        //Initialize Environment and Firebase based on Target Type (DEV/BETA)
        initializeEnv()
        
        Messaging.messaging().delegate = self
        
        //Setup firebase Crashlytics here
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        
        /*Calling UNService Notification Class for Push Notifications */
        UNService.shared.authorize()
        
        return true
    }
    
    ///Initializes current Environment based on target type
    func initializeEnv() {
        //Check which Database instance should be used
        let preference = UserDefaults.standard
        
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            let value = dict["PROJECT_ID"] as! String
            if value == Constants.PROJECT_ID {
                APP_ENV = Constants.MASTER_DEV_ENV
            } else {
                APP_ENV = Constants.MASTER_BETA_ENV
            }
            preference.set(APP_ENV, forKey: Constants.FIREBASE_ENVIRONMENT)
        }
        
        FIREBASE_ENV = preference.string(forKey: Constants.FIREBASE_ENVIRONMENT)!
        
        if (preference.string(forKey: Constants.FIREBASE_DATABASE_URL) != nil) {
            DATABASE_URL = preference.string(forKey: Constants.FIREBASE_DATABASE_URL)!
        } else {
            getDatabaseURL(environment: FIREBASE_ENV)
        }
        
        FirebaseApp.configure()
        initializeFirebaseApp(FIREBASE_ENV: FIREBASE_ENV, databaseURL: DATABASE_URL)
    }
    
    /// Gets the database URL of the current environment
    ///
    /// - parameter environment: Current Environment of the Application
    func getDatabaseURL(environment : String) {
        if environment == Constants.MASTER_DEV_ENV {
            DATABASE_URL = MASTER_DEV_DATABASE_URL
        } else {
            DATABASE_URL = MASTER_BETA_DATABASE_URL
        }
    }
    
    /// Gets the Current Environment and its Database URL
    ///
    /// - parameter environment: Current Environment of the Application
    /// - parameter databaseURL: Current Environment Database URL
    func initializeFirebaseApp(FIREBASE_ENV: String, databaseURL : String) {
        switch FIREBASE_ENV {
        case Constants.MASTER_DEV_ENV, Constants.SOCIETY_DEV_ENV :
            let DEV_OPTIONS = FirebaseOptions(googleAppID: "1:703896080530:ios:61a460236dc64533", gcmSenderID: "703896080530")
            DEV_OPTIONS.apiKey = "AIzaSyAEM6CUqV8swQnTOAqLGMpKZ4ENzqLJF1Q"
            DEV_OPTIONS.clientID = "703896080530-d8lmkpdohf5e1ogutir7iu1gabi5trtn.apps.googleusercontent.com"
            DEV_OPTIONS.bundleID = "com.kirtanlab.nammaapartments"
            DEV_OPTIONS.databaseURL = databaseURL
            DEV_OPTIONS.storageBucket = "nammaapartments-development.appspot.com"
            DEV_OPTIONS.projectID = "nammaapartments-development"

            if (FirebaseApp.app(name: FIREBASE_ENV)?.options == nil) {
                FirebaseApp.configure(name: FIREBASE_ENV, options : DEV_OPTIONS)
            }
            break
            
        case Constants.MASTER_BETA_ENV, Constants.SOCIETY_BETA_ENV :
            let BETA_OPTIONS = FirebaseOptions(googleAppID: "1:896005326129:ios:61a460236dc64533", gcmSenderID: "896005326129")
            BETA_OPTIONS.apiKey = "AIzaSyD9IHUOpY4ItiSI0Ly2seAaeFFDqFZJY9I"
            BETA_OPTIONS.clientID = "896005326129-ivn188nh5aosljk6tchkpdc6rlmtj4pu.apps.googleusercontent.com"
            BETA_OPTIONS.bundleID = "com.kirtanlab.nammaapartments"
            BETA_OPTIONS.databaseURL = databaseURL
            BETA_OPTIONS.storageBucket = "nammaapartments-beta.appspot.com"
            BETA_OPTIONS.projectID = "nammaapartments-beta"
            
            if (FirebaseApp.app(name: FIREBASE_ENV)?.options == nil) {
                 FirebaseApp.configure(name: FIREBASE_ENV, options : BETA_OPTIONS)
            }
            break
        default:
            break
        }
        Constants().configureFB(environment: FIREBASE_ENV)
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
