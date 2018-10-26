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
    var layoutObj = NAFirebase()
    
    //Created Instance of Model Class To get data in card view
    var dailyServiceHistoryList = [NammaApartmentDailyServices]()
    
    //Database References
    var userDataRef : DatabaseReference?
    var dailyServiceInUserRef : DatabaseReference?
    var dailyServicePublicRef : DatabaseReference?
    var dailyServiceHandedThingsRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading Retrieving History function on Load
        retrieveHandedThingsdailyServiceHistory()
        
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
        let DSHandedList : NammaApartmentDailyServices
        DSHandedList = dailyServiceHistoryList[indexPath.row]
        
        //Changing Date Format here & showing in Card View.
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        let showDate = inputFormatter.date(from: DSHandedList.getDateOfHandedThings())
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
        cell.lbl_Things_Detail.text = DSHandedList.getprovidedThings()
        cell.lbl_Name_Detail.text = DSHandedList.getfullName()
        
        //Retrieving Image & Showing Activity Indicator on top of image with the help of 'SDWebImage Pod'
        cell.image_View.sd_setShowActivityIndicatorView(true)
        cell.image_View.sd_setIndicatorStyle(.gray)
        cell.image_View.sd_setImage(with: URL(string: DSHandedList.profilePhoto!), completed: nil)
        
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
    
    /* - Check if the flat has any daily service. If it does not have any daily services added we show daily service unavailable message.
     - Else, we display the daily services who got things handed by the user.*/
    func retrieveHandedThingsdailyServiceHistory() {
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        let retrieveDailyList : RetrievingDailyServicesList
        retrieveDailyList = RetrievingDailyServicesList.init(pastDailyServicesListRequired: false)
        retrieveDailyList.getAllDailyServices { (userDailyServivcesList) in
            
            if userDailyServivcesList.isEmpty {
                NAActivityIndicator.shared.hideActivityIndicator()
                self.layoutObj.layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailableHandedThings())
            } else {
                var count = 0
                for dailyServiceData in userDailyServivcesList {
                    count = count + 1
                    
                    if !(dailyServiceData.getprovidedThings().isEmpty) {
                        self.dailyServiceHistoryList.append(dailyServiceData)
                        NAActivityIndicator.shared.hideActivityIndicator()
                        self.collectionView.reloadData()
                    }
                    
                    if count == userDailyServivcesList.count && self.dailyServiceHistoryList.isEmpty {
                        NAActivityIndicator.shared.hideActivityIndicator()
                        self.layoutObj.layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailableHandedThings())
                    }
                }
            }
        }
    }
}
