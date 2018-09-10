//
//  retrieveUserDataFromFirebase.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 09/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseMessaging

class retrieveUserData {
    
    var usersPrivateRef: DatabaseReference?
    var navigationMenuVC: NavigationMenuViewController!
    
    func retrieveUserDataFromFirebase(userId: String) {
        
        //Created Token ID & Storing in Firebase
        let token = Messaging.messaging().fcmToken
        
        var usersTokenRef : DatabaseReference?
        usersTokenRef = Constants.FIREBASE_USERS_PRIVATE.child(userId)
        usersTokenRef?.child(NAUser.NAUserStruct.tokenId).setValue(token)
        
        //Checking Users UID in Firebase under Users ->Private
        usersPrivateRef = Constants.FIREBASE_USERS_PRIVATE.child(userId)
        
        //Checking userData inside Users/Private
        usersPrivateRef?.observeSingleEvent(of: .value, with: { snapshot in
            
            //If usersUID is Exists then retrievd all the data of user.
            if snapshot.exists() {
                
                let userData = snapshot.value as? NSDictionary
                print("UserData:",userData as Any)
                
                //Retrieving & Adding data in Flat Detail Class
                let flatdetails_data = userData![Constants.FIREBASE_CHILD_FLATDETAILS] as? [String :Any]
                let userFlatDetails = UserFlatDetails.init(
                    apartmentName: flatdetails_data![Constants.FIREBASE_CHILD_APARTMENT_NAME] as? String,
                    city: (flatdetails_data![Constants.FIREBASE_CHILD_CITY] as! String),
                    flatNumber: flatdetails_data![Constants.FIREBASE_CHILD_FLATNUMBER] as? String,
                    societyName: flatdetails_data![Constants.FIREBASE_CHILD_SOCIETY_NAME] as? String,
                    tenantType: flatdetails_data![Constants.FIREBASE_CHILD_TENANT_TYPE] as? String)
                
                flatDetailsFB.append(userFlatDetails)
                
                GlobalUserData.shared.flatDetails_Items = flatDetailsFB
                
                //Retrieving & Adding Data in UserPersonalDetails class
                let userPersonal_data = userData![Constants.FIREBASE_CHILD_PERSONALDETAILS] as? [String :Any]
                let userPersonalDetails = UserPersonalDetails.init(email: userPersonal_data![Constants.FIREBASE_CHILD_EMAIL] as? String, fullName:userPersonal_data![Constants.FIREBASE_CHILD_FULLNAME] as? String , phoneNumber:userPersonal_data![Constants.FIREBASE_CHILD_PHONENUMBER] as? String, profilePhoto: userPersonal_data![Constants.FIREBASE_CHILD_PERSONALDETAILS_PROFILEIMAGE] as? String)
                personalDetails.append(userPersonalDetails)
                GlobalUserData.shared.personalDetails_Items = personalDetails
                
                //Retriving & Adding data in Privileges
                let privilage_data = userData![Constants.FIREBASE_CHILD_PRIVILEGES] as? [String : Any]
                let userPrivileges = UserPrivileges.init(admin: privilage_data![Constants.FIREBASE_CHILD_ADMIN]as? Bool, grantAccess: privilage_data![Constants.FIREBASE_CHILD_GRANTACCESS] as? Bool, verified: privilage_data![Constants.FIREBASE_CHILD_VERIFIED] as? Int)
                userprivileges.append(userPrivileges)
                GlobalUserData.shared.privileges_Items = userprivileges
                
                //Retriving & Adding data in Family Members
                let familyMembers_data = userData![Constants.FIREBASE_CHILD_FAMILY_MEMBERS] as? NSDictionary
                var familyMembersUIDList = [String]()
                if (familyMembers_data != nil) {
                    for familyMemberUID in (familyMembers_data?.allKeys)! {
                        familyMembersUIDList.append(familyMemberUID as! String)
                    }
                }
                
                //Retriving & Adding data in Friends
                let friends_data = userData![Constants.FIREBASE_CHILD_FRIENDS] as? NSDictionary
                var friendsUIDList = [String]()
                if (friends_data != nil) {
                    for friendsUID in (friends_data?.allKeys)! {
                        friendsUIDList.append(friendsUID as! String)
                    }
                }
                
                let nammaApartmentUser = NAUser.init(uid: userUID, flatDetails: userFlatDetails, personalDetails: userPersonalDetails, privileges: userPrivileges, familyMembers: familyMembersUIDList, friends:friendsUIDList)
                GlobalUserData.shared.setNammaApartmentUser(nammaApartmentUser: nammaApartmentUser)
            }
        })
    }
}

