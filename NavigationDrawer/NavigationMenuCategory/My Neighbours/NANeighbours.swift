//
//  NANeighbours.swift
//  nammaApartment
//
//  Created by Srilatha on 10/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum NANeighboursListKeys: String {
    case name
    case profilePhoto
    case apartment
    case flat
    case message
    case receiverUID
    case timeStamp
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .name: return "name"
        case .profilePhoto: return "profilePhoto"
        case .apartment: return "apartment"
        case .flat:return "flat"
        case .message: return "message"
        case .receiverUID: return "receiverUID"
        case .timeStamp: return "timeStamp"
        }
    }
}

class NAExpectingNeighbours {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    
    var name : String
    var profilePhoto : String
    var apartment : String
    var flat : String
    var uid : String
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init(name : String,profilePhoto : String, apartment: String, flat: String, uid: String) {
        self.name = name
        self.profilePhoto = profilePhoto
        self.apartment = apartment
        self.flat = flat
        self.uid = uid
    }
    
    func getname() -> String {
        return name
    }
    
    func getprofilePhoto() -> String? {
        return profilePhoto
    }
    
    func getapartment() -> String {
        return apartment
    }
    
    func getflat() -> String {
        return flat
    }
    
    func getneighbourUID() -> String {
        return uid
    }
}

class NANeighboursChat {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    
    var message : String
    var receiverUID : String
    var timeStamp : Int
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init(message: String, receiverUID: String, timeStamp: Int) {
        self.message = message
        self.receiverUID = receiverUID
        self.timeStamp = timeStamp
    }
    
    func getMessage() -> String {
        return message
    }
    
    func getReceiverUID() -> String {
        return receiverUID
    }
    
    func getTimeStamp() -> Int {
        return timeStamp
    }
}
