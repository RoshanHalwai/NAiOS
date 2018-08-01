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
    @IBOutlet weak var txt_myDailyServiceTime: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Reschedule: UIButton!
    @IBOutlet weak var myGuest_StackView: UIStackView!
    @IBOutlet weak var timePicker: UIDatePicker?
    @IBOutlet weak var myGuest_View: UIView!
    @IBOutlet weak var myDailyService_View: UIView!
    
    //created string to get Time,Date & visitor UID for rescheduling purpose
    var getDate = String()
    var getTime = String()
    var getVisitorUID = String()
    
    //Created Navigation Title String and Button Tag Values
    var navTitle = String()
    var buttonTagValue : Int = NAString().zero_length()
    
    //Database References
    var preApprovedVisitorsRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handling Action on TextField Click
        txt_ReTime.addTarget(self, action: #selector(timeFunction), for: UIControlEvents.touchDown)
        txt_ReDate.addTarget(self, action: #selector(dateFunction), for: UIControlEvents.touchDown)
        txt_myDailyServiceTime.addTarget(self, action: #selector(myDailyServiceTimeFunction), for: UIControlEvents.touchDown)
        
        //calling function which is setting icon inside the UItextFiled
        dateTextFieldIcon()
        timeTextFieldIcon()
        myDailyServiceTimeTextFieldIcon()
        
        //set local date to Europe to show 24 hours
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.datePickerMode = UIDatePickerMode.date
        
        //assigning strings to TextFields to get data from myVisitorList Cell
        self.txt_ReDate.text = getDate
        self.txt_ReTime.text = getTime
        
        //Hiding Keyboard
        txt_ReTime.inputView = UIView()
        txt_ReDate.inputView = UIView()
        txt_myDailyServiceTime.inputView = UIView()
        
        //TextField formatting & Settings
        txt_ReDate.underlined()
        txt_ReTime.underlined()
        txt_myDailyServiceTime.underlined()
        txt_ReTime.font = NAFont().textFieldFont()
        txt_ReDate.font = NAFont().textFieldFont()
        txt_myDailyServiceTime.font = NAFont().textFieldFont()
        
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
        txt_myDailyServiceTime.delegate = self
        
        //Calling Reschedule ViewController Function
        self.changedRescheduleController()
    }
    
    //Here Creating Change the Screen Based On Button Tag Values
    func changedRescheduleController() {
        if buttonTagValue == NAString().editButtonTagValue() {
            myDailyService_View.frame = CGRect(x: 0, y: 0, width: myGuest_View.frame.size.width, height: myGuest_View.frame.size.height-50)
            myGuest_View.addSubview(myDailyService_View)
            createTimePickerAction()
        } 
    }
    
    //Create MydailyService Picker View Action
    @IBAction func myDailyService_PickerAction(_ sender: UIDatePicker) {
        createTimePickerAction()
    }
    
    //Create MydailyService Picker View Function
    func createTimePickerAction() {
        let time = DateFormatter()
        time.dateFormat = NAString().timeFormat()
        let timeString = time.string(from: (timePicker?.date)!)
        txt_myDailyServiceTime.text = timeString
        //Minimum Time
        timePicker?.minimumDate = NSDate() as Date
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
    
    //My Daily Service time TextField Function to display time only on click
    @objc func myDailyServiceTimeFunction(textField: UITextField) {
        timePicker?.datePickerMode = UIDatePickerMode.time
    }
    
    // adding image on Date TextField
    func dateTextFieldIcon() {
        txt_ReDate.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newCalender")
        imageView.image = image
        txt_ReDate.rightView = imageView
    }
    
    // adding image on Time TextField
    func timeTextFieldIcon() {
        txt_ReTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_ReTime.rightView = imageView
    }
    
    // adding image on MyDailyService Time TextField
    func myDailyServiceTimeTextFieldIcon() {
        txt_myDailyServiceTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_myDailyServiceTime.rightView = imageView
    }
}

extension RescheduleMyGuestListViewController {
    
    //Created function to reschedule date & time of visitor
    func reschedulingVisitorTimeInFirebase() {
        preApprovedVisitorsRef = Database.database().reference().child(Constants.FIREBASE_CHILD_VISITORS).child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS).child(self.getVisitorUID)
        
        var  newDateAndTimeOfVisit = String()
        newDateAndTimeOfVisit = (self.txt_ReDate.text!) + "\t\t" + (txt_ReTime.text!)
        preApprovedVisitorsRef?.child(VisitorListFBKeys.dateAndTimeOfVisit.key).setValue(newDateAndTimeOfVisit)
        
        //Here Post the Value using NotificationCenter
        NotificationCenter.default.post(name: Notification.Name("refreshRescheduledData"), object: nil)
    }
}
