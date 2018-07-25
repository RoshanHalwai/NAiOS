//
//  UserFlatDetails.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum UserFlatListFBKeys : String {
    case apartmentName
    case city
    case flatNumber
    case societyName
    case tenantType
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .apartmentName: return "apartmentName"
        case .city: return "city"
        case .flatNumber: return "flatNumber"
        case .societyName: return "societyName"
        case .tenantType: return "tenantType"
        }
    }
}

class UserFlatDetails {
    
    //creatig string variables to get data from Firebase.
     var apartmentName: String?
     var city: String?
     var flatNumber: String?
     var societyName: String?
     var tenantType: String?
    
     //initiliazing variables
    init(apartmentName: String?,city: String?,flatNumber: String?,societyName: String?,tenantType: String?) {
        
        self.apartmentName = apartmentName
        self.city = city
        self.flatNumber = flatNumber
        self.societyName = societyName
        self.tenantType = tenantType
    }
    
    func getapartmentName() -> String {
        return apartmentName!
    }
    func getcity() -> String {
        return city!
    }
    func getflatNumber() -> String {
        return flatNumber!
    }
    func getsocietyName() -> String {
        return societyName!
    }
    func gettenantType() -> String {
        return tenantType!
    }
}

class FlatDetails {
    
    private var _apartmentName: String?
    private var _city: String?
    private var _flatNumber: String?
    private var _societyName: String?
    private var _tenantType: String?
    
    var apartmentName : String! {
        get {
            return _apartmentName
        } set {
            if newValue != nil && newValue != ""{
                self._apartmentName = newValue
            }
        }
    }
    var city : String! {
        get {
            return _city
        } set {
            if newValue != nil && newValue != ""{
                self._city = newValue
            }
        }
    }
    
    var flatNumber : String! {
        get {
            return _flatNumber
        } set {
            if newValue != nil && newValue != ""{
                self._flatNumber = newValue
            }
        }
    }
    
    var societyName : String! {
        get {
            return _societyName
        } set {
            if newValue != nil && newValue != ""{
                self._societyName = newValue
            }
        }
    }
    
    var tenantType : String! {
        get {
            return _tenantType
        } set {
            if newValue != nil && newValue != ""{
                self._tenantType = newValue
            }
        }
    }
    
 init(apartmentName: String?,city: String?,flatNumber: String?,societyName: String?,tenantType: String?) {
        self.apartmentName = apartmentName
        self.city = city
        self.flatNumber = flatNumber
        self.societyName = societyName
        self.tenantType = tenantType
    }
}
