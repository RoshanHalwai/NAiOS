//
//  NAUserTransactions.swift
//  nammaApartment
//
//  Created by Sundir Talari on 09/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation


enum NAUserTransactionFBKeys: String {
    case amount
    case paymentId
    case result
    case serviceCategory
    case timestamp
    case uid
    case userUID
    case period
    
    var key : String {
        switch self {
        case .amount : return Constants.FIREBASE_AMOUNT
        case .paymentId : return Constants.FIREBASE_PAYMENT_ID
        case .result : return Constants.FIREBASE_RESULT
        case .serviceCategory : return Constants.FIREBASE_SERVICE_CATEGORY
        case .timestamp : return Constants.FIREBASE_CHILD_TIMESTAMP
        case .uid : return Constants.FIREBASE_CHILD_UID
        case .userUID : return Constants.FIREBASE_USERUID
        case .period : return Constants.FIREBASE_CHILD_PERIOD
        }
    }
}

class NAUserTransactions {
    //defining strings according to firebase names which is inside the visitor Node.
    private var amount: Int
    private var serviceCategory: String
    private var timestamp: Int
    private var result: String
    private var transactionId : String
    private var period : String
    
    //initilaize the variables
    init(amount: Int, serviceCategory: String, timestamp: Int, result: String, transactionId: String, period: String) {
        self.amount = amount
        self.serviceCategory = serviceCategory
        self.timestamp = timestamp
        self.result = result
        self.transactionId = transactionId
        self.period = period
    }
    
    func getAmount() -> Int {
        return amount
    }
    
    func getServiceCategory() -> String {
        return serviceCategory
    }
    
    func getTimeStamp() -> Int {
        return timestamp
    }
    
    func getResult() -> String {
        return result
    }
    
    func getTransactionID() -> String {
        return transactionId
    }
    
    func getPeriod() -> String {
        return period
    }
}
