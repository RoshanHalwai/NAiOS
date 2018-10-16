//
//  HandedThingsToDailyServicesViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 13/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class HandedThingsToDailyServicesViewController: NANavigationViewController, UITableViewDataSource, UITableViewDelegate {
    
    //variable taken to remove cell from list
    var selectedRow : Int?
    var currentTag: Int?
    
    @IBOutlet weak var tableView: UITableView!
    var dailyServiceKey = String()
    
    //set title from previous page
    var titleName =  String()
    var layoutObj = NAFirebase()
    
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
        
        //TableView cell move up automatically, If keyboard will appaer
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Calling Handed Things TO Daily services Retrieving Function on Load
        checkAndRetrieveDailyService()
        
        //Disable Table view cell selection & cell border line.
        tableView.allowsSelection = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.addTarget(self, action: #selector(gotoHandedThingsServiceHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        //Creating info icon on Navigation bar
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "infoButton"), for: .normal)
        infoButton.addTarget(self, action: #selector(gotofrequentlyAskedQuestionsVC), for: .touchUpInside)
        let info = UIBarButtonItem(customView: infoButton)
        //created Array for history and info button icons
        self.navigationItem.setRightBarButtonItems([info,history], animated: true)
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
    }
    
    // Navigate to FAQ's WebSite
    @objc override func gotofrequentlyAskedQuestionsVC() {
        UIApplication.shared.open(URL(string: NAString().faqWebsiteLink())!, options: [:], completionHandler: nil)
    }
    
    //TableView cell move up automatically, If when keyboard will appaer
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
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
        
        //Implementing switch case to get daily services type in proper format
        //TODO: Need to refactore & Use this swicth case from global function
        switch DSList.getType() {
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
        
        //assigning delegate method to textFiled
        cell.txt_Description.delegate = self
        
        cell.lbl_ServiceName.text = DSList.getfullName()
        cell.lbl_ServiceType.text = dailyServiceKey
        cell.lbl_ServiceRating.text = "\(DSList.getrating())"
        cell.lbl_ServiceInTime.text = DSList.gettimeOfVisit()
        cell.lbl_ServiceFlats.text = "\(DSList.getNumberOfFlats())"
        
        //Retrieving Image & Showing Activity Indicator on top of image with the help of 'SDWebImage Pod'
        cell.cellImage.sd_setShowActivityIndicatorView(true)
        cell.cellImage.sd_setIndicatorStyle(.gray)
        cell.cellImage.sd_setImage(with: URL(string: DSList.getprofilePhoto()!), completed: nil)
        
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
        
        //assigning title to cell Labels
        cell.lbl_Name.text = NAString().name()
        cell.lbl_Type.text = NAString().type()
        cell.lbl_Rating.text = NAString().rating()
        cell.lbl_InTime.text = NAString().pick_time()
        cell.lbl_Flats.text = NAString().flats()
        
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
            
            self.dailyServicePublicRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(DSList.getType()).child(DSList.getuid()).child(userUID).child(Constants.FIREBASE_HANDEDTHINGS)
            
            //Implemented Completion block,becouse need to show AlertView after storing data in Firebase.
            self.dailyServicePublicRef?.child(currentDate).setValue(cell.txt_Description.text, withCompletionBlock: { (error,ref) in
                if error == nil {
                    print("Success")
                    let alert = UIAlertController(title: NAString().notify_btnClick_Alert_title(), message: NAString().notify_btnClick_Alert_message(), preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: NAString().ok(), style: .default) { (_) in
                        let lv = NAViewPresenter().handedThingsServiceHistoryVC()
                        lv.titleName = NAString().history()
                        self.navigationController?.pushViewController(lv, animated: true)
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
    
    //Resizing Cell when Coming Back from History Screen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedRow = 0
        currentTag = 0
        tableView.reloadData()
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
    
    func checkAndRetrieveDailyService() {
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        let retrieveDailyList : RetrievingDailyServicesList
        retrieveDailyList = RetrievingDailyServicesList.init(userUID: userUID)
        retrieveDailyList.getAllDailyServices { (userDailyServivcesList) in
            if userDailyServivcesList.isEmpty {
                NAActivityIndicator.shared.hideActivityIndicator()
                self.layoutObj.layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
            } else {
                var count = 0
                for dailyServiceData in userDailyServivcesList {
                    count = count + 1
                    if dailyServiceData.getStatus() == NAString().entered() {
                        
                        self.dailyServiceHandedThingsList.append(dailyServiceData)
                        NAActivityIndicator.shared.hideActivityIndicator()
                        
                        self.tableView.reloadData()
                    } else if count == userDailyServivcesList.count{
                        NAActivityIndicator.shared.hideActivityIndicator()
                        
                        self.layoutObj.layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
                    }
                }
            }
        }
    }
}
