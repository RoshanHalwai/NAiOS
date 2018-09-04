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
    var userDataRef: DatabaseReference!
    var userUIDList = [String]()
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init() {
        userDataReference = GlobalUserData.shared.getUserDataReference()
    }
    
    /* ------------------------------------------------------------- *
     * Public API's
     * ------------------------------------------------------------- */
    
    //Takes a userUID and returns a list of their friends and family members data
    public func getFriendsAndFamilyMembers(userUID : String, callback: @escaping (_ familyAndFriendsDataList : [NAUser]) -> Void) {
        var familyAndFriendsDataList = [NAUser]()
        self.getFlatMembersDataList(userUID: userUID) { (familyMembersDataList) in
            familyAndFriendsDataList.append(contentsOf: familyMembersDataList)
            callback(familyAndFriendsDataList)
        }
    }
    
    /* ------------------------------------------------------------- *
     * Private API's
     * ------------------------------------------------------------- */
    
    //Takes a list of userUID and returns a list of flat members data list.
    private func getFlatMembersDataList(userUID : String, callback: @escaping (_ flatMemberDataList : [NAUser]) -> Void) {
        var flatMemberDataList = [NAUser]()
        
        self.getFlatMembersUIDList(userUID: userUID, callback: { (flatMembersUIDList) in
            if flatMembersUIDList.count == 0 {
                callback(flatMemberDataList)
            } else {
                //Appending user friends data to the friends data list
                self.getUserDataList(userUIDList: flatMembersUIDList, callback: { (friendsData) in
                    flatMemberDataList.append(contentsOf: friendsData)
                    callback(flatMemberDataList)
                })
            }
        })
    }
    
    //Takes a list of userUID and returns a list of flat members UID List.
    private func getFlatMembersUIDList(userUID : String, callback: @escaping (_ flatMembersUIDList : [String]) -> Void) {
        var flatMembersUIDList = [String]()
        
        let flatMembersReference = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_FLATMEMBERS)
        flatMembersReference.keepSynced(true)
        flatMembersReference.observeSingleEvent(of: .value) { (flatMembersUIDSnapshot) in
            if flatMembersUIDSnapshot.childrenCount == 1 {
                callback(flatMembersUIDList)
            } else {
                let flatMembersUIDMap = flatMembersUIDSnapshot.value as? NSDictionary
                for flatMemberUID in (flatMembersUIDMap?.allKeys)! {
                    if flatMemberUID as! String != userUID {
                        flatMembersUIDList.append(flatMemberUID as! String)
                    }
                }
                callback(flatMembersUIDList)
            }
        }
    }
    
    //Takes a list of userUID and returns a list of userData
    private func getUserDataList(userUIDList : [String], callback: @escaping (_ userDataList : [NAUser]) -> Void) {
        var userDataList = [NAUser]()
        
        for userUID in userUIDList {
            self.getUserDataByUID(userUID: userUID) { (userData) in
                userDataList.append(userData)
                if(userUIDList.count == userDataList.count) {
                    callback(userDataList)
                }
            }
        }
    }
    
    //User UID whose data is to be retrieved from firebase
    private func getUserDataByUID(userUID : String, callback: @escaping (_ userData : NAUser) -> Void) {
        //Take each of the user UID and get their data from users -> all
        userDataRef = Constants.FIREBASE_USER_PRIVATE.child(userUID)
        userDataRef.keepSynced(true)
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            let usersData = userDataSnapshot.value as? [String: AnyObject]
            
            //Creating instance of UserPersonalDetails
            let userPersonalDataMap = usersData?[Constants.FIREBASE_CHILD_PERSONALDETAILS] as? [String: AnyObject]
            let email = userPersonalDataMap?[UserPersonalListFBKeys.email.key] as? String
            let fullName = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
            let phoneNumber = userPersonalDataMap?[UserPersonalListFBKeys.phoneNumber.key] as? String
            let profilePhoto = userPersonalDataMap?[UserPersonalListFBKeys.profilePhoto.key] as? String
            let userPersonalDetails = UserPersonalDetails(email: email, fullName: fullName, phoneNumber: phoneNumber, profilePhoto: profilePhoto)
            
            //Creating instance of UserPrivileges
            let userPrivilegesDataMap = usersData?[Constants.FIREBASE_CHILD_PRIVILEGES] as? [String: AnyObject]
            let admin = userPrivilegesDataMap?[UserPrivilegesListFBKeys.admin.key] as? Bool
            let grantAccess = userPrivilegesDataMap?[UserPrivilegesListFBKeys.grantedAccess.key] as? Bool
            let verified = userPrivilegesDataMap?[UserPrivilegesListFBKeys.verified.key] as? Int
            let userPrivileges = UserPrivileges(admin: admin, grantAccess: grantAccess, verified: verified)
            
            //Creating instance of UserFlatDetails
            var userFlatDataMap = usersData?[Constants.FIREBASE_CHILD_FLATDETAILS] as? [String: AnyObject]
            let apartmentName = userFlatDataMap?[UserFlatListFBKeys.apartmentName.key] as? String
            let city = userFlatDataMap?[UserFlatListFBKeys.city.key] as? String
            let flatNumber = userFlatDataMap?[UserFlatListFBKeys.flatNumber.key] as? String
            let societyName = userFlatDataMap?[UserFlatListFBKeys.societyName.key] as? String
            let tenantType = userFlatDataMap?[UserFlatListFBKeys.tenantType.key] as? String
            let userFlatDetails = UserFlatDetails(apartmentName: apartmentName, city: city, flatNumber: flatNumber, societyName: societyName, tenantType: tenantType)
            
            //Create instance of FamilyMembers
            let userFamilyMembersDataMap:[String: AnyObject]? = usersData?[Constants.FIREBASE_CHILD_FAMILY_MEMBERS] as? [String: AnyObject]
            var familyMembersUIDList = [String]()
            if userFamilyMembersDataMap != nil {
                for familyMemberUID in (userFamilyMembersDataMap?.keys)! {
                    familyMembersUIDList.append(familyMemberUID)
                }
            }
            
            //Create instance of Friends
            let userFriendsDataMap:[String: AnyObject]? = usersData?[Constants.FIREBASE_CHILD_FRIENDS] as? [String: AnyObject]
            var friendsUIDList = [String]()
            if userFriendsDataMap != nil {
                for friendUID in (userFriendsDataMap?.keys)! {
                    friendsUIDList.append(friendUID)
                }
            }
            
            //Creating instance of NAUser
            let userData = NAUser(uid: userUID, flatDetails: userFlatDetails, personalDetails: userPersonalDetails, privileges: userPrivileges, familyMembers: familyMembersUIDList, friends: friendsUIDList)
             GlobalUserData.shared.setNammaApartmentUser(nammaApartmentUser: userData)
            
            //We are done with retrieval send the received data back to the calling function
            callback(userData)
        })
        
    }
    
}
