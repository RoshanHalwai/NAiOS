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

//Global variable to store users UID
let usersUID = Auth.auth().currentUser?.uid

class NAUser {
    
    //created variables to get details from following classes.
    var flatDetails = [UserFlatDetails]()
    var personalDetails = [UserFlatDetails]()
    var privileges = [UserPrivileges]()
    var uid : String?
    
     //initiliazing variables
    init(uid: String?,flatDetails: UserFlatDetails,personalDetails: UserFlatDetails,privileges: UserPrivileges ) {
    
        self.uid = uid
        self.flatDetails = [flatDetails]
        self.privileges = [privileges]
        self.personalDetails = [personalDetails]
    }
    
     //creating structure for firebase to get data on it.
    struct NAUserStruct {
        
        static let uid = "uid"
        static let flatDetails = "flatDetails"
        static let privileges = "privileges"
        static let personalDetails = "personalDetails"
    }
}

