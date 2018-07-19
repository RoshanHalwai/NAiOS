//
//  UserPersonalDetails.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum UserPersonalListFBKeys : String {
    case email
    case fullName
    case phoneNumber
    case profilePhoto
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .email: return "email"
        case .fullName: return "fullName"
        case .phoneNumber:
            return "phoneNumber"
        case .profilePhoto:
            return "profilePhoto"
        }
    }
}

class UserPersonalDetails {
    
    //creatig string variables to get data from Firebase.
    var email: String?
    var fullName: String?
    var phoneNumber: String?
    var profilePhoto: String?
    
    //initiliazing variables
    init(email: String?,fullName: String?,phoneNumber: String?,profilePhoto: String?) {
        
        self.email = email
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.profilePhoto = profilePhoto
    }
    
    func getfullName() -> String {
        return fullName!
    }
    func getemail() -> String {
        return email!
    }
    func getphoneNumber() -> String {
        return phoneNumber!
    }
    func getprofilePhoto() -> String {
        return profilePhoto!
    }
}

class PersonalDetails {
    
    private var _email: String?
    private var _fullName: String?
    private var _phoneNumber: String?
    
    var email : String! {
        get {
            return _email
        } set {
            if newValue != nil && newValue != ""{
                self._email = newValue
            }
        }
    }
    var fullName : String! {
        get {
            return _fullName
        } set {
            if newValue != nil && newValue != ""{
                self._fullName = newValue
            }
        }
    }
    
    var phoneNumber : String! {
        get {
            return _phoneNumber
        } set {
            if newValue != nil && newValue != ""{
                self._phoneNumber = newValue
            }
        }
    }
    
    init(email: String?,fullName: String?,phoneNumber: String?) {
        self.email = email
        self.fullName = fullName
        self.phoneNumber = phoneNumber
    }
}
