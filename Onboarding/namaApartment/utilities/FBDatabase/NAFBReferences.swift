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
import FirebaseCore

struct Constants {
    static let FIREBASE_CHILD_CLIENTS = "clients"
    static let FIREBASE_CHILD_VISITORS = "visitors"
    static let FIREBASE_CHILD_PRE_APPROVED_VISITORS = "preApprovedVisitors"
    
    static let FIREBASE_USER = "users"
    static let FIREBASE_USER_CHILD_PRIVATE = "private"
    static let FIREBASE_USER_CHILD_ALL = "all"

    //MY VISITOR LIST
    static let VISITOR_dateAndTimeOfVisit = "dateAndTimeOfVisit"
    static let VISITOR_fullName = "fullName"
    static let VISITOR_inviterUID = "inviterUID"
    static let VISITOR_mobileNumber = "mobileNumber"
    static let VISITOR_profilePhoto = "profilePhoto"
    static let VISITOR_status = "status"
    static let VISITOR_uid = "uid"

}
