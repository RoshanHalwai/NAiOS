//
//  MyDailyViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI
import HCSStarRatingView

class MyDailyServicesViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource, MFMessageComposeViewControllerDelegate {
    
    /* - Floating button downside the list & Array of Action sheet items.
     - Created variable of DBReference for storing data & Daily services list FB Objects to fetch data from firebase.
     - Created date picker programtically.
     - A boolean variable to indicate if previous screen was Add My Daily Services Screen. */
    
    @IBOutlet weak var btn_AddMyDailyServices: UIButton!
    @IBOutlet weak var opacity_View: UIView!
    @IBOutlet weak var popUp_View: UIView!
    @IBOutlet weak var lbl_PickTime: UILabel!
    @IBOutlet weak var txt_PickTime: UITextField!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Reschedule: UIButton!
    
    //Created Instance of Model Class To get data in card view
    var NADailyServicesList = [NammaApartmentDailyServices]()
    
    var dailyService = [NAString().cook(), NAString().maid(), NAString().car_bike_cleaning(), NAString().child_day_care(),NAString().daily_newspaper(), NAString().milk_man(),NAString().laundry(),NAString().driver()]
    
    var dailyServiceKey = String()
    var dailyServiceType = String()
    
    let picker = UIDatePicker()
    
    var fromAddMyDailyServicesVC = false
    var dailyServiceRating : DailyServiceRatingView!
    var dailyServiceUID : NammaApartmentDailyServices!
    var index = Int()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Database References
    var userDataRef : DatabaseReference?
    var dailyServiceInUserRef : DatabaseReference?
    var dailyServicePublicRef : DatabaseReference?
    var dailyServiceCountRef : DatabaseReference?
    var dailyServiceStatusRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* - Calling DatePicker Funtion and function to retriev data from firebase.
         - Adding image on date TextField.
         - To show activity indicator before loading data from firebase.
         - Button & Navigation bar Formmating & setting.
         - Calling Daily services Retrieving Function on Load */
        
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        checkAndRetrieveDailyService()
        opacity_View.isHidden = true
        
        self.btn_AddMyDailyServices.setTitle(NAString().add_my_service().capitalized, for: .normal)
        self.btn_AddMyDailyServices.backgroundColor = NAColor().buttonBgColor()
        self.btn_AddMyDailyServices.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_AddMyDailyServices.titleLabel?.font = NAFont().buttonFont()
        
        super.ConfigureNavBarTitle(title: NAString().my_daily_services().capitalized)
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToDigiGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        //Here Adding Observer Value Using NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.imageHandle(notification:)), name: Notification.Name("CallBack"), object: nil)
        
