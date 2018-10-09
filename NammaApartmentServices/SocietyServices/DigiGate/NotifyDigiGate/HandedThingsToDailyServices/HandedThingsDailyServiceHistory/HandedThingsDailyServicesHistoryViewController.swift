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
    
    var dailyServiceKey = String()
    
    //Created Instance of Model Class To get data in card view
    var dailyServiceHistoryList = [NADailyServiceHandedThingsHistory]()
    
    //Database References
    var userDataRef : DatabaseReference?
    var dailyServiceInUserRef : DatabaseReference?
    var dailyServicePublicRef : DatabaseReference?
    var dailyServiceHandedThingsRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading Retrieving History function on Load
        retrieveDailyServiceHandedThingsHistory()
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 150)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
        
        //Here Adding Observer Value Using NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.imageHandle(notification:)), name: Notification.Name("CallBack"), object: nil)
    }
    
    //Create image Handle  Function
    @objc func imageHandle(notification: Notification) {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates(nil, completion: nil)
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyServiceHistoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HandedThingsDailyServicesHistoryCollectionViewCell
        
        //Assigning values in Card View For DSHandedThingHistory
        let DSHandedList : NADailyServiceHandedThingsHistory
        DSHandedList = dailyServiceHistoryList[indexPath.row]
        
        //Changing Date Format here & showing in Card View.
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        let showDate = inputFormatter.date(from: DSHandedList.getDateOfVisit())
        inputFormatter.dateFormat = "MMM dd,yyyy"
        let newDateOfVisit = inputFormatter.string(from: showDate!)
        
        //Implementing switch case to get daily services type in proper format
        //TODO: Need to refactore & Use this swicth case from global function
        switch DSHandedList.getType() {
        case Constants.FIREBASE_DSTYPE_COOKS:
            dailyServiceKey = NAString().cook()
            break
        case Constants.FIREBASE_DSTYPE_MAIDS:
            dailyServiceKey = NAString().maid()
            break
        case Constants.FIREBASE_DSTYPE_CARBIKE_CLEANER:
            dailyServiceKey = NAString().car_bike_cleaning()
        case Constants.FIREBASE_DSTYPE_CHILDDAY_CARE:
            dailyServiceKey = NAString().child_day_care()
            break
        case Constants.FIREBASE_DSTYPE_DAILY_NEWSPAPER:
            dailyServiceKey = NAString().daily_newspaper()
            break
        case Constants.FIREBASE_DSTYPE_MILKMEN:
            dailyServiceKey = NAString().milk_man()
            break
        case  Constants.FIREBASE_DSTYPE_LAUNDRIES:
            dailyServiceKey = NAString().laundry()
            break
        case Constants.FIREBASE_DSTYPE_DRIVERS:
            dailyServiceKey = NAString().driver()
            break
        default:
            break
        }
        
        cell.lbl_Date_Detail.text = newDateOfVisit
        cell.lbl_InTime_Detail.text = DSHandedList.gettimeOfVisit()
        cell.lbl_Type_Detail.text = dailyServiceKey
        cell.lbl_Things_Detail.text = DSHandedList.getHandedThings()
        cell.lbl_Name_Detail.text = DSHandedList.getfullName()
        let queue = OperationQueue()
        
        queue.addOperation {
            if let urlString = DSHandedList.profilePhoto {
                NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.image_View)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    cell.activityIndicator.isHidden = true
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        
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
        
        //assigning title to cell Labels
        cell.lbl_Name_Type.text = NAString().name()
        cell.lbl_Date_Type.text = NAString().date()
        cell.lbl_InTime_Type.text = NAString().pick_time()
        cell.lbl_Type.text = NAString().type()
        cell.lbl_Things_Type.text = NAString().things()
        
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
        
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
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
                    let dsStatus = ""
                    var dsDateOfVisit = ""
                    var dsHandedThings = ""
                    var iterator = 0
                    var count = 0
                    var isHandedThingsAdded = false
                    
                    if snapshot.exists() {
                        
                        let dailyServiceTypes = snapshot.value as? NSDictionary
                        
                        //Used OperationQueue thread to add data in a priority level
                        let queue = OperationQueue()
                        
                        for dailyServiceType in (dailyServiceTypes?.allKeys)! {
                            self.dailyServiceInUserRef?.child(dailyServiceType as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                
                                //Getting Daily Services UID here
                                let dailyServicesUID = snapshot.value as? NSDictionary
                                for dailyServiceUID in (dailyServicesUID?.allKeys)! {
                                    count = count + 1
                                    queue.addOperation {
                                        dsType = dailyServiceType as! String
                                        
                                        self.dailyServiceHandedThingsRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dailyServiceType as! String).child(dailyServiceUID as! String).child(userUID).child(Constants.FIREBASE_HANDEDTHINGS)
                                        
                                        self.dailyServiceHandedThingsRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                                            if snapshot.exists() {
                                                isHandedThingsAdded = true
                                                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: "")
                                                //Getting Daily Services Given Date here
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
                                                //After getting Daily Service Type from Firebase, Here i'm appending data in structure
                                                let servicetype = dailySericeTypeAndStatus.init(type: dsType, status: dsStatus, dateOfVisit: dsDateOfVisit, handedThings: dsHandedThings)
                                                dsInfo.append(servicetype)
                                                
                                                self.dailyServicePublicRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC
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
                                            } else if (isHandedThingsAdded == false) {
                                                NAActivityIndicator.shared.hideActivityIndicator()
                                                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailableHandedThings())
                                            }
                                        })
                                    }
                                    queue.waitUntilAllOperationsAreFinished()
                                }
                            })
                        }
                    }
                })
            }
        })
    }
}

