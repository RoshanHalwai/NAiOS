//
//  Constants.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 16/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

let MASTER_DEV_DATABASE_URL = "https://nammaapartments-development.firebaseio.com/"
let MASTER_BETA_DATABASE_URL = "https://nammaapartments-beta.firebaseio.com/"

struct Constants {
    static let PROJECT_ID = "nammaapartments-development"
    static let FIREBASE_CHILD_CLIENTS = "clients"
    static let FIREBASE_CHILD_VISITORS = "visitors"
    static let FIREBASE_CHILD_PRE_APPROVED = "preApproved"
    static let FIREBASE_CHILD_POST_APPROVED = "postApproved"
    static let FIREBASE_CHILD_GUARD_APPROVED = "guardApproved"
    static let FIREBASE_CHILD_PRE_APPROVED_VISITORS_MOBILENUMBER = "preApprovedVisitorsMobileNumber"
    static let FIREBASE_USER = "users"
    static let FIREBASE_CHILD_PRIVATE = "private"
    static let FIREBASE_USER_CHILD_ALL = "all"
    static var FIREBASE_CHILD_DAILY_SERVICES = "dailyServices"
    static let FIREBASE_USER_PUBLIC = "public"
    static let FIREBASE_CHILD_DAILY_SERVICES_TYPE = "dailyServiceType"
    static let FIREBASE_DSTYPE_LAUNDRIES = "laundries"
    static let FIREBASE_DSTYPE_MAIDS = "maids"
    static let FIREBASE_DSTYPE_COOKS = "cooks"
    static let FIREBASE_DSTYPE_DRIVERS = "drivers"
    static let FIREBASE_DSTYPE_MILKMEN = "milkmen"
    static let FIREBASE_DSTYPE_CARBIKE_CLEANER = "carBikeCleaners"
    static let FIREBASE_DSTYPE_CHILDDAY_CARE = "childDayCares"
    static let FIREBASE_DSTYPE_DAILY_NEWSPAPER = "dailyNewspapers"
    static let FIREBASE_USERDATA = "userData"
    static let FIREBASE_CHILD_BANGALORE = "Bengaluru"
    static let FIREBASE_CHILD_SALARPURIA_CAMBRIDGE = "Salarpuria Cambridge"
    static let FIREBASE_CHILD_BRIGADE_GATEWAY = "Brigade Gateway"
    static let FIREBASE_CHILD_BLOCKONE = "Block-1"
    static let FIREBASE_CHILD_ASTER = "Aster"
    static let FIREBASE_HANDEDTHINGS = "handedThings"
    static let FIREBASE_CHILD_FLATNO = "A-1001"
    static let FIREBASE_CHILD_FLATDETAILS = "flatDetails"
    static let FIREBASE_CHILD_PERSONALDETAILS = "personalDetails"
    static let FIREBASE_CHILD_PRIVILEGES = "privileges"
    static let FIREBASE_CHILD_ADMIN = "admin"
    static let FIREBASE_CHILD_FLATMEMBERS = "flatMembers"
    static let FIREBASE_CHILD_APARTMENT_NAME = "apartmentName"
    static let FIREBASE_CHILD_CITY = "city"
    static let FIREBASE_CHILD_FLATNUMBER = "flatNumber"
    static let FIREBASE_CHILD_SOCIETY_NAME = "societyName"
    static let FIREBASE_CHILD_TENANT_TYPE = "tenantType"
    static let FIREBASE_CHILD_EMAIL = "email"
    static let FIREBASE_CHILD_FULLNAME = "fullName"
    static let FIREBASE_CHILD_PHONENUMBER = "phoneNumber"
    static let FIREBASE_CHILD_GRANTACCESS = "grantedAccess"
    static let FIREBASE_CHILD_VERIFIED = "verified"
    static let FIREBASE_AREA = "Chennai"
    static let FIREBASE_COL = "Air Force Colony"
    static let FIREBASE_BLOCK = "D-Block"
    static let FIREBASE_FLAT = "D-101"
    static let FIREBASE_CHILD_CABS = "cabs"
    static let FIREBASE_CHILD_VEHICLES = "vehicles"
    static let FIREBASE_CHILD_DONATEFOOD = "foodDonations"
    static let FIREBASE_CHILD_DELIVERIES = "deliveries"
    static let FIREBASE_CHILD_CITIES = "cities"
    static let FIREBASE_CHILD_SOCIETIES = "societies"
    static let FIREBASE_CHILD_APARTMENTS = "apartments"
    static let FIREBASE_CHILD_FLATS = "flats"
    static let FIREBASE_CHILD_FAMILY_MEMBERS = "familyMembers"
    static let FIREBASE_CHILD_FRIENDS = "friends"
    static let FIREBASE_CHILD_EMERGENCY = "emergencies"
    static let FIREBASE_CHILD_UID = "uid"
    static let FIREBASE_CHILD_OWNERSUID = "ownersUID"
    static let FIREBASE_CHILD_PERSONALDETAILS_PROFILEIMAGE = "profilePhoto"
    static let FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION = "societyServiceNotifications"
    static let FIREBASE_CHILD_TIMESTAMP = "timestamp"
    static let FIREBASE_CHILD_TAKENBY = "takenBy"
    static let FIREBASE_CHILD_SOCIETYSERVICE = "societyServices"
    static let FIREBASE_CHILD_DATA = "data"
    static let FIREBASE_CHILD_GATE_NOTIFICATION = "gateNotifications"
    static let FIREBASE_CHILD_GUESTS = "guests"
    static let FIREBASE_CHILD_NOTIFICATION_UID = "notification_uid"
    static let FIREBASE_CHILD_VISITOR_TYPE = "visitor_type"
    static let FIREBASE_CHILD_EVENT_MANAGEMENT = "eventManagement"
    static let FIREBASE_CHILD_IN_PROGRESS = "in progress"
    static let FIREBASE_CHILD_GUARD = "guards"
    static let FIREBASE_CHILD_RATING = "rating"
    static let FIREBASE_CHILD_NOTICEBOARD = "noticeBoard"
    static let FIREBASE_CHILD_SLOT1 = "Slot 1"
    static let FIREBASE_CHILD_SLOT2 = "Slot 2"
    static let FIREBASE_CHILD_SLOT3 = "Slot 3"
    static let FIREBASE_CHILD_SLOT4 = "Slot 4"
    static let FIREBASE_CHILD_LONGITUDE = "longitude"
    static let FIREBASE_CHILD_LATITUDE = "latitude"
    static let FIREBASE_CHILD_OTHER_DETAILS = "otherDetails"
    static let FIREBASE_CHILD_DEVICE_VERSION = "deviceVersion"
    static let FIREBASE_CHILD_DEVICE_TYPE = "deviceType"
    static let FIREBASE_CHILD_VERIFIED_PENDING = 0
    static let FIREBASE_CHILD_VERIFIED_APPROVED = 1
    static let FIREBASE_CHILD_PENDINGDUES = "pendingDues"
    static let FIREBASE_CHILD_NOTIFICATION_SOUND = "notificationSound"
    static let FIREBASE_CHILD_EINTERCOM_SOUND = "eIntercom"
    static let FIREBASE_CHILD_GUEST_SOUND = "guest"
    static let FIREBASE_CHILD_DAILYSERVICE_SOUND = "dailyService"
    static let FIREBASE_CHILD_CAB_SOUND = "cab"
    static let FIREBASE_CHILD_PACKAGE_SOUND = "package"
    static let FIREBASE_NOTIFICATION_TYPE_NOTICE_BOARD = "Notice_Board_Notification"
    static let FIREBASE_NOTIFICATION_TYPE = "type"
    static let FIREBASE_CHILD_SUPPORT = "support"
    static let FIREBASE_PROBLEM_DESCRIPTION = "problemDescription"
    static let FIREBASE_SERVICE_CATEGORY = "serviceCategory"
    static let FIREBASE_SERVICE_TYPE = "serviceType"
    static let FIREBASE_STATUS = "status"
    static let FIREBASE_USERUID = "userUID"
    static let FIREBASE_NOTIFICATIONS = "notifications"
    static let FIREBASE_HISTORY = "history"
    static let FIREBASE_CHILD_MAINTENANCE_COST = "maintenanceCost"
    static let FIREBASE_AMOUNT = "amount"
    static let FIREBASE_PAYMENT_ID = "paymentId"
    static let FIREBASE_RESULT = "result"
    static let FIREBASE_TRANSACTIONS = "transactions"
    static let FIREBASE_CHILD_SERVING = "serving"
    static let FIREBASE_CHILD_FUTURE = "future"
    static let FIREBASE_CHILD_SCRAP_COLLECTION = "scrapCollection"
    static let FIREBASE_CHILD_BOOKING_AMOUNT = "bookingAmount"
    static let FIREBASE_CHILD_CONVENIENCE = "convenienceCharges"
    static let FIREBASE_CHILD_CHATS = "chats"
    static let FIREBASE_CHILD_PERIOD = "period"
    static let FIREBASE_CHILD_CONTACTUS = "contactUs"
    static let FIREBASE_CHILD_NUMBER = "number"
    static let FIREBASE_DATABASE_URL = "firebaseDatabaseURL"
    static let FIREBASE_ENVIRONMENT = "firebaseEnvironment"
    static let MASTER_BETA_ENV = "master_beta_env"
    static let MASTER_DEV_ENV = "master_dev_env"
    static let SOCIETY_DEV_ENV = "society_dev_env"
    static let SOCIETY_BETA_ENV = "society_beta_env"
    static let FIREBASE_CHILD_VERSION_NAME = "versionName"
    
