//
//  NammaApartmentVehicle.swift
//  nammaApartment
//
//  Created by kalpana on 8/14/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum VehicleListFBKeys: String {
    case addedDate
    case ownerName
    case vehicleNumber
    case vehicleType
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .addedDate: return "addedDate"
        case .ownerName: return "ownerName"
        case .vehicleNumber: return "vehicleNumber"
        case .vehicleType:return "vehicleType"
        }
    }
}
