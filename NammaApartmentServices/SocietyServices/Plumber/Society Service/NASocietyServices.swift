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
    var societyServiceType : String
    var notificationUID : String
    var status : String
    var takenBy : String
    var endOTP : String
    
    init(problem: String, timeSlot : String, userUID: String, societyServiceType: String, notificationUID: String, status: String, takenBy: String, endOTP: String) {
        self.problem = problem
        self.timeSlot = timeSlot
        self.userUID = userUID
        self.societyServiceType = societyServiceType
        self.notificationUID = notificationUID
        self.status = status
        self.takenBy = takenBy
        self.endOTP = endOTP
    }
    
    func getProblem() -> String {
        return problem
    }
    func getTimeSlot() -> String {
        return timeSlot
    }
    func getUserUID() -> String {
        return userUID
    }
    func getSocietyServiceType() -> String {
        return societyServiceType
    }
    func getNotificationUID() -> String {
        return notificationUID
    }
    func getStatus() -> String {
        return status
    }
    func getTakenBy() -> String {
        return takenBy
    }
    func getEndOTP() -> String {
        return endOTP
    }
}
