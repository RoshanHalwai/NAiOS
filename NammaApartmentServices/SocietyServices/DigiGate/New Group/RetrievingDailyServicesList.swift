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
                    userDailyServicesList.append(dailyserviceDictionary.value(forKey: dsCategory as! String) as! NammaApartmentDailyServices)
                    
                    if self.count == dailyServiceUIDDictiornary.count {
                        self.count = 0
                        callback(userDailyServicesList)
                    }
                })
            }
        }
    }
    
    private func getDailyServiceCategoryData(dsCategory : String, dsUIDList : [String], callback: @escaping (_ dailyserviceDictionary: NSDictionary) -> Void) {
        
        var dailyserviceDictionary = [String: AnyObject]()
        var dailyServiceList = [NammaApartmentDailyServices]()
        for dsUID in dsUIDList {
            let dailyServiceRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dsCategory).child(dsUID).child(userUID)
            
            dailyServiceRef.observeSingleEvent(of: .value) { (dailyServiceSnapshot) in
                
                let dailyServiceUIDRef = dailyServiceSnapshot.ref.parent
                dailyServiceUIDRef?.observeSingleEvent(of: .value, with: { (dsUIDSnapshot) in
                    
                    var flats = Int()
                    flats = Int(dsUIDSnapshot.childrenCount.advanced(by: -1))
                    
                    dailyServiceUIDRef?.child(Constants.FIREBASE_STATUS).observeSingleEvent(of: .value, with: { (statusSnapshot) in
                        
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
                        
                        let dailyServicesData = NammaApartmentDailyServices(fullName: (fullName as! String), phoneNumber: phoneNumber as? String, profilePhoto: profilePhoto as? String, providedThings: ["":""], rating: rating as? Int, timeOfVisit: timeOfVisit as? String, uid: uid as? String, type: type as? String, numberOfFlat: flats, status: status)
                        let handedThingsRef = dailyServiceRef.child(Constants.FIREBASE_HANDEDTHINGS)
                        handedThingsRef.observeSingleEvent(of: .value, with: { (handedThingsSnapshot) in
                            
                            if handedThingsSnapshot.exists() {
                                let handedThingsMap = NSDictionary()
                                let handedThingsData = handedThingsSnapshot.value as? NSDictionary
                                for handedThing in handedThingsData! {
                                    handedThingsMap.setValue(handedThing.value, forKey: handedThing.key as! String)
                                    
                                }
                            }
                            
                            dailyServiceList.append(dailyServicesData)
                            if dailyServiceList.count == dsUIDList.count {
                                dailyserviceDictionary.updateValue(dailyServiceList as AnyObject, forKey: dsCategory)
                                callback(dailyserviceDictionary as NSDictionary)
                            }
                        })
                    })
                })
            }
        }
    }
    
    private func getAllDailyServiceUIDs(callback: @escaping (_ dailyServiceUIDDictiornary: NSDictionary) -> Void) {
        var dailyServiceUIDDictiornary = [String:AnyObject]()
        
        getDailyServicesCategories { (dailyServiceCategoriesList) in
            
            //User has not added any daily services yet, hence return an empty map
            if dailyServiceCategoriesList.isEmpty {
                callback(dailyServiceUIDDictiornary as NSDictionary)
            }
            
            for dailyServiceCategory in dailyServiceCategoriesList {
                
                self.getDailyServicesUIDs(dailyServiceCategories: dailyServiceCategory, callback: { (dailyServiceUIDList) in
                    self.count = self.count + 1
                    
                    dailyServiceUIDDictiornary.updateValue(dailyServiceUIDList as [String] as AnyObject, forKey: dailyServiceCategory)
                    //setValue(dailyServiceUIDList as [String], forKey: dailyServiceCategory)
                    
                    if self.count == dailyServiceCategoriesList.count {
                        self.count = 0
                        callback(dailyServiceUIDDictiornary as NSDictionary)
                    }
                })
            }
        }
    }
    
    private func getDailyServicesUIDs(dailyServiceCategories : String, callback: @escaping (_ dailyServiceUIDList: [String]) -> Void) {
        
        var dailyServiceUIDList = [String]()
        userDataRef?.child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(dailyServiceCategories).observeSingleEvent(of: .value, with: { (DSUIDSnapshot) in
            
            if DSUIDSnapshot.exists() {
                let dailyServicesUIDs = DSUIDSnapshot.value as! NSDictionary
                for dailyServiceType in dailyServicesUIDs.allKeys {
                    dailyServiceUIDList.append(dailyServiceType as! String)
                }
            }
            callback(dailyServiceUIDList)
        })
    }
    ///Returns a list of all categories of daily services added by user.
    ///
    ///Parameters callback: returns a callback containing list of categories
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
