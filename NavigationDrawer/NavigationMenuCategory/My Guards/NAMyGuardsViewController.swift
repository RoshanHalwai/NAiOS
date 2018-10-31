//
//  NAMyGuardsViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/22/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum GuardsListFBKeys: String {
    case fullName
    case profilePhoto
    case status
    case gateNumber
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .fullName: return "fullName"
        case .profilePhoto: return "profilePhoto"
        case .status: return "status"
        case .gateNumber:return "gateNumber"
        }
    }
}

class NAExpectingGuard {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    
    var fullName : String
    var profilePhoto : String
    var status : String
    var gateNumber : Int
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init(fullName : String,profilePhoto : String, status: String, gateNumber: Int) {
        self.fullName = fullName
        self.profilePhoto = profilePhoto
        self.status = status
        self.gateNumber = gateNumber
    }
    
    func getfullName() -> String {
        return fullName
    }
    
    func getprofilePhoto() -> String? {
        return profilePhoto
    }
    
    func getstatus() -> String {
        return status
    }
    
    func getgateNumber() -> Int {
        return gateNumber
    }
}
