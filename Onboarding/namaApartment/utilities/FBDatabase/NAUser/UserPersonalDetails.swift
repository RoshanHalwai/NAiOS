//
//  UserPersonalDetails.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class UserPersonalDetails {
    
    //creatig string variables to get data from Firebase.
    var email: String?
    var fullName: String?
    var phoneNumber: String?
    var profilePhoto: String?
    
    //initiliazing variables
    init(email: String?,fullName: String?,phoneNumber: String?,profilePhoto: String?) {
        
        self.email = email
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.profilePhoto = profilePhoto
    }
    
    //creating structure for firebase to get data on it.
    struct UserPersonalDetails {
        
        static let email = "email"
        static let fullName = "fullName"
        static let phoneNumber = "phoneNumber"
        static let profilePhoto = "profilePhoto"
    }
}
