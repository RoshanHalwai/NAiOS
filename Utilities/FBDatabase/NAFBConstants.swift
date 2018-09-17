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

struct Constants {
    static let FIREBASE_CHILD_CLIENTS = "clients"
    static let FIREBASE_CHILD_VISITORS = "visitors"
    static let FIREBASE_CHILD_PRE_APPROVED = "preApproved"
    static let FIREBASE_CHILD_POST_APPROVED = "postApproved"
    static let FIREBASE_CHILD_PRE_APPROVED_VISITORS_MOBILENUMBER = "preApprovedVisitorsMobileNumber"
    static let FIREBASE_USER = "users"
    static let FIREBASE_CHILD_PRIVATE = "private"
    static let FIREBASE_USER_CHILD_ALL = "all"
    static let FIREBASE_CHILD_DAILY_SERVICES = "dailyServices"
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
    static let FIREBASE_CHILD_DONATEFOOD = "donateFood"
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
    
    static let FIREBASE_DATABASE_REFERENCE = Database.database().reference()
    
    static let FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(FIREBASE_USER_CHILD_ALL)
    
    static let FIREBASE_SOCIETY_SERVICES = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_SOCIETYSERVICE)
    
    static let FIREBASE_CABS_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_CABS).child(FIREBASE_CHILD_PRIVATE)
    
    static let FIREBASE_CABS_ALL = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_CABS).child(FIREBASE_USER_CHILD_ALL)
    
    static let FIREBASE_USERDATA_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_USERDATA).child(FIREBASE_CHILD_PRIVATE)
    
    static let FIREBASE_DELIVERIES_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_DELIVERIES).child(FIREBASE_CHILD_PRIVATE)
    
    static let FIREBASE_DELIVERIES_ALL = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_DELIVERIES).child(FIREBASE_USER_CHILD_ALL)
    
    static let FIREBASE_VISITORS_PRIVATE =
        FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_VISITORS)
            .child(FIREBASE_CHILD_PRIVATE)
    
     static let FIREBASE_VISITORS_ALL = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_VISITORS).child(FIREBASE_USER_CHILD_ALL)

    static let FIREBASE_DAILY_SERVICES_ALL_PUBLIC = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_DAILY_SERVICES).child(FIREBASE_USER_CHILD_ALL).child(FIREBASE_USER_PUBLIC)
    
    static let FIREBASE_DAILY_SERVICES_ALL_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_DAILY_SERVICES).child(FIREBASE_USER_CHILD_ALL).child(FIREBASE_CHILD_PRIVATE)
    
    static let FIREBASE_USERS_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_USER)
        .child(FIREBASE_CHILD_PRIVATE)
    
    static let FIREBASE_USERS_ALL = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_USER).child(FIREBASE_USER_CHILD_ALL)
    
    static let FIREBASE_EMERGENCY_PRIVATE_ALL = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_EMERGENCY).child(FIREBASE_CHILD_PRIVATE).child(FIREBASE_USER_CHILD_ALL)
    
    static let FIREBASE_EMERGENCY_PUBLIC = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_EMERGENCY).child(FIREBASE_USER_PUBLIC)
    
    static let FIREBASE_EVENT_MANAGEMENT = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_EVENT_MANAGEMENT)
    
    static let FIREBASE_VEHICLES_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_VEHICLES).child(FIREBASE_CHILD_PRIVATE)
    
    static let FIREBASE_VEHICLES_ALL = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_VEHICLES).child(FIREBASE_USER_CHILD_ALL)
    
    static let FIREBASE_GUARD_PRIVATE_DATA = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_GUARD).child(FIREBASE_CHILD_PRIVATE).child(FIREBASE_CHILD_DATA)
    
    static let FIREBASE_DONATEFOOD_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_DONATEFOOD).child(FIREBASE_CHILD_PRIVATE)
    
    static let FIREBASE_DONATEFOOD = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_CHILD_DONATEFOOD)
}