    static let DEFAULT_ALL_USERS_REFERENCE = Database.database().reference()
        .child(Constants.FIREBASE_USER)
        .child(Constants.FIREBASE_USER_CHILD_ALL)
    static let DEFAULT_VERSION_NAME_REFERENCE = Database.database().reference()
        .child(Constants.FIREBASE_CHILD_VERSION_NAME)
    static let DEFAULT_CONVENIENCE_CHARGES_REFERENCE = Database.database().reference()
        .child(Constants.FIREBASE_TRANSACTIONS)
        .child(Constants.FIREBASE_CHILD_CONVENIENCE)
    static let DEFAULT_CONTACT_US_REFERENCE = Database.database().reference().child(Constants.FIREBASE_CHILD_CONTACTUS)
    
    static var FIREBASE_DATABASE_REFERENCE : DatabaseReference!
    static var FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL : DatabaseReference!
    static var FIREBASE_SOCIETY_SERVICES : DatabaseReference!
    static var FIREBASE_CABS_PRIVATE : DatabaseReference!
    static var FIREBASE_CABS_ALL : DatabaseReference!
    static var FIREBASE_USERDATA_PRIVATE : DatabaseReference!
    static var FIREBASE_DELIVERIES_PRIVATE : DatabaseReference!
    static var FIREBASE_DELIVERIES_ALL : DatabaseReference!
    static var FIREBASE_VISITORS_PRIVATE : DatabaseReference!
    static var FIREBASE_VISITORS_ALL : DatabaseReference!
    static var FIREBASE_DAILY_SERVICES_ALL_PUBLIC : DatabaseReference!
    static var FIREBASE_DAILY_SERVICES_ALL_PRIVATE : DatabaseReference!
    static var FIREBASE_USERS_PRIVATE : DatabaseReference!
    static var FIREBASE_USERS_ALL : DatabaseReference!
    static var FIREBASE_EMERGENCY_PRIVATE_ALL : DatabaseReference!
    static var FIREBASE_EMERGENCY_PUBLIC : DatabaseReference!
    static var FIREBASE_EVENT_MANAGEMENT : DatabaseReference!
    static var FIREBASE_BOOKING_SLOT : DatabaseReference!
    static var FIREBASE_VEHICLES_PRIVATE : DatabaseReference!
    static var FIREBASE_VEHICLES_ALL : DatabaseReference!
    static var FIREBASE_GUARD_PRIVATE_DATA : DatabaseReference!
    static var FIREBASE_CONVENIENCE_CHARGES : DatabaseReference!
    
