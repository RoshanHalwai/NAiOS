//
//  HandedThingsToDailyServicesViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 13/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HandedThingsToDailyServicesViewController: NANavigationViewController, UITableViewDataSource, UITableViewDelegate {
    
    //variable taken to remove cell from list
    var selectedRow : Int?
    var currentTag: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    //set title from previous page
    var titleName =  String()
    
    //Database References
    var userDataRef : DatabaseReference?
    var dailyServiceInUserRef : DatabaseReference?
    var dailyServicePublicRef : DatabaseReference?
    var dailyServiceCountRef : DatabaseReference?
    var dailyServiceStatusRef : DatabaseReference?
    
    //Created Instance of Model Class To get data in card view
    var dailyServiceHandedThingsList = [NammaApartmentDailyServices]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling Handed Things TO Daily services Retrieving Function on Load
        retrieveHandedThingsDSFirebase()
        
        //Disable Table view cell selection & cell border line.
        tableView.allowsSelection = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.frame = CGRect(x: 0, y: 0, width: 34, height: 30)
        historyButton.addTarget(self, action: #selector(gotoHandedThingsServiceHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        //Creating info icon on Navigation bar
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "information24"), for: .normal)
        infoButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        let info = UIBarButtonItem(customView: infoButton)
        //created Array for history and info button icons
        self.navigationItem.setRightBarButtonItems([info,history], animated: true)
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
    }
    
    //to Navigate to Daily Services History VC
    @objc func gotoHandedThingsServiceHistoryVC() {
        let dv = NAViewPresenter().handedThingsServiceHistoryVC()
        dv.titleName = NAString().history()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyServiceHandedThingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HandedThingsToDailyServicesTableViewCell
        
        let DSList : NammaApartmentDailyServices
        DSList = dailyServiceHandedThingsList[indexPath.row]
        
        //assigning delegate method to textFiled
        cell.txt_Description.delegate = self
        
        cell.lbl_ServiceName.text = DSList.getfullName()
        cell.lbl_ServiceType.text = DSList.getType()
        cell.lbl_ServiceRating.text = "\(DSList.getrating())"
        cell.lbl_ServiceInTime.text = DSList.getStatus()
        cell.lbl_ServiceFlats.text = "\(DSList.getNumberOfFlats())"
        
        if let urlString = DSList.profilePhoto {
            NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.cellImage)
        }
        
        //assigning delegate method to textFiled
        cell.txt_Description.delegate = self
        
        //Label Formatting & setting
        cell.lbl_Name.font = NAFont().textFieldFont()
        cell.lbl_Type.font = NAFont().textFieldFont()
        cell.lbl_Rating.font = NAFont().textFieldFont()
        cell.lbl_InTime.font = NAFont().textFieldFont()
        cell.lbl_Flats.font = NAFont().textFieldFont()
        
        cell.lbl_ServiceName.font = NAFont().headerFont()
        cell.lbl_ServiceType.font = NAFont().headerFont()
        cell.lbl_ServiceRating.font = NAFont().headerFont()
        cell.lbl_ServiceInTime.font = NAFont().headerFont()
        cell.lbl_ServiceFlats.font = NAFont().headerFont()
        
        cell.lbl_ThingsGiven.font = NAFont().headerFont()
        cell.lbl_Description.font = NAFont().headerFont()
        
        //This creates the shadows and modifies the cards a little bit
        cell.backgroundCardView.backgroundColor = UIColor.white
        cell.contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        cell.backgroundCardView.layer.borderWidth = 1.0
        cell.backgroundCardView.layer.borderColor = UIColor.clear.cgColor
        cell.backgroundCardView.layer.cornerRadius = 8.0
        cell.backgroundCardView.layer.masksToBounds = false
        cell.backgroundCardView.layer.shadowColor = UIColor.gray.cgColor
        cell.backgroundCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.backgroundCardView.layer.shadowOpacity = 1
        
        //TextField Formatting & setting
        cell.txt_Description.font = NAFont().textFieldFont()
        
        //Button Formatting & Setting
        cell.btn_NotifyGate.setTitle(NAString().notify_gate(), for: .normal)
        cell.btn_NotifyGate.backgroundColor = NAColor().buttonBgColor()
        cell.btn_NotifyGate.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        cell.btn_NotifyGate.titleLabel?.font = NAFont().buttonFont()
        
        //Creating black bottom line
        cell.txt_Description.underlined()
        
        //image makes round
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.size.width/2
        cell.cellImage.clipsToBounds = true
        
        /*Dynamically Change Cell Height while selecting segment Controller
         by default which index is selected on view load*/
        cell.segmentSelect.tag = indexPath.row
        cell.segmentSelect.selectedSegmentIndex = 0
        
        if currentTag != nil && currentTag == indexPath.row  && selectedRow != cell.segmentSelect.selectedSegmentIndex {
            cell.segmentSelect.selectedSegmentIndex = 1
        }
        cell.segmentSelect.addTarget(self, action: #selector(selectSegment(sender:)), for: .valueChanged)
        
        //Storing Handed Things To My Daily Services in Firebase & Calling History Button for Navigating.
        cell.actionHistory = {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let currentDate = formatter.string(from: date)
            
            self.dailyServicePublicRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(DSList.getType()).child(DSList.getuid()).child(userUID).child(Constants.FIREBASE_HANDEDTHINGS)
            
            //Implemented Completion block,becouse need to show AlertView after storing data in Firebase.
            self.dailyServicePublicRef?.child(currentDate).setValue(cell.txt_Description.text, withCompletionBlock: { (error,ref) in
                if error == nil {
                    print("Success")
                    let alert = UIAlertController(title: NAString().notify_btnClick_Alert_title(), message: NAString().notify_btnClick_Alert_message(), preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: NAString().ok(), style: .default) { (_) in
                        let lv = NAViewPresenter().handedThingsServiceHistoryVC()
                        self.navigationController?.pushViewController(lv, animated: true)
                        lv.titleName = NAString().history()
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("Failure")
                }
            })
        }
        return cell
    }
    
    //Dynamically Change Cell Height while selecting segment Controller
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedRow == 1  && selectedRow != nil && currentTag != nil && currentTag == indexPath.row {
            return HandedThingsToDailyServicesTableViewCell.expandedHeight
        } else {
            return HandedThingsToDailyServicesTableViewCell.defaultHeight
        }
    }
    
    //Dynamically Change Cell Height while selecting segment Controller
    @objc func selectSegment(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedRow = 0
        } else {
            selectedRow = 1
        }
        currentTag = sender.tag
        self.tableView.reloadData()
    }
}

