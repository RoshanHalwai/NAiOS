//
//  RetrievingGuestList.swift
//  nammaApartment
//
//  Created by Sundir Talari on 28/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RetrievingGuestList {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    
    let userDataReference : DatabaseReference
    var userUIDList = [String]()
    var pastGuestListRequired: Bool
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init(pastGuestListRequired: Bool ) {
        userDataReference = GlobalUserData.shared.getUserDataReference()
        self.userUIDList.append(userUID)
        self.pastGuestListRequired = pastGuestListRequired
        // TODO Add UID of the family member as well
    }
    
    /* ------------------------------------------------------------- *
     * Public API's
     * ------------------------------------------------------------- */
    
    // Returns a list of all guests of a user along with their family members
    public func getGuests(callback : @escaping (_ allGuestList : [NammaApartmentVisitor]) -> Void) {
        var allGuestList = [NammaApartmentVisitor]()
        var count = 0
        self.isGuestRefExists { (guestRefExists) in
            if guestRefExists == true {
                for userUID in self.userUIDList {
                    self.getGuests(userUID: userUID, callback: { (userGuestList) in
                        allGuestList.append(contentsOf: userGuestList)
                        count = count + 1
                        if (count == self.userUIDList.count) {
                            callback(allGuestList)
                        }
                    })
                }
            } else {
                callback(allGuestList)
            }
        }
    }
    
    /* ------------------------------------------------------------- *
     * Private API's
     * ------------------------------------------------------------- */
    
    // Checks if flat has Visitors key as one of its children
    private func isGuestRefExists(callback : @escaping (_ guestRefExists : Bool) -> Void) {
        let guestDataReference = self.userDataReference.child(Constants.FLAT_Visitor)
        guestDataReference.observeSingleEvent(of: .value) { (dataSnapshot) in
            callback(dataSnapshot.exists())
        }
    }
    
    // Takes user UID as input and returns all their guests
    private func getGuests(userUID : String, callback : @escaping (_ guestList : [NammaApartmentVisitor]) -> Void) {
        self.getGuestUIDList(userUID: userUID) { (guestUIDList) in
            self.getGuestsList(guestUIDList: guestUIDList, callback: { (guestList) in
                callback(guestList)
            })
        }
    }
    
    // Take user UID as input and returns a list of all guests UID
    private func getGuestUIDList(userUID : String, callback : @escaping (_ guestUIDList : [String]) -> Void) {
        let guestListReference = self.userDataReference
            .child(Constants.FLAT_Visitor)
            .child(userUID)
        
        guestListReference.observeSingleEvent(of: .value) { (snapshot) in
            var guestUIDList = [String]()
            let guestsUIDMap = snapshot.value as? NSDictionary
            for guestUID in (guestsUIDMap?.allKeys)! {
                
                //TODO: Add one more condition to the below if statement for Handed things history
                if guestsUIDMap![guestUID] as! Bool == true || guestsUIDMap![guestUID] as! Bool == self.pastGuestListRequired {
                    guestUIDList.append(guestUID as! String)
                }
            }
            callback(guestUIDList)
        }
    }
    
    // Takes a list of all guests UID and returns a list of all guest data
    private func getGuestsList(guestUIDList : [String], callback : @escaping (_ guestList : [NammaApartmentVisitor]) -> Void) {
        var guestList = [NammaApartmentVisitor]()
        
        if guestUIDList.count == 0 {
            callback(guestList)
        } else {
            for guestUID in guestUIDList {
                self.getGuestDataByUID(visitorUID: guestUID) { (guestData) in
                    guestList.append(guestData)
                    if(guestList.count == guestUIDList.count) {
                        callback(guestList)
                    }
                }
            }
        }
    }
    
    //Guest UID whose data is to be retrieved from firebase
    private func getGuestDataByUID(visitorUID : String, callback: @escaping (_ enteredGuestData : NammaApartmentVisitor) -> Void) {
        
        //Take each of the visitor UID and get their data from visitors -> preApprovedVisitors
        let visitorDataRef = Database.database().reference().child(Constants.FIREBASE_CHILD_VISITORS)
            .child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS).child(visitorUID)
        
        
        //Adding observe event to each of visitors UID
        visitorDataRef.observeSingleEvent(of: .value, with: { (guestDataSnapshot) in
            let guestsData = guestDataSnapshot.value as? [String: AnyObject]
            
            //We check the status of the guest and add to entered guest list only when the guest status is entered
            let status = guestsData?[VisitorListFBKeys.status.key] as? String
            
            //We create an instance of Namma Apartment guest to append to entered guest list
            let dateAndTimeOfVisit = guestsData?[VisitorListFBKeys.dateAndTimeOfVisit.key] as? String
            let fullName = guestsData?[VisitorListFBKeys.fullName.key] as? String
            let inviterUID = guestsData?[VisitorListFBKeys.inviterUID.key] as? String
            let mobileNumber = guestsData?[VisitorListFBKeys.mobileNumber.key] as? String
            let profilePhoto = guestsData?[VisitorListFBKeys.profilePhoto.key] as? String
            let uid = guestsData?[VisitorListFBKeys.uid.key] as? String
            var handedThings = ""
            if guestsData?[VisitorListFBKeys.handedThings.key] != nil {
                handedThings = (guestsData?[VisitorListFBKeys.handedThings.key] as? String)!
            }
            
            let enteredGuestData = NammaApartmentVisitor(dateAndTimeOfVisit: dateAndTimeOfVisit , fullName: fullName , inviterUID: inviterUID , mobileNumber: mobileNumber , profilePhoto: profilePhoto , status: status, uid: uid, handedThings: handedThings)
            
            //We are done with retrieval send the received data back to the calling function
            callback(enteredGuestData)
        })
    }
}
