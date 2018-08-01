//
//  HandedThingsDailyServicesHistoryViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 13/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HandedThingsDailyServicesHistoryViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    //set title from previous page
    var titleName =  String()
    
    //Created Instance of Model Class To get data in card view
    var dailyServiceHistoryList = [NADailyServiceHandedThingsHistory]()
    
    //Database References
    var userDataRef : DatabaseReference?
    var dailyServiceInUserRef : DatabaseReference?
    var dailyServicePublicRef : DatabaseReference?
    var dailyServiceCountRef : DatabaseReference?
    var dailyServiceStatusRef : DatabaseReference?
    var dailyServiceHandedThingsRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading Retrieving History function on Load
        retrieveDailyServiceHandedThingsHistory()
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyServiceHistoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HandedThingsDailyServicesHistoryCollectionViewCell
        
        //Assigning values in Card View For DSHandedThingHistory
        let DSHandedList : NADailyServiceHandedThingsHistory
        DSHandedList = dailyServiceHistoryList[indexPath.row]
        
        cell.lbl_Date_Detail.text = DSHandedList.getDateOfVisit()
        cell.lbl_InTime_Detail.text = DSHandedList.gettimeOfVisit()
        cell.lbl_Type_Detail.text = DSHandedList.getType()
        cell.lbl_Things_Detail.text = DSHandedList.getHandedThings()
        cell.lbl_Name_Detail.text = DSHandedList.getfullName()
        
        if let urlString = DSHandedList.profilePhoto {
            NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.image_View)
        }
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        //assigning font & style to cell labels
        cell.lbl_Name_Type.font = NAFont().textFieldFont()
        cell.lbl_Date_Type.font = NAFont().textFieldFont()
        cell.lbl_InTime_Type.font = NAFont().textFieldFont()
        cell.lbl_Type.font = NAFont().textFieldFont()
        cell.lbl_Things_Type.font = NAFont().textFieldFont()
        
        cell.lbl_Name_Detail.font = NAFont().headerFont()
        cell.lbl_Date_Detail.font = NAFont().headerFont()
        cell.lbl_InTime_Detail.font = NAFont().headerFont()
        cell.lbl_Type_Detail.font = NAFont().headerFont()
        cell.lbl_Things_Detail.font = NAFont().headerFont()
        
        //setting image round
        cell.image_View.layer.cornerRadius = cell.image_View.frame.size.width/2
        cell.image_View.clipsToBounds = true
        return cell
    }
}

extension HandedThingsDailyServicesHistoryViewController {
    
    //Created structure to Daily Service Type & NumberOfFlats.
    struct dailySericeTypeAndStatus {
        var type: String
        var status: String
        var dateOfVisit: String
        var handedThings: String
    }
    
    func retrieveDailyServiceHandedThingsHistory() {
        
        var dsInfo: [dailySericeTypeAndStatus] = []
        
        //To check that Any daily service is available or not inside user's flat
        userDataRef =  GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_DAILY_SERVICES)
        
        //To Daily Service UID in dailyServive child -> Public
        userDataRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (!(snapshot.exists())) {
                NAActivityIndicator.shared.hideActivityIndicator()
                
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
            } else {
                self.dailyServiceInUserRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES)
                self.dailyServiceInUserRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    //Created this to get Number of flat & Daily Service Type From Firebase & to use iterator for getting Data.
                    var dsType = ""
                    var dsStatus = ""
                    var dsDateOfVisit = ""
                    var dsHandedThings = ""
                    var iterator = 0
                    
