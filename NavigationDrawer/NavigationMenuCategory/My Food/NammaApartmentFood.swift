//
//  NammaApartmentFood.swift
//  nammaApartment
//
//  Created by kalpana on 9/17/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum DonateFoodListFBKeys: String {
    case foodQuantity
    case foodType
    case status
    case timeStamp
    case uid
    case userUID
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .foodQuantity: return "foodQuantity"
        case .foodType: return "foodType"
        case .status: return "status"
        case .timeStamp:return "timeStamp"
        case .uid: return "uid"
        case .userUID:return "userUID"
        }
    }
}

