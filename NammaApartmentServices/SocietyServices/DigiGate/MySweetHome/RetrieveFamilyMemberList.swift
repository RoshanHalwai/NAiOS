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
    }
    
    /* ------------------------------------------------------------- *
     * Public API's
     * ------------------------------------------------------------- */
    
    //Takes a userUID and returns a list of their friends and family members data
    public func getFriendsAndFamilyMembers(userUID : String, callback: @escaping (_ familyAndFriendsDataList : [NAUser]) -> Void) {
        var familyAndFriendsDataList = [NAUser]()
        
        self.getFamilyMembersDataList(userUID: userUID) { (familyMembersDataList) in
            familyAndFriendsDataList.append(contentsOf: familyMembersDataList)
            self.getFriendsDataList(userUID: userUID, callback: { (friendsDataList) in
                familyAndFriendsDataList.append(contentsOf: friendsDataList)
                callback(familyAndFriendsDataList)
            })
        }
    }
    
    /* ------------------------------------------------------------- *
     * Private API's
     * ------------------------------------------------------------- */
    
    //Take userUID and returns a list of family members data added by the user
    private func getFamilyMembersDataList(userUID : String, callback: @escaping (_ familyMembersDataList : [NAUser]) -> Void) {
        var familyMembersDataList = [NAUser]()
        
        self.getFamilyMembersUIDList(userUID: userUID) { (familyMembersUIDList) in
            //If FamilyMembers UID List is empty we check if user has any friends
            if familyMembersUIDList.count == 0 {
                callback(familyMembersDataList)
            } else {
                //User has family members so we append family members data in the list
                self.getUserDataList(userUIDList: familyMembersUIDList, callback: { (familyMembersData) in
                    familyMembersDataList.append(contentsOf: familyMembersData)
                    callback(familyMembersDataList)
                })
            }
        }
    }
    
    //Take userUID and returns a list of friends data added by the user
    private func getFriendsDataList(userUID : String, callback: @escaping (_ friendsDataList : [NAUser]) -> Void) {
        var friendsDataList = [NAUser]()
        
        self.getFriendsUIDList(userUID: userUID, callback: { (friendsUIDList) in
            if friendsUIDList.count == 0 {
                callback(friendsDataList)
            } else {
                //Appending user friends data to the friends data list
                self.getUserDataList(userUIDList: friendsUIDList, callback: { (friendsData) in
                    friendsDataList.append(contentsOf: friendsData)
                    callback(friendsDataList)
                })
            }
        })
    }
    
    //Take a userUID and returns a list of their family members UID
    private func getFamilyMembersUIDList(userUID : String, callback: @escaping (_ familyMembersUIDList : [String]) -> Void) {
        var familyMembersUIDList = [String]()
        
        let flatMemberReference = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
            .child(userUID).child(Constants.FIREBASE_CHILD_FAMILY_MEMBERS)
        flatMemberReference.observeSingleEvent(of: .value) { (familyMemberUIDSnapshot) in
            if  !familyMemberUIDSnapshot.exists() {
                callback(familyMembersUIDList)
            } else {
                let familyMemberUIDMap = familyMemberUIDSnapshot.value as? NSDictionary
                for familyMemberUID in (familyMemberUIDMap?.allKeys)! {
                    familyMembersUIDList.append(familyMemberUID as! String)
                }
                callback(familyMembersUIDList)
            }
        }
    }
    
    //Take a userUID and returns a list of their friends UID
    private func getFriendsUIDList(userUID : String, callback: @escaping (_ friendsUIDList : [String]) -> Void) {
        var friendsUIDList = [String]()
        
        let flatMemberReference = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
            .child(userUID).child(Constants.FIREBASE_CHILD_FRIENDS)
        flatMemberReference.observeSingleEvent(of: .value) { (friendsUIDSnapshot) in
            if  !friendsUIDSnapshot.exists() {
                callback(friendsUIDList)
            } else {
                let friendsUIDMap = friendsUIDSnapshot.value as? NSDictionary
                for friendUID in (friendsUIDMap?.allKeys)! {
                    friendsUIDList.append(friendUID as! String)
                }
                callback(friendsUIDList)
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
