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
    case vehicleUID
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .addedDate: return "addedDate"
        case .ownerName: return "ownerName"
        case .vehicleNumber: return "vehicleNumber"
        case .vehicleType:return "vehicleType"
        case .vehicleUID: return "uid"
        }
    }
}

class NAExpectingVehicle {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    
    var addedDate : String?
    var ownerName : String?
    var vehicleNumber : String?
    var vehicleType : String?
    var vehicleUID : String?
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init(addedDate : String?,ownerName : String?, vehicleNumber: String?,vehicleType: String?, vehicleUID : String?) {
        self.addedDate = addedDate
        self.ownerName = ownerName
        self.vehicleNumber = vehicleNumber
        self.vehicleType = vehicleType
        self.vehicleUID = vehicleUID
    }
    
    func getaddedDate() -> String {
        return addedDate!
    }
    
    func getownerName() -> String {
        return ownerName!
    }
    
    func getvehicleNumber() -> String {
        return vehicleNumber!
    }
    
    func getvehicleType() -> String {
        return vehicleType!
    }
    
    func getVehicleUID() -> String {
        return vehicleUID!
    }
}
