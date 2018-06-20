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
    
     var apartmentName: String?
     var city: String?
     var flatNumber: String?
     var societyName: String?
     var tenantType: String?
    
    init(apartmentName: String?,city: String?,flatNumber: String?,societyName: String?,tenantType: String?) {
        
        self.apartmentName = apartmentName
        self.city = city
        self.flatNumber = flatNumber
        self.societyName = societyName
        self.tenantType = tenantType
    }
    
    //declaring & assigning variable
    struct UserFlatDetails {
    
        static let apartmentName = "apartmentName"
        static let city = "city"
        static let flatNumber = "flatNumber"
        static let societyName = "societyName"
        static let tenantType = "tenantType"
    }
}