                    if snapshot.exists() {
                        NAActivityIndicator.shared.hideActivityIndicator()
                        
                        let dailyServiceTypes = snapshot.value as? NSDictionary
                        
                        //Used OperationQueue thread to add data in a priority level
                        let queue = OperationQueue()
                        
                        for dailyServiceType in (dailyServiceTypes?.allKeys)! {
                            self.dailyServiceInUserRef?.child(dailyServiceType as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                
                                //Getting Daily Services UID here
                                let dailyServicesUID = snapshot.value as? NSDictionary
                                for dailyServiceUID in (dailyServicesUID?.allKeys)! {
                                    self.dailyServiceCountRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(dailyServiceType as! String).child(dailyServiceUID as! String)
                                    
                                    //Getting Daily Services Status (Like Entered or Not)
                                    self.dailyServiceStatusRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(dailyServiceType as! String).child(dailyServiceUID as! String).child(NAString().status())
                                    
                                    self.dailyServiceStatusRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                                        let dailyServiceStatus = snapshot.value
                                        
                                        queue.addOperation {
                                            
                                            dsType = dailyServiceType as! String
                                            dsStatus = dailyServiceStatus as! String
                                            
                                            if dsStatus == NAString().entered() {
                                                
                                                self.dailyServiceHandedThingsRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(dailyServiceType as! String).child(dailyServiceUID as! String).child(userUID).child(Constants.FIREBASE_HANDEDTHINGS)
                                                
                                                self.dailyServiceHandedThingsRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                                                    
                                                    //Getting Daily Services Date here
                                                    let dailyServicesDate = snapshot.value
                                                    for dailyServiceDate in ((dailyServicesDate as AnyObject).allKeys)! {
                                                        print(dailyServiceDate as Any)
                                                        //TODO: Need to change Date Format here.
                                                        dsDateOfVisit = dailyServiceDate as! String
                                                    }
                                                    
                                                    //Getting Daily Services HandedThings here
                                                    let dailyServicesHandedThings = snapshot.value
                                                    for dailyServiceHandedThings in ((dailyServicesHandedThings as AnyObject).allValues)! {
                                                        
                                                        dsHandedThings = dailyServiceHandedThings as! String
                                                    }
                                                    
                                                    //After getting Number of Flat & Daily Service Type from Firebase, Here i'm appending data in structure
                                                    let servicetype = dailySericeTypeAndStatus.init(type: dsType, status: dsStatus, dateOfVisit: dsDateOfVisit, handedThings: dsHandedThings)
                                                    dsInfo.append(servicetype)
                                                    
                                                    self.dailyServicePublicRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC)
                                                    self.dailyServicePublicRef?.child(dailyServiceType as! String).child(dailyServiceUID as! String).child(userUID).observeSingleEvent(of: .value, with: { (snapshot) in
                                                        
                                                        //Getting Data Form Firebase & Adding into Model Class
                                                        let dailyServiceData = snapshot.value as? [String: AnyObject]
                                                        
                                                        let fullName = dailyServiceData?[DailyServicesListFBKeys.fullName.key]
                                                        let profilePhoto = dailyServiceData?[DailyServicesListFBKeys.profilePhoto.key]
                                                        let timeOfVisit = dailyServiceData?[DailyServicesListFBKeys.timeOfVisit.key]
                                                        let uid = dailyServiceData?[DailyServicesListFBKeys.uid.key]
                                                        
                                                        if dsInfo.count > 0 {
                                                            let handedThingsData = NADailyServiceHandedThingsHistory(fullName: (fullName as! String?)!, profilePhoto: (profilePhoto as! String?)!, timeOfVisit: (timeOfVisit as! String?)!, uid: uid as? String, dateOfVisit: dsInfo[iterator].dateOfVisit as String?, type: dsInfo[iterator].type as String?, handedThings: dsInfo[iterator].handedThings as String?, status: dsInfo[iterator].status as String?)
                                                            
                                                            self.dailyServiceHistoryList.append(handedThingsData)
                                                            
                                                            NAActivityIndicator.shared.hideActivityIndicator()
                                                            self.collectionView.reloadData()
                                                            iterator = iterator + 1
                                                        }
                                                    })
                                                })
                                            } else {
                                                //TODO: Need to work on it in next pull request.
                                                //  NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
                                            }
                                        }
                                        queue.waitUntilAllOperationsAreFinished()
                                    })
                                }
                            })
                        }
                    }
                })
            }
        })
    }
}

