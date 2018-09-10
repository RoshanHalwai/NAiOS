//
//  NAUserProblems.swift
//  nammaApartment
//
//  Created by Sundir Talari on 09/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation

enum SupportDetailsFBKeys: String {
    case problemDescription
    case serviceCategory
    case serviceType
    case status
    case timestamp
    case uid
    case userUID
    
    var key : String {
        switch self {
        case .problemDescription : return Constants.FIREBASE_PROBLEM_DESCRIPTION
        case .serviceCategory : return Constants.FIREBASE_SERVICE_CATEGORY
        case .serviceType : return Constants.FIREBASE_SERVICE_TYPE
        case .status : return Constants.FIREBASE_STATUS
        case .timestamp : return Constants.FIREBASE_CHILD_TIMESTAMP
        case .uid : return Constants.FIREBASE_CHILD_UID
        case .userUID : return Constants.FIREBASE_USERUID
        }
    }
}

class NAUserProblems {
    private var problemDescription: String
    private var serviceCategory: String
    private var serviceType: String
    private var status: String
    private var timestamp: Int
    
    init(problemDescription: String, serviceCategory: String, serviceType: String, status: String, timestamp: Int) {
        self.problemDescription = problemDescription
        self.serviceCategory = serviceCategory
        self.serviceType = serviceType
        self.status = status
        self.timestamp = timestamp
    }
    
    func getCategory() -> String {
        return serviceCategory
    }
    
    func getType() -> String {
        return serviceType
    }
    
    func getProblem() -> String {
        return problemDescription
    }
    
    func getTimeStamp() -> Int {
        return timestamp
    }
    
    func getStatus() -> String {
        return status
    }
}