    func configureFB(environment : String) {
        
        let FIREBASE_APP = FirebaseApp.app(name: environment)
        Constants.FIREBASE_DATABASE_REFERENCE = Database.database(app: FIREBASE_APP!).reference()
        
        Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        Constants.FIREBASE_SOCIETY_SERVICES = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_SOCIETYSERVICE)
        
        Constants.FIREBASE_CABS_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_CABS).child(Constants.FIREBASE_CHILD_PRIVATE)
        
        Constants.FIREBASE_CABS_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_CABS).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        Constants.FIREBASE_USERDATA_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_CHILD_PRIVATE)
        
        Constants.FIREBASE_DELIVERIES_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DELIVERIES).child(Constants.FIREBASE_CHILD_PRIVATE)
        
        Constants.FIREBASE_DELIVERIES_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DELIVERIES).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        Constants.FIREBASE_VISITORS_PRIVATE =
            Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_VISITORS)
                .child(Constants.FIREBASE_CHILD_PRIVATE)
        
        Constants.FIREBASE_VISITORS_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_VISITORS).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC)
        
        Constants.FIREBASE_DAILY_SERVICES_ALL_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_CHILD_PRIVATE)
        
        Constants.FIREBASE_USERS_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_USER)
            .child(Constants.FIREBASE_CHILD_PRIVATE)
        
        Constants.FIREBASE_USERS_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        Constants.FIREBASE_EMERGENCY_PRIVATE_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_EMERGENCY).child(Constants.FIREBASE_CHILD_PRIVATE).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        Constants.FIREBASE_EMERGENCY_PUBLIC = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_EMERGENCY).child(Constants.FIREBASE_USER_PUBLIC)
        
        Constants.FIREBASE_EVENT_MANAGEMENT = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_EVENT_MANAGEMENT)
        
        Constants.FIREBASE_BOOKING_SLOT = Constants.FIREBASE_EVENT_MANAGEMENT.child(Constants.FIREBASE_CHILD_BOOKING_AMOUNT)
        
        Constants.FIREBASE_VEHICLES_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_VEHICLES).child(Constants.FIREBASE_CHILD_PRIVATE)
        
        Constants.FIREBASE_VEHICLES_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_VEHICLES).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        Constants.FIREBASE_GUARD_PRIVATE_DATA = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_GUARD).child(Constants.FIREBASE_CHILD_PRIVATE).child(Constants.FIREBASE_CHILD_DATA)
        
        Constants.FIREBASE_CONVENIENCE_CHARGES = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_TRANSACTIONS).child(Constants.FIREBASE_CHILD_CONVENIENCE)
        
    }
}
