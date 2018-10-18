//
//  RetrievingCabsList.swift
//  nammaApartment
//
//  Created by Sundir Talari on 18/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RetrievingCabsList {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    let userDataReference : DatabaseReference
    var userUIDList = [String]()
    var userFamilyMembersUID = [String]()
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init(pastGuestListRequired: Bool ) {
        userDataReference = GlobalUserData.shared.getUserDataReference()
        userFamilyMembersUID = GlobalUserData.shared.getNammaApartmentUser().getFamilyMembers()
        self.userUIDList.append(userUID)
        self.userUIDList.append(contentsOf: userFamilyMembersUID)
    }
    
    
}


