//
//  SocietyHistoryViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/3/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SocietyHistoryViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //set title from previous page
    var titleName =  String()
    var navigationTitle = String()
    var NASocietyServiceData = [NASocietyServices]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Showing Activity Indicator
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        retrieveSocietyServiceHistoryData()
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
    }
    
    //MARK : CollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NASocietyServiceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! SocietyHistoryCollectionViewCell
        
        let societyServiceList : NASocietyServices
        societyServiceList = NASocietyServiceData[indexPath.row]
        
        cell.lbl_ServiceName.text = societyServiceList.getFullName()
        cell.lbl_ServiceNumber.text = societyServiceList.getMobileNumber()
        cell.lbl_ServiceProblem.text = societyServiceList.getProblem()
        cell.lbl_ServiceSlotTime.text = societyServiceList.getTimeSlot()
        
        //assigning font & style to cell labels
        cell.lbl_Name.font = NAFont().headerFont()
        cell.lbl_Number.font = NAFont().headerFont()
        cell.lbl_Problem.font = NAFont().headerFont()
        cell.lbl_SlotTime.font = NAFont().headerFont()
        cell.lbl_ServiceName.font = NAFont().textFieldFont()
        cell.lbl_ServiceNumber.font = NAFont().textFieldFont()
        cell.lbl_ServiceProblem.font = NAFont().textFieldFont()
        cell.lbl_ServiceSlotTime.font = NAFont().textFieldFont()
        
        //cardUIView
        cell.cardView?.layer.cornerRadius = 3
        cell.cardView?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cell.cardView?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cell.cardView?.layer.shadowRadius = 1.7
        cell.cardView?.layer.shadowOpacity = 0.45
        
        return cell
    }
    
    //Retrieving Society Service Data in History Screen
    func retrieveSocietyServiceHistoryData() {
        let userDataRef = GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
        
        userDataRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                
                userDataRef.child(self.navigationTitle).observeSingleEvent(of: .value, with: { (UIDSnapshot) in
                    
                    if UIDSnapshot.exists() {
                        let notificationsUID = UIDSnapshot.value as! NSDictionary
                        for notifictionUID in notificationsUID.allKeys {
                            
                            let societyServiceNotificationRef = Database.database().reference()
                                .child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
                                .child(Constants.FIREBASE_USER_CHILD_ALL)
                                .child(notifictionUID as! String)
                            
                            societyServiceNotificationRef.observeSingleEvent(of: .value) { (snapshot) in
                                let societyServiceData = snapshot.value as? [String: AnyObject]
                                
                                //Checking whether Service Person Accepted the User Request or not
                                if (societyServiceData?[NASocietyServicesFBKeys.takenBy.key] != nil &&
                                    societyServiceData?[NASocietyServicesFBKeys.endOTP.key] != nil) {
                                    let societyServiceUID: String = societyServiceData?[NASocietyServicesFBKeys.takenBy.key] as! String
                                    let societyServiceType: String = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
                                    let societyServiceProblem: String = societyServiceData?[NASocietyServicesFBKeys.problem.key] as! String
                                    let societyServiceTimeSlot: String = societyServiceData?[NASocietyServicesFBKeys.timeSlot.key] as! String
                                    let societyServiceStatus: String = societyServiceData?[NASocietyServicesFBKeys.status.key] as! String
                                    let societyServiceEndOTP: String = societyServiceData?[NASocietyServicesFBKeys.endOTP.key] as! String
                                    
                                    let societyServiceDataRef = Database.database().reference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICE)
                                        .child(societyServiceType)
                                        .child(Constants.FIREBASE_USER_CHILD_PRIVATE)
                                        .child(Constants.FIREBASE_CHILD_DATA)
                                        .child(societyServiceUID)
                                    
                                    //Getting Service Person Name and Mobile Number
                                    societyServiceDataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                                        
                                        let serviceData = snapshot.value as? [String: AnyObject]
                                        let societyServiceName: String = serviceData?[NASocietyServicesFBKeys.fullName.key] as! String
                                        let societyServiceNumber: String = serviceData?[NASocietyServicesFBKeys.mobileNumber.key] as! String
                                        
                                        let societyServiceDataList = NASocietyServices(problem: societyServiceProblem, timeSlot: societyServiceTimeSlot, userUID: userUID, societyServiceType: societyServiceType, notificationUID: notifictionUID as! String, status: societyServiceUID, takenBy: societyServiceStatus, endOTP: societyServiceEndOTP, fullName: societyServiceName, mobileNumber: societyServiceNumber)
                                        self.NASocietyServiceData.append(societyServiceDataList)
                                        NAActivityIndicator.shared.hideActivityIndicator()
                                        self.collectionView.reloadData()
                                    })
                                }
                            }
                        }
                    } else {
                        NAActivityIndicator.shared.hideActivityIndicator()
                        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable())
                    }
                })
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable())
            }
        }
    }
}
