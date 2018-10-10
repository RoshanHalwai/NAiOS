//
//  UserPrivileges.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum UserPrivilegesListFBKeys : String {
    case admin
    case grantedAccess
    case verified

    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .admin: return "admin"
        case .grantedAccess: return "grantedAccess"
        case .verified: return "verified"
        }
    }
}

class UserPrivileges {
    
    //creatig string variables to get data from Firebase.
    var admin: Bool?
    var grantAccess: Bool?
    var verified: Int?
    
     //initiliazing variables
    init(admin: Bool?,grantAccess: Bool?,verified: Int?) {
        
        self.admin = admin
        self.grantAccess = grantAccess
        self.verified = verified
    }
    
    func getAdmin() -> Bool {
        return admin!
    }
    
    func setAdmin(admin: Bool) {
        self.admin = admin
    }
    
    func getGrantAccess() -> Bool {
        return grantAccess!
    }
    func getVerified() -> Int {
        return verified!
    }
}
