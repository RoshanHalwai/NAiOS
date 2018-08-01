//
//  NAHandedThingsHistory.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NADailyServiceHandedThingsHistory {
    
    var fullName: String?
    var profilePhoto: String?
    var timeOfVisit: String?
    var uid: String?
    private var dateOfVisit: String?
    private var type: String?
    private var handedThings: String?
    private var status: String?
    
    //initilaize the variables
    init(fullName: String,profilePhoto: String,timeOfVisit: String,uid: String?,dateOfVisit: String?,type: String?,handedThings: String?,status: String?) {
        
        self.fullName = fullName
        self.profilePhoto = profilePhoto
        self.timeOfVisit = timeOfVisit
        self.uid = uid
        self.dateOfVisit = dateOfVisit
        self.type = type
        self.handedThings = handedThings
        self.status = status
        
    }
    
    func getfullName() -> String {
        return fullName!
    }
    
    func getprofilePhoto() -> String? {
        return profilePhoto!
    }
    
    func gettimeOfVisit() -> String {
        return timeOfVisit!
    }
    
    func getuid() -> String {
        return uid!
    }
    
    func getDateOfVisit() -> String {
        return dateOfVisit!
    }
    
    func getHandedThings() -> String {
        return handedThings!
    }
    
    func getType() -> String {
        return type!
    }
    
    func getStatus() -> String {
        return status!
    }
    
}
