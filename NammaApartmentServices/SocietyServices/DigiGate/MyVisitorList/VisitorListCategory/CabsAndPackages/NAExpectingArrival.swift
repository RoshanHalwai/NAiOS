//
//  ExpectingArrivalRetrieval.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 16/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
/* Created enum instead of struct for App optimization and for getting values.
 Use Internationalization, as appropriate. */
enum ExpectingArrivalListFBKeys : String {
    case approvalType
    case dateAndTimeOfArrival
    case reference
    case status
    
    var key : String {
        switch self {
        case .dateAndTimeOfArrival: return "dateAndTimeOfArrival"
        case .reference: return "reference"
        case .status: return "status"
        case .approvalType: return "approvalType"
        }
    }
}

class NAExpectingArrival {
    
    var approvalType : String?
    var dateAndTimeOfArrival : String?
    var reference : String?
    var status : String?
    
    init(approvalType : String?,dateAndTimeOfArrival : String?, reference: String?, status: String?) {
        self.approvalType = approvalType
        self.dateAndTimeOfArrival = dateAndTimeOfArrival
        self.reference = reference
        self.status = status
    }
    
    func getapprovalType() -> String {
        return approvalType!
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
