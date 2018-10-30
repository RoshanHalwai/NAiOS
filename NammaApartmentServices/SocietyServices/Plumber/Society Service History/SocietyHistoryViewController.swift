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
    var serviceTypeString = String()
    var NASocietyServiceData = [NASocietyServices]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Showing Activity Indicator
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        switch navigationTitle {
            
        case NAString().plumber().lowercased(): serviceTypeString = NAString().plumber()
            break
        case NAString().carpenter().lowercased(): serviceTypeString = NAString().carpenter()
            break
        case NAString().electrician().lowercased(): serviceTypeString = NAString().electrician()
            break
        case NAString().garbageCollection(): serviceTypeString = NAString().garbage_Collection()
            break
        case NAString().scrap_Collection(): serviceTypeString = NAString().scrapCollection()
            break
        default:
            break
        }
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        
        retrieveSocietyServiceHistoryData()
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 80)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    //MARK : CollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NASocietyServiceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! SocietyHistoryCollectionViewCell
        
        let societyServiceList : NASocietyServices
        societyServiceList = NASocietyServiceData[indexPath.row]
        
        let timeStamp = societyServiceList.getTimeStamp()
        let date = (NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000)))
        let dateString = String(describing: date)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = NAString().userProblemTimeStampFormat()
        let dateAndTime = dateFormatterGet.date(from: dateString)
        dateFormatterGet.dateFormat = NAString().convertedSocietyServiceTimeStampFormat()
        let userRequestTime = (dateFormatterGet.string(from: dateAndTime!))
        
        switch societyServiceList.getSocietyServiceType() {
        case NAString().plumber_Service() :
            cell.cellImage.image = #imageLiteral(resourceName: "plumber")
            break
        case NAString().carpenter_Service() :
            cell.cellImage.image = #imageLiteral(resourceName: "carpenter")
            break
        case NAString().electrician_Service() :
            cell.cellImage.image = #imageLiteral(resourceName: "electrician")
            break
        case NAString().garbageCollection() :
            cell.cellImage.image = #imageLiteral(resourceName: "garbage")
            break
        case NAString().scrap_Collection() :
            cell.cellImage.image = #imageLiteral(resourceName: "scrapCollection")
            break
        default:
            break
        }
        
        if societyServiceList.getStatus() == NAString().cancelled() {
            cell.checkMarkImage.image = #imageLiteral(resourceName: "Cancel")
        } else {
            cell.checkMarkImage.image = #imageLiteral(resourceName: "checked")
        }
        
        cell.lbl_Problem.text = societyServiceList.getProblem()
        cell.lbl_Date.text = userRequestTime
        
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
                        
                        var notificationUIDArray = [String]()
                        //Getting all Notification UID's in Empty Array
                        notificationUIDArray = notificationsUID.allKeys as! [String]
                        //sorting UID's
                        let sortedArray = notificationUIDArray.sorted()
                        //Reversing the Array order to make sure that Latest Request Data should be on the top in the List
                        let reversedArray = sortedArray.reversed()
                        var count = 0
                        for notifictionUID in reversedArray {
                            
                            let societyServiceNotificationRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL
                                .child(notifictionUID)
                            
                            societyServiceNotificationRef.observeSingleEvent(of: .value) { (snapshot) in
                                count = count + 1
                                let societyServiceData = snapshot.value as? [String: AnyObject]
                                
                                if (self.navigationTitle == NAString().scrap_Collection()) {
                                    let societyServiceScrapType: String = societyServiceData?[NASocietyServicesFBKeys.scrapType.key] as! String
                                    let societyServiceTimeStamp = (societyServiceData?[Constants.FIREBASE_CHILD_TIMESTAMP])
                                    let societyServiceType = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
                                    
                                    let societyServiceDataList = NASocietyServices(problem: societyServiceScrapType, timeSlot: "", userUID: "", societyServiceType: societyServiceType, notificationUID: "", status: "", takenBy: "", endOTP: "", fullName: "", mobileNumber: "", timeStamp:societyServiceTimeStamp as! Int)
                                    self.NASocietyServiceData.append(societyServiceDataList)
                                    
                                } else {
                                    let status = societyServiceData?[NASocietyServicesFBKeys.status.key] as? String
                                    if status == NAString().complete() || status == NAString().cancelled() {
                                        
                                        let societyServiceProblem = societyServiceData?[NASocietyServicesFBKeys.problem.key] as! String
                                        let societyServiceStatus: String = societyServiceData?[NASocietyServicesFBKeys.status.key] as! String
                                        let societyServiceTimeStamp = societyServiceData?[Constants.FIREBASE_CHILD_TIMESTAMP]
                                        let societyServiceType: String = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
                                        
                                        let societyServiceDataList = NASocietyServices(problem: societyServiceProblem, timeSlot: "", userUID: userUID, societyServiceType: societyServiceType, notificationUID: notifictionUID, status: societyServiceStatus, takenBy: "", endOTP: "", fullName: "", mobileNumber: "", timeStamp: societyServiceTimeStamp as! Int)
                                        self.NASocietyServiceData.append(societyServiceDataList)
                                    }
                                }
                                
                                if count == reversedArray.count {
                                    NAActivityIndicator.shared.hideActivityIndicator()
                                    if self.NASocietyServiceData.count == 0 {
                                        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable(serviceName: self.serviceTypeString.capitalized))
                                    } else {
                                         self.collectionView.reloadData()
                                    }
                                }
                            }
                        }
                    } else {
                        NAActivityIndicator.shared.hideActivityIndicator()
                        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable(serviceName: self.serviceTypeString.capitalized))
                    }
                })
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().societyServiceNotAvailable(serviceName: self.serviceTypeString.capitalized))
            }
        }
    }
}
