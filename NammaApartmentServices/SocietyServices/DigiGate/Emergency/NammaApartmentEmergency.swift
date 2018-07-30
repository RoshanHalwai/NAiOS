//
//  NammaApartmentEmergency.swift
//  nammaApartment
//
//  Created by Sundir Talari on 29/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation

enum EmergencyFBKeys : String {
    case apartmentName
    case emergencyType
    case flatNumber
    case fullName
    case phoneNumber
    
    var key : String {
        switch self {
            
        case .apartmentName:
            return "apartmentName"
        case .emergencyType:
            return "emergencyType"
        case .flatNumber:
            return "flatNumber"
        case .fullName:
            return "fullName"
        case .phoneNumber:
            return "phoneNumber"
        }
    }
}

