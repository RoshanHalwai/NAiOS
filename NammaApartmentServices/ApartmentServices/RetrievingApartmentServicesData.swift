//
//  RetrievingApartmentServicesData.swift
//  nammaApartment
//
//  Created by kirtan labs on 03/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RetrievingApartmentServicesData {
    var dailyServiceUID : String
    var dailyServiceType : String
    var rating = 0
    var count = 0
    var flatCount = 0
    
    init(dailyServiceUID: String, dailyServiceType: String) {
        self.dailyServiceUID = dailyServiceUID
        self.dailyServiceType = dailyServiceType
    }
    
    //Calculating average rating for particular daily service and getting Daily service data under first owner UID
    public func getDailyServicesDetails(callback: @escaping (_ dailyServiceData: NammaApartmentDailyServices) -> Void) {
        getDailyServiceOwnersUIDList { (ownersUIDList) in
            self.getOwnerData(ownerUID: ownersUIDList[0], callback: { (dailyServiceData) in
                if ownersUIDList.count != 1 {
                    for ownerUID in ownersUIDList {
                        self.getOwnerData(ownerUID: ownerUID, callback: { (dailyServiceData) in
                            self.rating = self.rating + dailyServiceData.getrating()
                            self.count = self.count + 1
                            
                            if self.count == ownersUIDList.count {
                                self.rating = self.rating/self.count
                                self.flatCount = ownersUIDList.count
                                dailyServiceData.setRating(rating: self.rating)
                                dailyServiceData.setFlats(flats: self.flatCount)
                                
                                callback(dailyServiceData)
                            }
                        })
                    }
                } else {
                    self.flatCount = 1
                    dailyServiceData.setFlats(flats: self.flatCount)
                    callback(dailyServiceData)
                }
            })
        }
    }
    
    //Getting Owners UID List
    private func getDailyServiceOwnersUIDList(callback: @escaping (_ ownersUIDList: [String]) -> Void) {
        
        var ownersUIDList = [String]()
        let dailyServiceDataRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dailyServiceType).child(dailyServiceUID)
        dailyServiceDataRef.observeSingleEvent(of: .value) { (ownerUIDSnapshot) in
            let serviceOwnersUID = ownerUIDSnapshot.value as? [String: Any]
            ownersUIDList = Array(serviceOwnersUID!.keys)
            let index = ownersUIDList.index(of : NAString().status())
            ownersUIDList.remove(at: index!)
            callback(ownersUIDList)
        }
    }
    
    //Getting owners Data based on service type and Daily service UID
    private func getOwnerData(ownerUID: String, callback: @escaping (_ dailyServiceData: NammaApartmentDailyServices) -> Void) {
        let dailyServiceDataRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dailyServiceType).child(dailyServiceUID).child(ownerUID)
        dailyServiceDataRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            let dailyServicesData = dataSnapshot.value as? [String: AnyObject]
            
            let fullName = dailyServicesData?[DailyServicesListFBKeys.fullName.key]
            let phoneNumber = dailyServicesData?[DailyServicesListFBKeys.phoneNumber.key]
            let profilePhoto = dailyServicesData?[DailyServicesListFBKeys.profilePhoto.key]
            let uid = dailyServicesData?[DailyServicesListFBKeys.uid.key]
            let rating = dailyServicesData?[DailyServicesListFBKeys.rating.key]
            
            let dailyServiceData = NammaApartmentDailyServices(fullName: (fullName as! String), phoneNumber: phoneNumber as? String, profilePhoto: profilePhoto as? String, providedThings: nil, rating: rating as? Int, timeOfVisit: nil, uid: (uid as! String), type: nil, numberOfFlat: self.flatCount, status: nil)
            
            callback(dailyServiceData)
        }
    }
}