        //info Button Action
        infoButton()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 200)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        opacity_View.isUserInteractionEnabled = true
        opacity_View.addGestureRecognizer(tap)
    }
    
    //Create image Handle  Function
    @objc func imageHandle(notification: Notification) {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates(nil, completion: nil)
            self.collectionView.reloadData()
        }
    }
    
    /* - For navigating back to My Digi Gate VC.
     - For creating action sheet to select my daily services. */
    
    @objc func goBackToDigiGate() {
        if fromAddMyDailyServicesVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-NAString().count_four()]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func floatingButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title:NAString().my_daily_services(), message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: dailyService[0], style: .default, handler: dailyServiceSelected)
        let action2 = UIAlertAction(title: dailyService[1], style: .default, handler: dailyServiceSelected)
        let action3 = UIAlertAction(title: dailyService[2], style: .default, handler: dailyServiceSelected)
        let action4 = UIAlertAction(title: dailyService[3], style: .default, handler: dailyServiceSelected)
        let action5 = UIAlertAction(title: dailyService[4], style: .default, handler: dailyServiceSelected)
        let action6 = UIAlertAction(title: dailyService[5], style: .default, handler: dailyServiceSelected)
        let action7 = UIAlertAction(title: dailyService[6], style: .default, handler: dailyServiceSelected)
        let action8 = UIAlertAction(title: dailyService[7], style: .default, handler: dailyServiceSelected)
        
        let cancel = UIAlertAction(title: NAString().cancel(), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        actionSheet.addAction(action5)
        actionSheet.addAction(action6)
        actionSheet.addAction(action7)
        actionSheet.addAction(action8)
        
        actionSheet.addAction(cancel)
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func dailyServiceSelected(alert: UIAlertAction!) {
        let lv = NAViewPresenter().addMySerivesVC()
        lv.dailyServiceType = alert.title!
        lv.navTitle =  NAString().add_my_service().capitalized
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NADailyServicesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyDailyServicesCollectionViewCell
        
        /* - Created constant variable to store all the firebase data in it.
         - Calling global function to get Profile Image from Firebase.
         - This creates the shadows and modifies the cards a little bit.
         - To display image in round shape & Labels Formatting & setting.
         - Calling button action & Delete particular cell from list. */
        
        let DSList : NammaApartmentDailyServices
        DSList = NADailyServicesList[indexPath.row]
        
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
        
        cell.lbl_MyDailyServiceName.text = DSList.getfullName()
        cell.lbl_MyDailyServiceType.text = dailyServiceKey
        cell.lbl_MyDailyServicesInTime.text = DSList.getStatus()
        cell.lbl_MyDailyServicesFlats.text = "\(DSList.getNumberOfFlats())"
        cell.lbl_MyDailyServicesRating.text = "\(DSList.rating!)"
        let queue = OperationQueue()
        
        queue.addOperation {
            if let urlString = DSList.profilePhoto {
                NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.myDailyServicesImage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    cell.activityIndicator.isHidden = true
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        
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
        
        cell.myDailyServicesImage.layer.cornerRadius = cell.myDailyServicesImage.frame.size.width/2
        cell.myDailyServicesImage.clipsToBounds = true
        
        cell.lbl_MyDailyServiceName.font = NAFont().headerFont()
        cell.lbl_MyDailyServiceType.font = NAFont().headerFont()
        cell.lbl_MyDailyServicesInTime.font = NAFont().headerFont()
        cell.lbl_MyDailyServicesFlats.font = NAFont().headerFont()
        cell.lbl_MyDailyServicesRating.font = NAFont().headerFont()
        
        cell.lbl_myDailytype.font = NAFont().textFieldFont()
        cell.lbl_myDailyTime.font = NAFont().textFieldFont()
        cell.lbl_myDailyFlats.font = NAFont().textFieldFont()
        cell.lbl_myDailyName.font = NAFont().textFieldFont()
        cell.lbl_myDailyRating.font = NAFont().textFieldFont()
        
        cell.lbl_Call.font = NAFont().cellButtonFont()
        cell.lbl_Edit.font = NAFont().cellButtonFont()
        cell.lbl_Remove.font = NAFont().cellButtonFont()
        cell.lbl_Message.font = NAFont().cellButtonFont()
        
        cell.lbl_Call.text = NAString().call()
        cell.lbl_Edit.text = NAString().edit()
        cell.lbl_Remove.text = NAString().remove()
        cell.lbl_Message.text = NAString().message()
        
        cell.lbl_myDailyName.text = NAString().name()
        cell.lbl_myDailytype.text = NAString().type()
        cell.lbl_myDailyFlats.text = NAString().flats()
        cell.lbl_myDailyTime.text = NAString().status().capitalized
        cell.lbl_myDailyRating.text = NAString().rating()
        
        cell.index = indexPath
        cell.delegate = self
        
        //Daily Services Card View Functionalities 1.Edit 2.Call 3.Message
        cell.actionEdit = {
            let dv = NAViewPresenter().rescheduleMyVisitorVC()
            cell.btn_Edit.tag = NAString().editButtonTagValue()
            dv.buttonTagValue = cell.btn_Edit.tag
            dv.hideDateFromDailyServicesVC = NAString().yes()
            dv.getTime = DSList.gettimeOfVisit()
            dv.getDailyServiceUID = DSList.getuid()
            dv.getDailyServiceType = DSList.getType()
            dv.providesPresentationContextTransitionStyle = true
            dv.definesPresentationContext = true
            dv.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            dv.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
            self.present(dv, animated: true, completion: nil)
        }
        
        cell.actionCall = {
            UIApplication.shared.open(NSURL(string: "tel://\(DSList.getphoneNumber())")! as URL, options: [:], completionHandler: nil)
        }
        
        cell.actionMessage = {
            MFMessageComposeViewController.canSendText()
            let messageSheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            messageSheet.recipients = [DSList.getphoneNumber()]
            messageSheet.body = ""
            self.present(messageSheet, animated: true, completion: nil)
        }
        
        cell.actionRate = {
            self.index = indexPath.row
            self.showRatingView()
        }
        return cell
    }
    
    //Message UI default function to dismiss UI after calling MessageUI.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /* - For datePicker & Format picker for date
     - Done button for toolbar. */
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_PickTime.inputAccessoryView = toolbar
        txt_PickTime.inputView = picker
        picker.datePickerMode = .time
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = NAString().timeFormat()
        let dateString = date.string(from: picker.date)
        txt_PickTime.text = dateString
        self.view.endEditing(true)
    }
    
    @IBAction func btn_Cancel_Action(_ sender: UIButton) {
        opacity_View.isHidden = true
        popUp_View.isHidden = true
    }
    
    @IBAction func btn_Reschedule_Action(_ sender: UIButton) {
        opacity_View.isHidden = true
        popUp_View.isHidden = true
    }
    
    //on Click of Submit Button
    @objc func storeRating() {
        
        let rating = self.dailyServiceRating.ratingValue
        var serviceRating = Double()
        serviceRating = Double(rating)
        
        self.opacity_View.isHidden = true
        self.dailyServiceRating.isHidden = true
        
        switch dailyServiceKey {
        case NAString().cook() :
            dailyServiceType = Constants.FIREBASE_DSTYPE_COOKS
            break
        case NAString().maid():
            dailyServiceType = Constants.FIREBASE_DSTYPE_MAIDS
            break
        case NAString().car_bike_cleaning():
            dailyServiceType = Constants.FIREBASE_DSTYPE_CARBIKE_CLEANER
            break
        case NAString().child_day_care():
            dailyServiceType = Constants.FIREBASE_DSTYPE_CHILDDAY_CARE
            break
        case NAString().daily_newspaper():
            dailyServiceType = Constants.FIREBASE_DSTYPE_DAILY_NEWSPAPER
            break
        case NAString().milk_man():
            dailyServiceType = Constants.FIREBASE_DSTYPE_MILKMEN
            break
        case  NAString().laundry():
            dailyServiceType = Constants.FIREBASE_DSTYPE_LAUNDRIES
            break
        case NAString().driver():
            dailyServiceType = Constants.FIREBASE_DSTYPE_DRIVERS
            break
        default:
            break
        }
        
        dailyServiceUID = NADailyServicesList[index]
        
        let dailyServiceRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dailyServiceType).child(dailyServiceUID.getuid()).child(userUID)
        dailyServiceRef.child(Constants.FIREBASE_CHILD_RATING).setValue(serviceRating)
        
        dailyServiceRef.observe(.value) { (snapshot) in
            self.NADailyServicesList.removeAll()
            self.checkAndRetrieveDailyService()
        }
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        opacity_View.isHidden = true
        dailyServiceRating.isHidden = true
    }
    
    //Creating Method for Rate View
    func showRatingView() {
        opacity_View.isHidden = false
        dailyServiceRating = DailyServiceRatingView(frame: CGRect(x: 0, y: 0, width: 280, height: 199))
        dailyServiceRating.center.x = self.view.bounds.width/2
        dailyServiceRating.center.y = self.view.bounds.height/2
        dailyServiceRating.btn_Submit.titleLabel?.font = NAFont().buttonFont()
        dailyServiceRating.btn_Submit.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        dailyServiceRating.btn_Submit.backgroundColor = NAColor().buttonBgColor()
        dailyServiceRating.layer.cornerRadius = 10
        dailyServiceRating.layer.masksToBounds = true
        dailyServiceRating.btn_Submit.addTarget(self, action: #selector(storeRating), for: .touchUpInside)
        
        //Customized Code for Star rating
        let starRatingView: HCSStarRatingView = HCSStarRatingView()
        starRatingView.maximumValue = 5
        starRatingView.minimumValue = 0
        starRatingView.value = 1
        starRatingView.tintColor = UIColor.yellow
        starRatingView.allowsHalfStars = false
        starRatingView.emptyStarImage = UIImage(named: "EmptyStar")?.withRenderingMode(.alwaysTemplate)
        starRatingView.filledStarImage = UIImage(named: "FullStar")?.withRenderingMode(.alwaysTemplate)
        starRatingView.center = self.view.center
        dailyServiceRating.view.addSubview(starRatingView)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dailyServiceRating)
    }
}

