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
    var admin: String?
    var grantAccess: String?
    var verified: String?
    
     //initiliazing variables
    init(admin: String?,grantAccess: String?,verified: String?) {
        
        self.admin = admin
        self.grantAccess = grantAccess
        self.verified = verified
    }
    
    func getAdmin() -> String {
        return admin!
    }
    func getGrantAccess() -> String {
        return grantAccess!
    }
    func getVerified() -> String {
        return verified!
    }
}
