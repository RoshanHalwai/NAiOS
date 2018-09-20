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
    case fullName
    case mobileNumber
    case scrapType
    case quantity
    case uid
    
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
        case .fullName: return "fullName"
        case .mobileNumber: return "mobileNumber"
        case .scrapType: return "scrapType"
        case .quantity: return "quantity"
        case .uid: return "uid"
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
    var fullName : String
    var mobileNumber : String
    var timeStamp : Int
    
    init(problem: String, timeSlot : String, userUID: String, societyServiceType: String, notificationUID: String, status: String, takenBy: String, endOTP: String, fullName : String, mobileNumber : String, timeStamp: Int) {
        self.problem = problem
        self.timeSlot = timeSlot
        self.userUID = userUID
        self.societyServiceType = societyServiceType
        self.notificationUID = notificationUID
        self.status = status
        self.takenBy = takenBy
        self.endOTP = endOTP
        self.fullName = fullName
        self.mobileNumber = mobileNumber
        self.timeStamp = timeStamp
        
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
    func getFullName() -> String {
        return fullName
    }
    func getMobileNumber() -> String {
        return mobileNumber
    }
    
    func getTimeStamp() -> Int {
        return timeStamp
    }
}