extension MyDailyServicesViewController : dataCollectionProtocolDailyService{
    func deleteData(indx: Int, cell: UICollectionViewCell) {
        
        /* - AlertView will Display while removing Card view.
         - Remove collection view cell item with animation at final state.*/
        
        let dailyService = NADailyServicesList[indx]
        
        self.dailyServiceInUserRef = GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_DAILY_SERVICES)
        
        let alert = UIAlertController(title: NAString().remove_myDailyService_alertView_Title(), message: NAString().remove_myDailyService_alertView_Message(), preferredStyle: .alert)
        
        let actionNO = UIAlertAction(title:NAString().no(), style: .cancel) { (action) in }
        let actionYES = UIAlertAction(title:NAString().yes(), style: .default) { (action) in
            
            self.NADailyServicesList.remove(at: indx)
            self.dailyServiceInUserRef?.child(dailyService.getType()).child(dailyService.getuid()).setValue(NAString().getfalse())
            
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
            
            Timer.scheduledTimer(timeInterval: 0.24, target: self, selector: #selector(self.reloadCollectionData), userInfo: nil, repeats: false)
        }
        alert.addAction(actionNO) //add No action on AlertView
        alert.addAction(actionYES) //add YES action on AlertView
        present(alert, animated: true, completion: nil)
    }
    