extension HandedThingsToDailyServicesViewController {
    
    //Created structure to Daily Service Type & NumberOfFlats.
    struct dailySericeTypeAndNumberOfFlat {
        var type: String
        var flat: Int
        var status: String
    }
    
    func retrieveHandedThingsDSFirebase() {
        
        var dsInfo: [dailySericeTypeAndNumberOfFlat] = []
        
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
                    var numberOfFlat = 0
                    var dsType = ""
                    var dsStatus = ""
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
                                            self.dailyServiceCountRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                                                numberOfFlat = Int((snapshot.childrenCount) - 1)
                                                dsType = dailyServiceType as! String
                                                dsStatus = dailyServiceStatus as! String
                                                
                                                if dsStatus == NAString().entered() {
                                                    
                                                    //After getting Number of Flat & Daily Service Type from Firebase, Here i'm appending data in structure
                                                    let servicetype = dailySericeTypeAndNumberOfFlat.init(type: dsType, flat: numberOfFlat, status: dsStatus)
                                                    dsInfo.append(servicetype)
                                                    
                                                    self.dailyServicePublicRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC)
                                                    self.dailyServicePublicRef?.child(dailyServiceType as! String).child(dailyServiceUID as! String).child(userUID).observeSingleEvent(of: .value, with: { (snapshot) in
                                                        
                                                        //Getting Data Form Firebase & Adding into Model Class
                                                        let dailyServiceData = snapshot.value as? [String: AnyObject]
                                                        
                                                        let fullName = dailyServiceData?[DailyServicesListFBKeys.fullName.key]
                                                        let phoneNumber = dailyServiceData?[DailyServicesListFBKeys.phoneNumber.key]
                                                        let profilePhoto = dailyServiceData?[DailyServicesListFBKeys.profilePhoto.key]
                                                        let providedThings = dailyServiceData?[DailyServicesListFBKeys.providedThings.key]
                                                        let rating = dailyServiceData?[DailyServicesListFBKeys.rating.key]
                                                        let timeOfVisit = dailyServiceData?[DailyServicesListFBKeys.timeOfVisit.key]
                                                        let uid = dailyServiceData?[DailyServicesListFBKeys.uid.key]
                                                        
                                                        if dsInfo.count > 0 {
                                                            let dailyServicesData = NammaApartmentDailyServices(fullName: fullName as! String?, phoneNumber: phoneNumber as! String?, profilePhoto: profilePhoto as! String?, providedThings: providedThings as! Bool?, rating: rating as! Int?, timeOfVisit: timeOfVisit as! String?, uid: uid as! String?, type: dsInfo[iterator].type as String?, numberOfFlat: dsInfo[iterator].flat as Int?, status: dsInfo[iterator].status as String?)
                                                            
                                                            self.dailyServiceHandedThingsList.append(dailyServicesData)
                                                            NAActivityIndicator.shared.hideActivityIndicator()
                                                            self.tableView.reloadData()
                                                            iterator = iterator + 1
                                                        } else {
                                                            NAActivityIndicator.shared.hideActivityIndicator()
                                                            NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailableHandedThings())
                                                        }
                                                    })
                                                    
                                                } else {
                                                    NAActivityIndicator.shared.hideActivityIndicator()
                                                    NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailableHandedThings())
                                                }
                                            })
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
