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
    case timeSlots
    case eventDate
    
    var key : String {
        switch self {
            
        case .eventTitle: return "eventTitle"
        case .category: return "category"
        case .userUID: return "userUID"
        case .societyServiceType: return "societyServiceType"
        case .notificationUID: return "notificationUID"
        case .status: return "status"
        case .timeSlots: return "timeSlots"
        case .eventDate: return "eventDate"
        }
    }
}

class NAEventManagement {
   
    var title: String?
    var date: String?
    var timeSlot = [String]()
    var status: String?
    var category: String?
    
    //initilaize the variables
    init(title: String?,date: String?,timeSlot: [String],status: String?, category: String?) {
        self.title = title
        self.date = date
        self.timeSlot = timeSlot
        self.status = status
        self.category = category
    }

    func getTitle() -> String {
        return title!
    }
    
    func getDate() -> String {
        return date!
    }
    
    func getTimeSlot() -> [String] {
        return timeSlot
    }
    
    func getStatus() -> String {
        return status!
    }
    
    func getCategory() -> String {
        return category!
    }
}
