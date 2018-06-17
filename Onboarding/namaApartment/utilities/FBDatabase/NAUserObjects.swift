//
//  NAFBObjects.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 16/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class NAUserObjects: NSObject {
    
    //Created global varible to get info. about user after login successfull
    var userName = [NAUser]()
    
    //Created variable of DBReference for storing data in firebase
    var getUserReference : DatabaseReference?
    
    func getUser() -> NAUser {
        
        let user = NAUser()
        //Assigning Child from where to get data in Visitor List.
        getUserReference = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        getUserReference?.observe(DataEventType.value, with: { (snapshot) in
            //checking that  child node have data or not inside firebase. If Have then fatch all the data in tableView
            if snapshot.childrenCount > 0 {
                
                //for loop for getting all the data in tableview
                for users in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let userObject = users.value as? [String: AnyObject]
                    
                    user.admin = userObject?["admin"] as? String
                    user.apartmentName = userObject?["apartmentName"] as? String
                    user.emailId = userObject?["emailId"] as? String
                    user.flatNumber = userObject?["flatNumber"] as? String
                    user.fullName = userObject?["fullName"] as? String
                    user.grantedAccess = userObject?["grantedAccess"] as? String
                    user.phoneNumber = userObject?["phoneNumber"] as? String
                    user.profilePhoto = userObject?["profilePhoto"] as? String
                    user.societyName = userObject?["societyName"] as? String
                    user.tenantType = userObject?["tenantType"] as? String
                    user.uid = userObject?["uid"] as? String
                    user.verified = userObject?["verified"] as? String
                }
            }
            
        })
        
        return user
    }
}
