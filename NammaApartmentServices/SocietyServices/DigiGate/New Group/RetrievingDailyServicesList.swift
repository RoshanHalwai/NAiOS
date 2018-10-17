//
//  RetrievingDailyServicesList.swift
//  nammaApartment
//
//  Created by kirtan labs on 15/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class RetrievingDailyServicesList {
    
    var userUID = String()
    var userDataRef : DatabaseReference?
    var count = 0
    
    //Initializing variables
    init(userUID: String) {
        self.userUID = userUID
        userDataRef = GlobalUserData.shared.getUserDataReference()
    }
    
    public func getAllDailyServices(callback: @escaping (_ userDailyServivcesList: [NammaApartmentDailyServices]) -> Void) {
        
        var userDailyServicesList = [NammaApartmentDailyServices]()
        
        getAllDailyServiceUIDs { (dailyServiceUIDDictiornary) in
            if dailyServiceUIDDictiornary.count == 0 {
                callback(userDailyServicesList)
            }
            
            for dsCategory in dailyServiceUIDDictiornary.allKeys {
                
                self.getDailyServiceCategoryData(dsCategory: dsCategory as! String, dsUIDList: dailyServiceUIDDictiornary.value(forKey: dsCategory as! String) as! [String], callback: { (dailyserviceDictionary) in
                    self.count = self.count + 1
                    let dailyServices = dailyserviceDictionary[dsCategory as! String]
                    for dailyservice in dailyServices! {
                        userDailyServicesList.append(dailyservice)
                    }
                    
                    if self.count == dailyServiceUIDDictiornary.count {
                        self.count = 0
                        callback(userDailyServicesList)
                    }
                })
            }
        }
    }
    
    ///Returns a map with key as {@link DailyServiceType} and values as all daily services under that category
    ///which is in turn an instance of {@link NammaApartmentDailyService}
    ///
    ///- parameter dsCategory: category of the daily service
    ///- parameter dsUIDList:  list of all daily service UIDs which belong to dsCategory
    ///- parameter callback: to return map which contain data of daily service which belong to dsCategory
    private func getDailyServiceCategoryData(dsCategory : String, dsUIDList : Array<Any>, callback: @escaping (_ dailyserviceDictionary: [String: [NammaApartmentDailyServices]]) -> Void) {
        
        var dailyserviceDictionary = [String: [NammaApartmentDailyServices]]()
        var dailyServiceList = [NammaApartmentDailyServices]()
        for dsUID in dsUIDList {
            let dailyServiceRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dsCategory).child(dsUID as! String).child(userUID)
            
            dailyServiceRef.observeSingleEvent(of: .value) { (dailyServiceSnapshot) in
                //To get actual data of Daily Service
                let dailyServiceUIDRef = dailyServiceSnapshot.ref.parent
                dailyServiceUIDRef?.observeSingleEvent(of: .value, with: { (dsUIDSnapshot) in
                    
                    var flats = Int()
                    flats = Int(dsUIDSnapshot.childrenCount.advanced(by: -1))
                    
                    dailyServiceUIDRef?.child(Constants.FIREBASE_STATUS).observeSingleEvent(of: .value, with: { (statusSnapshot) in
                        
                        //To get status of daily service
                        //Getting Data Form Firebase & Adding into Model Class
                        let dailyServiceData = dailyServiceSnapshot.value as? [String: AnyObject]
                        
                        let fullName = dailyServiceData?[DailyServicesListFBKeys.fullName.key]
                        let phoneNumber = dailyServiceData?[DailyServicesListFBKeys.phoneNumber.key]
                        let profilePhoto = dailyServiceData?[DailyServicesListFBKeys.profilePhoto.key]
                        let rating = dailyServiceData?[DailyServicesListFBKeys.rating.key]
                        let timeOfVisit = dailyServiceData?[DailyServicesListFBKeys.timeOfVisit.key]
                        let type = dailyServiceData?[NADailyServicesStringFBKeys.type.key]
                        let uid = dailyServiceData?[DailyServicesListFBKeys.uid.key]
                        
                        let status = statusSnapshot.value as? String
                        
                        var handedThings = String()
                        var dateOfHandedThings = String()
                        let handedThingsRef = dailyServiceRef.child(Constants.FIREBASE_HANDEDTHINGS)
                        
                        //To get handed things history of daily service
                        handedThingsRef.observeSingleEvent(of: .value, with: { (handedThingsSnapshot) in
                            
                            if handedThingsSnapshot.exists() {
                                
                                let handedThingsData = handedThingsSnapshot.value as? NSDictionary
                                for handedThing in handedThingsData! {
                                    handedThings = handedThing.value as! String
                                    dateOfHandedThings = handedThing.key as! String
                                }
                            }
                            let dailyServicesData = NammaApartmentDailyServices(fullName: (fullName as! String), phoneNumber: phoneNumber as? String, profilePhoto: profilePhoto as? String, providedThings: handedThings, dateOfHandedThings: dateOfHandedThings, rating: rating as? Int, timeOfVisit: timeOfVisit as? String, uid: uid as? String, type: type as? String, numberOfFlat: flats, status: status)
                            
                            dailyServiceList.append(dailyServicesData)
                            if dailyServiceList.count == dsUIDList.count {
                                
                                dailyserviceDictionary.updateValue(dailyServiceList, forKey: dsCategory)
                                callback(dailyserviceDictionary)
                            }
                        })
                    })
                })
            }
        }
    }
    
    ///Returns all the daily service UIDs who have been added by the user
    ///
    ///- parameter callback: returns a callback which contains daily service category as key and all UIDs associated to each of the category
    private func getAllDailyServiceUIDs(callback: @escaping (_ dailyServiceUIDDictiornary: NSDictionary) -> Void) {
        var dailyServiceUIDDictiornary = [String:[String]]()
        
        getDailyServicesCategories { (dailyServiceCategoriesList) in
            
            //User has not added any daily services yet, hence return an empty map
            if dailyServiceCategoriesList.isEmpty {
                callback(dailyServiceUIDDictiornary as NSDictionary)
            }
            
            for dailyServiceCategory in dailyServiceCategoriesList {
                
                self.getDailyServicesUIDs(dailyServiceCategories: dailyServiceCategory, callback: { (dailyServiceUIDList) in
                    self.count = self.count + 1
                    
                    if dailyServiceUIDList.count != 0 {
                        dailyServiceUIDDictiornary.updateValue(dailyServiceUIDList, forKey: dailyServiceCategory)
                    }
                    
                    if self.count == dailyServiceCategoriesList.count {
                        self.count = 0
                        callback(dailyServiceUIDDictiornary as NSDictionary)
                    }
                })
            }
        }
    }
    
    ///Get daily service UIDs of one category of Daily Service, say 3 UIDs of Type Cook
    ///
    ///- parameter dailyServiceCategories: category of the daily service
    ///- parameter callback: returns a callback which contains a list of all UID which belong to daily service category
    private func getDailyServicesUIDs(dailyServiceCategories : String, callback: @escaping (_ dailyServiceUIDList: [String]) -> Void) {
        
        var dailyServiceUIDList = [String]()
        userDataRef?.child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(dailyServiceCategories).observeSingleEvent(of: .value, with: { (DSUIDSnapshot) in
            
            if DSUIDSnapshot.exists() {
                let dailyServicesUIDs = DSUIDSnapshot.value as! [String: Bool]
                for dailyServiceType in dailyServicesUIDs {
                    if dailyServiceType.value == NAString().gettrue() {
                        dailyServiceUIDList.append(dailyServiceType.key)
                    }
                }
            }
            callback(dailyServiceUIDList)
        })
    }
    
    ///Returns a list of all categories of daily services added by user.
    ///
    ///- parameter callback: returns a callback containing list of categories
    private func getDailyServicesCategories(callback: @escaping (_ dailyServiceCategoriesList: [String]) -> Void) {
        
        var dailyServiceCategoriesList = [String]()
        userDataRef?.child(Constants.FIREBASE_CHILD_DAILY_SERVICES).observeSingleEvent(of: .value, with: { (categoriesSnapshot) in
            
            if categoriesSnapshot.exists() {
                let categoryKeys = categoriesSnapshot.value as! NSDictionary
                for dailyServicetype in categoryKeys.allKeys {
                    dailyServiceCategoriesList.append(dailyServicetype as! String)
                }
            }
            callback(dailyServiceCategoriesList)
        })
    }
}
