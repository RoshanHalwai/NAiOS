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
    
    //Created Instance of Model Class To get data in card view
    var NAEventList = [NAEventManagement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Showing Activity Indicator
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        
        if navigationTitle == NAString().eventManagement() {
            retrieveEventManagement()
        } else {
            retrieveSocietyServiceHistoryData()
        }
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: height/8)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    //MARK : CollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if navigationTitle == NAString().eventManagement() {
            return NAEventList.count
        }
        return NASocietyServiceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! SocietyHistoryCollectionViewCell
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, HH:mm"
        let currentDate = formatter.string(from: date)
        
        if navigationTitle == NAString().eventManagement() {
            let eventServiceList : NAEventManagement
            eventServiceList = NAEventList[indexPath.row]
            
            cell.cellImage.image = #imageLiteral(resourceName: "event")
           // cell.lbl_Problem.text = eventServiceList.getTimeSlot()
            cell.lbl_Date.text = currentDate
        } else {
            let societyServiceList : NASocietyServices
            societyServiceList = NASocietyServiceData[indexPath.row]
            
            switch societyServiceList.getSocietyServiceType() {
            case NAString().plumber_Service() :
                cell.cellImage.image = #imageLiteral(resourceName: "plumbing (1)")
                break
            case NAString().carpenter_Service() :
                cell.cellImage.image = #imageLiteral(resourceName: "Carpenter Service")
                break
            case NAString().electrician_Service() :
                cell.cellImage.image = #imageLiteral(resourceName: "electrician")
                break
            case NAString().garbageCollection() :
                cell.cellImage.image = #imageLiteral(resourceName: "garbage-bin")
                break
            default:
                break
            }
            
            cell.lbl_Problem.text = societyServiceList.getProblem()
            cell.lbl_Date.text = currentDate
        }
        
        //Setting fonts for labels.
        cell.lbl_Problem.font = NAFont().headerFont()
        cell.lbl_Date.font = NAFont().headerFont()
        
        NAShadowEffect().shadowEffect(Cell: cell)
        return cell
    }
    
    //Retrieving Society Service Data in History Screen
    func retrieveSocietyServiceHistoryData() {
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
        
        userDataRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                
                userDataRef.child(self.navigationTitle).observeSingleEvent(of: .value, with: { (UIDSnapshot) in
                    
                    if UIDSnapshot.exists() {
                        let notificationsUID = UIDSnapshot.value as! NSDictionary
                        for notifictionUID in notificationsUID.allKeys {
                            
                            let societyServiceNotificationRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL
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
                                    
                                    let societyServiceDataRef = Constants.FIREBASE_SOCIETY_SERVICES
                                        .child(societyServiceType)
                                        .child(Constants.FIREBASE_CHILD_PRIVATE)
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
                        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable(serviceName: self.navigationTitle.capitalized))
                    }
                })
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable(serviceName: self.navigationTitle.capitalized))
            }
        }
    }
}

extension SocietyHistoryViewController {
    
    func retrieveEventManagement() {
        
        var eventManagementUIDRef : DatabaseReference?
        var societyServiceNotificationsRef : DatabaseReference?
        
        eventManagementUIDRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(Constants.FIREBASE_CHILD_EVENT_MANAGEMENT)
        
        eventManagementUIDRef?.observeSingleEvent(of: .value, with: { (eventUIDSnapShot) in
            
            if eventUIDSnapShot.exists() {
                //Getting Event Management UIDs here
                let eventUIDs = eventUIDSnapShot.value as? NSDictionary
                for eventUID in (eventUIDs?.allKeys)! {
                    
                    societyServiceNotificationsRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL.child(eventUID as! String)
                    
                    societyServiceNotificationsRef?.observeSingleEvent(of: .value, with: { (eventDataSnapshot) in
                        
                        //Getting all the event management data & storing in model class
                        let eventManagementData = eventDataSnapshot.value as? [String: AnyObject]
                        
                        let eventTitle : String = eventManagementData?[NAEventManagementFBKeys.eventTitle.key] as! String
                        print(eventTitle as Any)
                        let eventDate : String = eventManagementData?[NAEventManagementFBKeys.eventDate.key] as! String
                        let eventStatus : String = eventManagementData?[NAEventManagementFBKeys.status.key] as! String
                        let eventTimeSlot : String = eventManagementData?[NAEventManagementFBKeys.timeSlot.key] as! String
                        
//                        let eventManagementsData = NAEventManagement(title: eventTitle as String?, date: eventDate as String?, timeSlot: eventTimeSlot as String?, status: eventStatus as String?)
                        
                        //self.NAEventList.append(eventManagementData)
                        self.collectionView.reloadData()
                        NAActivityIndicator.shared.hideActivityIndicator()
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable(serviceName: self.navigationTitle.capitalized))
            }
        })
    }
}
