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
    case gateNo
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .fullName: return "fullName"
        case .profilePhoto: return "profilePhoto"
        case .status: return "status"
        case .gateNo:return "gateNo"
        }
    }
}

class NAExpectingGuard {
    
    var fullName : String?
    var profilePhoto : String?
    var status : String?
    
    init(fullName : String?,profilePhoto : String?, status: String?) {
        self.fullName = fullName
        self.profilePhoto = profilePhoto
        self.status = status
    }
    
    func getfullName() -> String {
        return fullName!
    }
    
    func getprofilePhoto() -> String? {
        return profilePhoto!
    }
    
    func getstatus() -> String {
        return status!
    }
}
