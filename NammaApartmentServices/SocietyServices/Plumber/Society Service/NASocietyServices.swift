//
//  NASocietyServices.swift
//  nammaApartment
//
//  Created by Sundir Talari on 10/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

enum NASocietyServicesFBKeys : String {
    case problem
    case timeSlot
    case userUID
    case societyServiceType
    case notificationUID
    case status
    case takenBy
    case endOTP
    
    var key : String {
        switch self {
            
        case .problem: return "problem"
        case .timeSlot: return "timeSlot"
        case .userUID: return "userUID"
        case .societyServiceType: return "societyServiceType"
        case .notificationUID: return "notificationUID"
        case .status: return "status"
        case .takenBy: return "takenBy"
        case .endOTP: return "endOTP"
        }
    }
}

class NASocietyServices {
    var problem : String
    var timeSlot : String
    var userUID : String
    var societyServicetype : String
    var notificationUID : String
    var status : String
    var
    
    
}
