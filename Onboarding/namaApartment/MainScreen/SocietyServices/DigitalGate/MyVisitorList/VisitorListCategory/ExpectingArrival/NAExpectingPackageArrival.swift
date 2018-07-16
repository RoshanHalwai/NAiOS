//
//  File.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 16/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
//Created enum instead of struct for App optimization and for getting values.
enum ExpectingPackageArrivalListFBKeys : String {
    case dateAndTimeOfArrival
    case reference
    case status
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .dateAndTimeOfArrival: return "dateAndTimeOfArrival"
        case .reference: return "reference"
        case .status: return "status"
        }
    }
}

class NAExpectingPackageArrival {
    
    var dateAndTimeOfArrival : String?
    var reference : String?
    var status : String?
    
    init(dateAndTimeOfArrival : String?, reference: String?, status: String?) {
        self.dateAndTimeOfArrival = dateAndTimeOfArrival
        self.reference = reference
        self.status = status
    }
    
    
    func getdateAndTimeOfArrival() -> String {
        return dateAndTimeOfArrival!
    }
    func getreference() -> String {
        return reference!
    }
    func getstatus() -> String {
        return status!
    }
}


