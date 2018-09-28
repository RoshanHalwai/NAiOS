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
    
    //Created Instance of Model Class To get data in card view
    var NAEventList = [NAEventManagement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Showing Activity Indicator
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        switch navigationTitle {
            
        case NAString().plumber().lowercased(): serviceTypeString = NAString().plumber()
            
        case NAString().carpenter().lowercased(): serviceTypeString = NAString().carpenter()
            
        case NAString().electrician().lowercased(): serviceTypeString = NAString().electrician()
           
        case NAString().garbageCollection(): serviceTypeString = NAString().garbage_Collection()
            
        case NAString().scrap_Collection(): serviceTypeString = NAString().scrapCollection()
            
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
            
            let timeStamp = societyServiceList.getTimeStamp()
            let date = (NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000)))
            let dateString = String(describing: date)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = NAString().userProblemTimeStampFormat()
            let dateAndTime = dateFormatterGet.date(from: dateString)
            dateFormatterGet.dateFormat = NAString().convertedUserProblemTimeStampFormat()
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
            
            cell.lbl_Problem.text = societyServiceList.getProblem()
            cell.lbl_Date.text = userRequestTime
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
                                    let societyServiceProblem = societyServiceData?[NASocietyServicesFBKeys.problem.key] as! String
                                    let societyServiceTimeSlot: String = societyServiceData?[NASocietyServicesFBKeys.timeSlot.key] as! String
                                    let societyServiceStatus: String = societyServiceData?[NASocietyServicesFBKeys.status.key] as! String
                                    let societyServiceEndOTP: String = societyServiceData?[NASocietyServicesFBKeys.endOTP.key] as! String
                                    let societyServiceTimeStamp = societyServiceData?[NASocietyServicesFBKeys.timestamp.key]?.floatValue

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
                                        
                                        let societyServiceDataList = NASocietyServices(problem: societyServiceProblem, timeSlot: societyServiceTimeSlot, userUID: userUID, societyServiceType: societyServiceType, notificationUID: notifictionUID as! String, status: societyServiceStatus, takenBy:  societyServiceUID, endOTP: societyServiceEndOTP, fullName: societyServiceName, mobileNumber: societyServiceNumber, timeStamp:Int(societyServiceTimeStamp!))
                                        self.NASocietyServiceData.append(societyServiceDataList)
                                        NAActivityIndicator.shared.hideActivityIndicator()
                                        self.collectionView.reloadData()
                                    })
                                } else {
                                    let societyServiceScrapType: String = societyServiceData?[NASocietyServicesFBKeys.scrapType.key] as! String
                                    let societyServiceTimeStamp = (societyServiceData?[Constants.FIREBASE_CHILD_TIMESTAMP])
                                    let societyServiceType = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
                                    
                                    let societyServiceDataList = NASocietyServices(problem: societyServiceScrapType, timeSlot: "", userUID: "", societyServiceType: societyServiceType, notificationUID: "", status: "", takenBy: "", endOTP: "", fullName: "", mobileNumber: "", timeStamp:societyServiceTimeStamp as! Int)
                                    self.NASocietyServiceData.append(societyServiceDataList)
                                    NAActivityIndicator.shared.hideActivityIndicator()
                                    self.collectionView.reloadData()
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
