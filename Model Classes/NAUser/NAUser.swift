//
//  NAUser.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 16/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

//Created Class & Class Variable to pass the data
class GlobalUserData {
    
    static let shared = GlobalUserData()
    var flatDetails_Items = [FlatDetails]()
    var personalDetails_Items = [PersonalDetails]()
    var privileges_Items = [UserPrivileges]()
    
    func getUserDataReference() -> DatabaseReference {
        let userFlatDetails = GlobalUserData.shared.flatDetails_Items.first
        let userDataReference = Database.database().reference()
            .child(Constants.FIREBASE_USERDATA)
            .child(Constants.FIREBASE_USER_CHILD_PRIVATE)
            .child((userFlatDetails?.city)!)
            .child((userFlatDetails?.societyName)!)
            .child((userFlatDetails?.apartmentName)!)
            .child((userFlatDetails?.flatNumber)!)
        return userDataReference
    }
}

class NAUser {
    
    //created variables to get details from following classes.
    var flatDetails = [UserFlatDetails]()
    var personalDetails = [UserFlatDetails]()
    var privileges = [UserPrivileges]()
    var uid : String?
    
     //initiliazing variables
    init(uid: String?,flatDetails: UserFlatDetails,personalDetails: UserFlatDetails,privileges: UserPrivileges) {
    
        self.uid = uid
        self.flatDetails = [flatDetails]
        self.privileges = [privileges]
        self.personalDetails = [personalDetails]
    }
    
     //creating structure for firebase to get data on it.
    struct NAUserStruct {
        
        static let uid = "uid"
        static let tokenId = "tokenId"
        static let flatDetails = "flatDetails"
        static let privileges = "privileges"
        static let personalDetails = "personalDetails"
        
    }
}

