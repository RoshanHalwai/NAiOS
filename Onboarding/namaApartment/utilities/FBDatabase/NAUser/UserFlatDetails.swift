//
//  UserFlatDetails.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class UserFlatDetails {
    
    //creatig string variables to get data from Firebase.
     var apartmentName: String?
     var city: String?
     var flatNumber: String?
     var societyName: String?
     var tenantType: String?
    
     //initiliazing variables
    init(apartmentName: String?,city: String?,flatNumber: String?,societyName: String?,tenantType: String?) {
        
        self.apartmentName = apartmentName
        self.city = city
        self.flatNumber = flatNumber
        self.societyName = societyName
        self.tenantType = tenantType
    }
    
     //creating structure for firebase to get data on it.
    struct UserFlatDetails {
    
        static let apartmentName = "apartmentName"
        static let city = "city"
        static let flatNumber = "flatNumber"
        static let societyName = "societyName"
        static let tenantType = "tenantType"
    }
}

