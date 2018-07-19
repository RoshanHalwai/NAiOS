//
//  MyDailyViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyDailyServicesViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //floating button downside the list.
    @IBOutlet weak var btn_AddMyDailyServices: UIButton!
    @IBOutlet weak var opacity_View: UIView!
    @IBOutlet weak var popUp_View: UIView!
    @IBOutlet weak var lbl_PickTime: UILabel!
    @IBOutlet weak var txt_PickTime: UITextField!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Reschedule: UIButton!
    
    //Created variable of DBReference for storing data in firebase
    var myDailyServicesListReference : DatabaseReference?
    
    //Created variable for Daily services list FB Objects to fetch data from firebase.
    var myDailyServicesList = [NammaApartmentDailyServices]()
   
    //Array of Action sheet items.
    var dailyService = [NAString().cook(), NAString().maid(), NAString().car_bike_cleaning(), NAString().child_day_care(),NAString().daily_newspaper(), NAString().milk_man(),NAString().laundry(),NAString().driver()]
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_PickTime.underlined()
        
        //calling DatePicker Funtion
        createDatePicker()
        
        opacity_View.isHidden = true
        popUp_View.isHidden = true
        popUp_View.layer.cornerRadius = 5
        
        // adding image on date TextField
        txt_PickTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_PickTime.rightView = imageView
        
        lbl_PickTime.font = NAFont().headerFont()
        txt_PickTime.font = NAFont().textFieldFont()
        btn_Cancel.titleLabel?.font = NAFont().popUpButtonFont()
        btn_Reschedule.titleLabel?.font = NAFont().popUpButtonFont()
        
        //to show activity indicator before loading data from firebase
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Formmating & setting Button
        self.btn_AddMyDailyServices.setTitle(NAString().add_my_service().capitalized, for: .normal)
        self.btn_AddMyDailyServices.backgroundColor = NAColor().buttonBgColor()
        self.btn_AddMyDailyServices.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_AddMyDailyServices.titleLabel?.font = NAFont().buttonFont()
        
        //calling function to retriev data from firebase.
        getMyDailyServicesDataFromFirebase()
       
        //Formatting & setting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().my_daily_services().capitalized)
    }
    
    //for creating action sheet to select my daily services
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
        
        //passing value to my services VC
        let passVC = "myDailyServicesVC"
        lv.vcValue = passVC
        
        lv.navTitle =  NAString().add_my_service().capitalized
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDailyServicesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyDailyServicesCollectionViewCell
        
        //Created constant variable to store all the firebase data in it.
        let list : NammaApartmentDailyServices
        list = myDailyServicesList[indexPath.row]
        
        cell.lbl_MyDailyServiceName.text = list.fullName
        
        //TODO : Need to change Services type
        cell.lbl_MyDailyServiceType.text = NAString().cook()
        cell.lbl_MyDailyServicesInTime.text = list.timeOfVisit
        
        //For converting Int with String.
        //cell.lbl_MyDailyServicesRating.text = "\(list.rating!)"
        
        //TODO : Need to change Flat Number.
        cell.lbl_MyDailyServicesFlats.text = "5"
    
        //Calling global function to get Profile Image from Firebase.
        if let urlString = list.profilePhoto {
            NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.myDailyServicesImage)
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
        
        //to display image in round shape
        cell.myDailyServicesImage.layer.cornerRadius = cell.myDailyServicesImage.frame.size.width/2
        cell.myDailyServicesImage.clipsToBounds = true
        
        //Labels Formatting & setting
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
        
        cell.lbl_Call.text = NAString().call()
        cell.lbl_Edit.text = NAString().edit()
        cell.lbl_Remove.text = NAString().remove()
        cell.lbl_Message.text = NAString().message()
        
        cell.lbl_myDailyName.text = NAString().name()
        cell.lbl_myDailytype.text = NAString().type()
        cell.lbl_myDailyFlats.text = NAString().flats()
        cell.lbl_myDailyTime.text = NAString().time()
        cell.lbl_myDailyRating.text = NAString().rating()
        
        //delete particular cell from list
        cell.index = indexPath
        cell.delegate = self
        
        //calling button action on particular cell
        cell.yourobj = {
            self.opacity_View.isHidden = false
            self.popUp_View.isHidden = false
        }
        return cell
    }
    
    //for datePicker
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_PickTime.inputAccessoryView = toolbar
        txt_PickTime.inputView = picker
        
        //format picker for date
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
    
    func getMyDailyServicesDataFromFirebase() {
        //Assigning Child from where to get data in Daily Services List.
        //TODO: Right now only showing particular cook's details in the list.
        myDailyServicesListReference = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(Constants.FIREBASE_CHILD_DAILY_SERVICES_TYPE_COOKS)
        
        myDailyServicesListReference?.observeSingleEvent(of: .value, with: {(snapshot) in
            
            //checking that  child node have data or not inside firebase. If Have then fatch all the data in tableView
            if snapshot.exists() {
               
                //for loop for getting all the data in tableview
                for dailyServices in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let dailyServicesObject = dailyServices.value as? [String: AnyObject]
                    
                    let fullName = dailyServicesObject?[DailyServicesListFBKeys.fullName.key]
                    let phoneNumber = dailyServicesObject?[DailyServicesListFBKeys.phoneNumber.key]
                    let profilePhoto = dailyServicesObject?[DailyServicesListFBKeys.profilePhoto.key]
                    let providedThings = dailyServicesObject?[DailyServicesListFBKeys.providedThings.key]
                    let rating = dailyServicesObject?[DailyServicesListFBKeys.rating.key]
                    let timeOfVisit = dailyServicesObject?[DailyServicesListFBKeys.timeOfVisit.key]
                    let uid = dailyServicesObject?[DailyServicesListFBKeys.uid.key]
                    
                    //creating dailyServices model & initiliazing here
                    let dailyServicesData = NammaApartmentDailyServices(fullName: fullName as! String?, phoneNumber: phoneNumber as! String?, profilePhoto: profilePhoto as! String?, providedThings: providedThings as! Bool?, rating: rating as! Int?, timeOfVisit: timeOfVisit as! String?, uid: uid as! String?)
                    
                    //Adding dailyservices in services List
                    self.myDailyServicesList.append(dailyServicesData)
                    
                    //Hidding Activity indicator after loading data in the list from firebase.
                    NAActivityIndicator.shared.hideActivityIndicator()
                }
                //reload collection view.
                self.collectionView.reloadData()
            }
        })
    }
}

extension MyDailyServicesViewController : dataCollectionProtocolMyDailySVC{
    func deleteData(indx: Int, cell: UICollectionViewCell) {
        
        //AlertView will Display while removing Card view
        let alert = UIAlertController(title: NAString().delete(), message: NAString().remove_alertview_description(), preferredStyle: .alert)
        
        let actionNO = UIAlertAction(title:NAString().no(), style: .cancel) { (action) in }
        let actionYES = UIAlertAction(title:NAString().yes(), style: .default) { (action) in
            
            //Remove collection view cell item with animation
            self.myDailyServicesList.remove(at: indx)
            //animation at final state
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 0.0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 400, 20, 0)
                cell.layer.transform = transform
            }
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
