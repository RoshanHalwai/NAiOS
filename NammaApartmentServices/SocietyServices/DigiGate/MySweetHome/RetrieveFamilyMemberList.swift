//
//  RetrieveFamilyMemberList.swift
//  nammaApartment
//
//  Created by kirtan labs on 29/07/18.
//  Copyright © 2018 Roshan Halwai. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RetrieveFamilyMemberList {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    
    let userDataReference : DatabaseReference
    var userUIDList = [String]()
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init() {
        userDataReference = GlobalUserData.shared.getUserDataReference()
        self.userUIDList.append(userUID)
    }
    
    /* ------------------------------------------------------------- *
     * Private API's
     * ------------------------------------------------------------- */
    
    //User UID whose data is to be retrieved from firebase
    public func getUserDataByUID(userUID : String, callback: @escaping (_ userData : NAUser) -> Void) {
        
        
        //Take each of the user UID and get their data from users -> all
        let userDataRef = Database.database().reference().child(Constants.FIREBASE_USER)
            .child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID)
        
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            let usersData = userDataSnapshot.value as? [String: AnyObject]
            
            //Creating instance of UserPersonalDetails
            let userPersonalDataMap = usersData?["personalDetails"] as? [String: AnyObject]
            let email = userPersonalDataMap?[UserPersonalListFBKeys.email.key] as? String
            let fullName = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
            let phoneNumber = userPersonalDataMap?[UserPersonalListFBKeys.phoneNumber.key] as? String
            let profilePhoto = userPersonalDataMap?[UserPersonalListFBKeys.profilePhoto.key] as? String
            let userPersonalDetails = UserPersonalDetails(email: email, fullName: fullName, phoneNumber: phoneNumber, profilePhoto: profilePhoto)
            
            //Creating instance of UserPrivileges
            let userPrivilegesDataMap = usersData?["privileges"] as? [String: AnyObject]
            let admin = userPrivilegesDataMap?[UserPrivilegesListFBKeys.admin.key] as? Bool
            let grantAccess = userPrivilegesDataMap?[UserPrivilegesListFBKeys.grantedAccess.key] as? Bool
            let verified = userPrivilegesDataMap?[UserPrivilegesListFBKeys.verified.key] as? Bool
            let userPrivileges = UserPrivileges(admin: admin, grantAccess: grantAccess, verified: verified)
            
            //Creating instance of UserFlatDetails
            var userFlatDataMap = usersData?["flatDetails"] as? [String: AnyObject]
            let apartmentName = userFlatDataMap?[UserFlatListFBKeys.apartmentName.key] as? String
            let city = userFlatDataMap?[UserFlatListFBKeys.city.key] as? String
            let flatNumber = userFlatDataMap?[UserFlatListFBKeys.flatNumber.key] as? String
            let societyName = userFlatDataMap?[UserFlatListFBKeys.societyName.key] as? String
            let tenantType = userFlatDataMap?[UserFlatListFBKeys.tenantType.key] as? String
            let userFlatDetails = UserFlatDetails(apartmentName: apartmentName, city: city, flatNumber: flatNumber, societyName: societyName, tenantType: tenantType)
            
            //Creating instance of NAUser
            let userData = NAUser(uid: userUID, flatDetails: userFlatDetails, personalDetails: userPersonalDetails, privileges: userPrivileges)
            
            //We are done with retrieval send the received data back to the calling function
            callback(userData)
            
        })
        
        
    }
    
}