    @objc func reloadCollectionData() {
        collectionView.reloadData()
    }
}

extension MyDailyServicesViewController {
    
    //Created structure to Daily Service Type & NumberOfFlats.
    struct dailySericeTypeAndNumberOfFlat {
        var type: String
        var flat: Int
        var status: String
    }
    
    func retrieveDailyServicesFromFirebase(userUID : String) {
        
        var dsInfo: [dailySericeTypeAndNumberOfFlat] = []
        
        //To check that Any daily service is available or not inside user's flat
        userDataRef =  GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_DAILY_SERVICES)
        userDataRef?.keepSynced(true)
        //To Daily Service UID in dailyServive child -> Public
        userDataRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (!(snapshot.exists())) {
                NAActivityIndicator.shared.hideActivityIndicator()
                
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
            } else {
                self.dailyServiceInUserRef = GlobalUserData.shared.getUserDataReference()
                    .child(Constants.FIREBASE_CHILD_DAILY_SERVICES)
                self.dailyServiceInUserRef?.keepSynced(true)
                self.dailyServiceInUserRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    //Created this to get Number of flat & Daily Service Type From Firebase & to use iterator for getting Data.
                    var numberOfFlat = 0
                    var dsType = ""
                    var dsStatus = ""
                    var iterator = 0
                    
                    if snapshot.exists() {                        
                        let dailyServiceTypes = snapshot.value as? NSDictionary
                        
                        //Used OperationQueue thread to add data in a priority level
                        let queue = OperationQueue()
                        
                        for dailyServiceType in (dailyServiceTypes?.allKeys)! {
                            self.dailyServiceInUserRef?.child(dailyServiceType as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                
                                //Getting Daily Services UID here
                                let dailyServicesUID = snapshot.value as? NSDictionary
                                for dailyServiceUID in (dailyServicesUID?.allKeys)! {
                                    
                                    if dailyServicesUID![dailyServiceUID] as! Bool == true {
                                        self.dailyServiceCountRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dailyServiceType as! String).child(dailyServiceUID as! String)
                                        //Getting Daily Services Status (Like Entered or Not)
                                        self.dailyServiceStatusRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(dailyServiceType as! String).child(dailyServiceUID as! String)
                                        self.dailyServiceStatusRef?.child(NAString().status()).observeSingleEvent(of: .value, with: { (snapshot) in
                                            let dailyServiceStatus = snapshot.value
                                    
                                            queue.addOperation {
                                                self.dailyServiceCountRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                                                    numberOfFlat = Int((snapshot.childrenCount) - 1)
                                                    dsType = dailyServiceType as! String
                                                    dsStatus = dailyServiceStatus as! String
                                                    
                                                    //After getting Number of Flat & Daily Service Type from Firebase, Here i'm appending data in structure
                                                    let servicetype = dailySericeTypeAndNumberOfFlat.init(type: dsType, flat: numberOfFlat, status: dsStatus)
                                                    dsInfo.append(servicetype)
                                                    
                                                    self.dailyServicePublicRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC
                                                    self.dailyServicePublicRef?.keepSynced(true)
                                                    self.dailyServicePublicRef?.child(dailyServiceType as! String).child(dailyServiceUID as! String).child(userUID).observeSingleEvent(of: .value, with: { (snapshot) in
                                                        if snapshot.exists() {
                                                            
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
                                                                let dailyServicesData = NammaApartmentDailyServices(fullName: fullName as! String?, phoneNumber: phoneNumber as! String?, profilePhoto: profilePhoto as! String?, providedThings: providedThings as! Bool?, rating: rating as? Int, timeOfVisit: timeOfVisit as! String?, uid: uid as! String?, type: dsInfo[iterator].type as String?, numberOfFlat: dsInfo[iterator].flat as Int?, status: dsInfo[iterator].status as String?)
                                                                
                                                                self.NADailyServicesList.append(dailyServicesData)
                                                                
                                                                NAActivityIndicator.shared.hideActivityIndicator()
                                                                self.collectionView.reloadData()
                                                                iterator = iterator + 1
                                                            } else {
                                                                NAActivityIndicator.shared.hideActivityIndicator()
                                                                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
                                                            }
                                                        }
                                                    })
                                                })
                                            }
                                            queue.waitUntilAllOperationsAreFinished()
                                        })
                                    } else {
                                        NAActivityIndicator.shared.hideActivityIndicator()
                                        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
                                    }
                                }
                            })
                        }
                    }
                })
            }
        })
    }
    
    /* - Check if the flat has any daily service. If it does not have any Daily services added, we show daily service unavailable message
     - Else, we Display the cardView of all daily services of the current user. */
    func checkAndRetrieveDailyService() {
        let userDataReference = GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_DAILY_SERVICES)
        userDataReference.keepSynced(true)
        userDataReference.observeSingleEvent(of: .value) { (dailyServiceSnapshot) in
            if !(dailyServiceSnapshot.exists()) {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().dailyServiceNotAvailable())
            } else {
                let privateFlatReference = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_FLATMEMBERS)
                privateFlatReference.keepSynced(true)
                privateFlatReference.observeSingleEvent(of: .value, with: { (flatSnapshot) in
                    let flatMembers = flatSnapshot.value as? NSDictionary
                    print(flatMembers as Any)
                    for flatMembersUID in (flatMembers?.allKeys)! {
                        print(flatMembersUID as Any)
                        self.retrieveDailyServicesFromFirebase(userUID: flatMembersUID as! String)
                    }
                })
            }
        }
    }
}


