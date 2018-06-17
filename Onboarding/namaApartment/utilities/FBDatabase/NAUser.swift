//
//  NAUser.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 16/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class NAUser {
    
    //defining strings according to firebase User Details which is inside the User Node.
    var admin: String?
    var apartmentName: String?
    var emailId: String?
    var flatNumber: String?
    var fullName: String?
    var grantedAccess: String?
    var phoneNumber: String?
    var profilePhoto: String?
    var societyName: String?
    var tenantType: String?
    var uid: String?
    var verified: String?
}

