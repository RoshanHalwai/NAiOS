//
//  UserFlatDetails.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum UserFlatListFBKeys : String {
    case apartmentName
    case city
    case flatNumber
    case societyName
    case tenantType
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .apartmentName: return "apartmentName"
        case .city: return "city"
        case .flatNumber: return "flatNumber"
        case .societyName: return "societyName"
        case .tenantType: return "tenantType"
        }
    }
}

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
    
    func getapartmentName() -> String {
        return apartmentName!
    }
    func getcity() -> String {
        return city!
    }
    func getflatNumber() -> String {
        return flatNumber!
    }
    func getsocietyName() -> String {
        return societyName!
    }
    func gettenantType() -> String {
        return tenantType!
    }
}
