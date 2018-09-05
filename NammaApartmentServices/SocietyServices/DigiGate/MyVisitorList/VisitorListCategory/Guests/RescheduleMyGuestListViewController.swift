//
//  RescheduleMyVisitorListViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RescheduleMyGuestListViewController: NANavigationViewController {
    
    @IBOutlet weak var txt_ReDate: UITextField!
    @IBOutlet weak var txt_ReTime: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Reschedule: UIButton!
    
    @IBOutlet weak var date_StackView: UIStackView!
    @IBOutlet weak var time_StackView: UIStackView!
    
    //created string to get Time,Date & visitor UID for rescheduling purpose
    var getDate = String()
    var getTime = String()
    var getVisitorUID = String()
    var hideDateFromDailyServicesVC = String()
    var getDailyServiceType = String()
    var getDailyServiceUID = String()
    
    //Created Navigation Title String and Button Tag Values
    var navTitle = String()
    var buttonTagValue : Int = NAString().zero_length()
    
    //Database References
    var preApprovedVisitorsRef : DatabaseReference?
    var dailyServicesTimeOfVisitRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Condition for assigning DatePicker Format to Date & Time According to View
        if hideDateFromDailyServicesVC == NAString().yes() {
            datePicker.datePickerMode = UIDatePickerMode.time
            date_StackView.isHidden = true
        } else {
            datePicker.datePickerMode = UIDatePickerMode.date
        }
        
        //Handling Action on TextField Click
        txt_ReTime.addTarget(self, action: #selector(timeFunction), for: UIControlEvents.touchDown)
        txt_ReDate.addTarget(self, action: #selector(dateFunction), for: UIControlEvents.touchDown)
        
        //calling function which is setting icon inside the UItextFiled
        dateTextFieldIcon()
        timeTextFieldIcon()
        
        //set local date to Europe to show 24 hours
        datePicker.locale = Locale(identifier: "en_GB")
        
        //assigning strings to TextFields to get data from myVisitorList Cell
        self.txt_ReDate.text = getDate
        self.txt_ReTime.text = getTime
        
        //Hiding Keyboard
        txt_ReTime.inputView = UIView()
        txt_ReDate.inputView = UIView()
        
        //TextField formatting & Settings
        txt_ReDate.underlined()
        txt_ReTime.underlined()
        txt_ReTime.font = NAFont().textFieldFont()
        txt_ReDate.font = NAFont().textFieldFont()
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: navTitle)
        
        //Button Formatting & Settings
        btn_Cancel.backgroundColor = NAColor().buttonBgColor()
        btn_Cancel.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Cancel.setTitle(NAString().cancel(), for: .normal)
        btn_Cancel.titleLabel?.font = NAFont().buttonFont()
        
        btn_Reschedule.backgroundColor = NAColor().buttonBgColor()
        btn_Reschedule.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Reschedule.setTitle(NAString().reschedule(), for: .normal)
        btn_Reschedule.titleLabel?.font = NAFont().buttonFont()
        
        //assigned delegate method on textFields
        txt_ReTime.delegate = self
        txt_ReDate.delegate = self
    }
    
    //Create MyGuest Date Picker Action
    @IBAction func datePicker(_ sender: UIDatePicker) {
        if datePicker.datePickerMode == UIDatePickerMode.date {
            let date = DateFormatter()
            date.dateFormat = NAString().dateFormat()
            let dateString = date.string(from: datePicker.date)
            txt_ReDate.text = dateString
            // Minimum Date
            datePicker.minimumDate = NSDate() as Date
        } else {
            let time = DateFormatter()
            time.dateFormat = NAString().timeFormat()
            let timeString = time.string(from: datePicker.date)
            txt_ReTime.text = timeString
            //Minimum Time
            datePicker.minimumDate = NSDate() as Date
        }
    }
    
    //Create Cancel Button Action
    @IBAction func btnCancel(_ sender: UIButton) {
        if buttonTagValue == NAString().editButtonTagValue() {
            let lv = NAViewPresenter().myDailyServicesVC()
            self.navigationController?.pushViewController(lv, animated: true)
            dismiss(animated: true, completion: nil)
        } else {
            let lv = NAViewPresenter().myGuestListVC()
            self.navigationController?.pushViewController(lv, animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
    //Create Reschedule Button Action
    @IBAction func btnReschedule(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        if buttonTagValue == NAString().editButtonTagValue() {
            
            //Calling Time Rescheduling Function, When screen is My Daily Services.
            reschedulingDailyServicesTimeInFirebase()
            
            let lv = NAViewPresenter().myDailyServicesVC()
            self.navigationController?.pushViewController(lv, animated: true)
        } else {
            //Calling Time Rescheduling Function
            reschedulingVisitorTimeInFirebase()
            
            let lv = NAViewPresenter().myGuestListVC()
            self.navigationController?.pushViewController(lv, animated: true)
        }
    }
    
    //date TextField Function to display date only on click
    @objc func dateFunction(textField: UITextField) {
        datePicker.datePickerMode = UIDatePickerMode.date
    }
    
    //time TextField Function to display time only on click
    @objc func timeFunction(textField: UITextField) {
        datePicker.datePickerMode = UIDatePickerMode.time
    }
    
    // adding image on Date TextField
    func dateTextFieldIcon() {
        txt_ReDate.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image : UIImage = #imageLiteral(resourceName: "calendar")
        imageView.image = image
        txt_ReDate.rightView = imageView
    }
    
    // adding image on Time TextField
    func timeTextFieldIcon() {
        txt_ReTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image : UIImage = #imageLiteral(resourceName: "clock")
        imageView.image = image
        txt_ReTime.rightView = imageView
    }
}

extension RescheduleMyGuestListViewController {
    
    //Created function to reschedule date & time of visitor
    func reschedulingVisitorTimeInFirebase() {
        preApprovedVisitorsRef = Constants.FIREBASE_VISITORS_PRIVATE.child(self.getVisitorUID)
        
        var  newDateAndTimeOfVisit = String()
        newDateAndTimeOfVisit = (self.txt_ReDate.text!) + "\t\t" + (txt_ReTime.text!)
        preApprovedVisitorsRef?.child(VisitorListFBKeys.dateAndTimeOfVisit.key).setValue(newDateAndTimeOfVisit)
        
        //Here Post the Value using NotificationCenter
        NotificationCenter.default.post(name: Notification.Name("refreshRescheduledData"), object: nil)
        NotificationCenter.default.removeObserver(self)
    }
}

extension RescheduleMyGuestListViewController {
    
    //Created function to reschedule time of Daily service.
    func reschedulingDailyServicesTimeInFirebase() {
        
        dailyServicesTimeOfVisitRef = Constants.FIREBASE_DAILY_SERVICES_ALL_PUBLIC.child(self.getDailyServiceType).child(self.getDailyServiceUID).child(userUID)
        
        var newTimeOfVisit = String()
        newTimeOfVisit  = self.txt_ReTime.text!
        dailyServicesTimeOfVisitRef?.child(DailyServicesListFBKeys.timeOfVisit.key).setValue(newTimeOfVisit)
    }
}
