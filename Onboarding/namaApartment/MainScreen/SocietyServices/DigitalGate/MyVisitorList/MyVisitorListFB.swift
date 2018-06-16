//
//  MyVisitorListFB.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 16/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAVisitor {
    
    //defining strings according to firebase names which is inside the visitor Node.
    var dateAndTimeOfVisit: String?
    var fullName: String?
    var inviterUID: String?
    var mobileNumber: String?
    var profilePhoto: String?
    var status: String?
    var uid: String?
    
    //initilaize the variables
    init(dateAndTimeOfVisit: String?,fullName: String?,inviterUID: String?,mobileNumber: String?,profilePhoto: String?,status: String?,uid: String?) {
        
        self.dateAndTimeOfVisit = dateAndTimeOfVisit
        self.fullName = fullName
        self.inviterUID = inviterUID
        self.mobileNumber = mobileNumber
        self.profilePhoto = profilePhoto
        self.status = status
        self.uid = uid
    }
}
