//
//  DailyServicesListFBOjects.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 21/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum DailyServicesListFBKeys: String {
    case fullName
    case phoneNumber
    case profilePhoto
    case providedThings
    case rating
    case timeOfVisit
    case uid
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .fullName: return "fullName"
        case .phoneNumber: return "phoneNumber"
        case .profilePhoto: return "profilePhoto"
        case .providedThings: return "providedThings"
        case .rating: return "rating"
        case .timeOfVisit:return "timeOfVisit"
        case .uid: return "uid"
        }
    }
}

class NammaApartmentDailyServices {
    //defining strings according to firebase names which is inside the Daily Services Node.
    var fullName: String?
    var phoneNumber: String?
    var profilePhoto: String?
    var providedThings: String
    var dateOfHandedThings : String
    var rating: Int?
    var timeOfVisit: String?
    var uid: String?
    private var type: String?
    private var numberOfFlat: Int?
    private var status: String?
    
    //initilaize the variables
    init(fullName: String?,phoneNumber: String?,profilePhoto: String?,providedThings: String,dateOfHandedThings: String,rating: Int?,timeOfVisit: String?,uid: String?, type: String?, numberOfFlat: Int?,status: String?) {
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.profilePhoto = profilePhoto
        self.providedThings = providedThings
        self.dateOfHandedThings = dateOfHandedThings
        self.rating = rating
        self.timeOfVisit = timeOfVisit
        self.uid = uid
        self.type = type
        self.numberOfFlat = numberOfFlat
        self.status = status
    }
    
    //Get FullName
    func getfullName() -> String {
        return fullName!
    }
    
    //Get phoneNumber
    func getphoneNumber() -> String {
        return phoneNumber!
    }
    
    //Get profilePhoto
    func getprofilePhoto() -> String? {
        return profilePhoto!
    }
    
    //Get providedThings
    func getprovidedThings() -> String {
        return providedThings
    }
    
    func getDateOfHandedThings() -> String {
        return dateOfHandedThings
    }
    
    //Get mobileNumber
    func getrating() -> Int {
        return rating!
    }
    
    func setRating(rating: Int) {
        self.rating = rating
    }
    
    //Get timeOfVisit
    func gettimeOfVisit() -> String {
        return timeOfVisit!
    }
    
    //Get uid
    func getuid() -> String {
        return uid!
    }
    
    func getNumberOfFlats() -> Int {
        return numberOfFlat!
    }
    
    func setFlats(flats: Int) {
        self.numberOfFlat = flats
    }
    
    func getType() -> String {
        return type!
    }
    
    func getStatus() -> String {
        return status!
    }
}

