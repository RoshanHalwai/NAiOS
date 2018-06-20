//
//  UserPrivileges.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class UserPrivileges {
    
    //creatig string variables to get data from Firebase.
    var apartmentName: String?
    var admin: String?
    var grantAccess: String?
    var verified: String?
    
     //initiliazing variables
    init(admin: String?,grantAccess: String?,verified: String?) {
        
        self.admin = admin
        self.grantAccess = grantAccess
        self.verified = verified
    }
    
   //creating structure for firebase to get data on it.
    struct UserPrivileges {
        
        static let admin = "admin"
        static let grantAccess = "grantAccess"
        static let verified = "verified"
    }
    
}
