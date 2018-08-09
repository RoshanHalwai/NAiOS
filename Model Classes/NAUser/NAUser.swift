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
    var flatDetails_Items = [UserFlatDetails]()
    var personalDetails_Items = [UserPersonalDetails]()
    var privileges_Items = [UserPrivileges]()
    var nammaApartmentUser : NAUser?
    
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
    
    func getNammaApartmentUser() -> NAUser {
        return nammaApartmentUser!
    }
    
    func setNammaApartmentUser(nammaApartmentUser: NAUser) {
        self.nammaApartmentUser = nammaApartmentUser
    }
}

class NAUser {
    
    //created variables to get details from following classes.
    var flatDetails : UserFlatDetails
    var personalDetails : UserPersonalDetails
    var privileges : UserPrivileges
    var familyMembers : [String]
    var friends : [String]
    var uid : String?
    
    init(uid: String?,flatDetails: UserFlatDetails,personalDetails: UserPersonalDetails,privileges: UserPrivileges,
         familyMembers: [String], friends:[String]) {
        self.uid = uid
        self.flatDetails = flatDetails
        self.privileges = privileges
        self.personalDetails = personalDetails
        self.familyMembers = familyMembers
        self.friends = friends
    }
    
    //Get uid
    func flatMembersUID() -> String {
        return uid!
    }
    func getFamilyMembers() -> [String] {
        return familyMembers
    }
    
    func getFriends() -> [String] {
        return friends
    }
    
    //creating structure for firebase to get data on it.
    struct NAUserStruct {
        
        static let uid = "uid"
        static let tokenId = "tokenId"
        static let flatDetails = "flatDetails"
        static let privileges = "privileges"
        static let personalDetails = "personalDetails"
        static let familyMembers = "familyMembers"
        static let friends = "friends"
    }
}

