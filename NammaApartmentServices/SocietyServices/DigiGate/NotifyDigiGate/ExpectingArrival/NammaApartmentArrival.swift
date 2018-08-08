//
//  NammaApartmentArrival.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 15/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum ArrivalListFBKeys: String {
    case dateAndTimeOfArrival
    case inviterUID
    case reference
    case status
    case validFor
    case approvalType
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .dateAndTimeOfArrival: return "dateAndTimeOfArrival"
        case .inviterUID: return "inviterUID"
        case .reference: return "reference"
        case .status: return "status"
        case .validFor:return "validFor"
        case .approvalType: return "approvalType"
        }
    }
}
