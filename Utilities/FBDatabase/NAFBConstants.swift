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
    static let FIREBASE_CHILD_GUARD = "guard"
    static let FIREBASE_CHILD_RATING = "rating"
    static let FIREBASE_CHILD_NOTICEBOARD = "noticeBoard"
    static let FIREBASE_DATABASE_REFERENCE = Database.database().reference()
    static let FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(Constants.FIREBASE_USER_CHILD_ALL)
    static let FIREBASE_USERDATA_SOCIETY_SERVICES_NOTIFICATION = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
    static let FIREBASE_SOCIETY_SERVICES = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_SOCIETYSERVICE)
    static let FIREBASE_USERS_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_USER).child(Constants.FIREBASE_CHILD_PRIVATE)
    static let FIREBASE_CABS_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_CABS).child(Constants.FIREBASE_CHILD_PRIVATE)
    static let FIREBASE_CABS_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_CABS).child(Constants.FIREBASE_USER_CHILD_ALL)
    static let FIREBASE_USERDATA_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_CHILD_PRIVATE)
    static let FIREBASE_DELIVERIES_PRIVATE = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DELIVERIES).child(Constants.FIREBASE_CHILD_PRIVATE)
    static let FIREBASE_DELIVERIES_ALL = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DELIVERIES).child(Constants.FIREBASE_USER_CHILD_ALL)
    static let FIREBASE_VISITORS_PRIVATE =
        Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_VISITORS)
            .child(Constants.FIREBASE_CHILD_PRIVATE)
    static let FIREBASE_DAILY_SERVICES_ALL_PUBLIC = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC)
    
    static let FIREBASE_USER_PRIVATE = FIREBASE_DATABASE_REFERENCE.child(FIREBASE_USER)
    .child(FIREBASE_CHILD_PRIVATE)
}
