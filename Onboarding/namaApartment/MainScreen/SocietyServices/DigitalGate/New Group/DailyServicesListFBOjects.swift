//
//  DailyServicesListFBOjects.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 21/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class DailyServicesListFB {
    
    //defining strings according to firebase names which is inside the Daily Services Node.
    var fullName: String?
    var phoneNumber: String?
    var profilePhoto: String?
    var providedThings: Bool?
    var rating: Int?
    var timeOfVisit: String?
    var uid: String?
    
     //initilaize the variables
    init(fullName: String?,phoneNumber: String?,profilePhoto: String?,providedThings: Bool?,rating: Int?,timeOfVisit: String?,uid: String?) {
        
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.profilePhoto = profilePhoto
        self.providedThings = providedThings
        self.rating = rating
        self.timeOfVisit = timeOfVisit
        self.uid = uid
    }
    
      //creating structure for firebase to get data on it.
    struct DailyServicesListFBOjects {
        
        static let fullName = "fullName"
        static let phoneNumber = "phoneNumber"
        static let profilePhoto = "profilePhoto"
        static let providedThings = "providedThings"
        static let rating = "rating"
        static let timeOfVisit = "timeOfVisit"
        static let uid = "uid"
    }
}
