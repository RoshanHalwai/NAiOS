//
//  NAEventManagement.swift
//  nammaApartment
//
//  Created by kalpana on 8/17/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

enum NAEventManagementFBKeys : String {
    case eventTitle
    case category
    case userUID
    case societyServiceType
    case notificationUID
    case status
    case timeSlot
    case eventDate
    
    var key : String {
        switch self {
            
        case .eventTitle: return "eventTitle"
        case .category: return "category"
        case .userUID: return "userUID"
        case .societyServiceType: return "societyServiceType"
        case .notificationUID: return "notificationUID"
        case .status: return "status"
        case .timeSlot: return "timeSlot"
        case .eventDate: return "eventDate"
        }
    }
}
