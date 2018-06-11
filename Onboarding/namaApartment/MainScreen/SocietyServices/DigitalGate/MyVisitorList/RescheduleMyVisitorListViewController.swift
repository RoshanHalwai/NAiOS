//
//  RescheduleMyVisitorListViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class RescheduleMyVisitorListViewController: NANavigationViewController {
    
    @IBOutlet weak var txt_ReDate: UITextField!
    @IBOutlet weak var txt_ReTime: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Reschedule: UIButton!
    
    //created string to get Time & Date for rescheduling purpose
    var getDate = String()
    var getTime = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigning strings to TextFields to get data from myVisitorList Cell
        self.txt_ReDate.text = getDate
        self.txt_ReTime.text = getTime
        
        //TextField formatting & Settings
        txt_ReDate.underlined()
        txt_ReTime.underlined()
        txt_ReTime.font = NAFont().textFieldFont()
        txt_ReDate.font = NAFont().textFieldFont()
        
        //Button Formatting & Settings
        btn_Cancel.backgroundColor = NAColor().buttonBgColor()
        btn_Cancel.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Cancel.setTitle(NAString().cancel(), for: .normal)
        btn_Cancel.titleLabel?.font = NAFont().buttonFont()
        
        btn_Reschedule.backgroundColor = NAColor().buttonBgColor()
        btn_Reschedule.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Reschedule.setTitle(NAString().reschedule(), for: .normal)
        btn_Reschedule.titleLabel?.font = NAFont().buttonFont()
    
        //Handling Action on TextField Click
         txt_ReTime.addTarget(self, action: #selector(timeFunction), for: UIControlEvents.touchDown)
        
        txt_ReDate.addTarget(self, action: #selector(dateFunction), for: UIControlEvents.touchDown)
        
        //set local date to Europe to show 24 hours
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.datePickerMode = UIDatePickerMode.date
        
        //calling function which is setting icon inside the UItextFiled
        dateTextFieldIcon()
        timeTextFieldIcon()
        
        //assigned delegate method on textFields
        txt_ReTime.delegate = self
        txt_ReDate.delegate = self
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        if datePicker.datePickerMode == UIDatePickerMode.date {
            let date = DateFormatter()
            date.dateFormat = NAString().dateFormate()
            let dateString = date.string(from: datePicker.date)
            txt_ReDate.text = dateString
            // Minimum Date
            datePicker.minimumDate = NSDate() as Date
        }
        else
        {
            let time = DateFormatter()
            time.dateFormat = NAString().timeFormate()
            let timeString = time.string(from: datePicker.date)
            txt_ReTime.text = timeString
            //Minimum Time
            datePicker.minimumDate = NSDate() as Date
        }
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        let lv = NAViewPresenter().myVisitorListVC()
        self.navigationController?.pushViewController(lv, animated: true)
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
    }
    
    @IBAction func btnReschedule(_ sender: UIButton) {
        let lv = NAViewPresenter().myVisitorListVC()
        self.navigationController?.pushViewController(lv, animated: true)
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "newCalender")
        imageView.image = image
        txt_ReDate.rightView = imageView
    }
    
    // adding image on Time TextField
    func timeTextFieldIcon() {
        txt_ReTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_ReTime.rightView = imageView
    }
}
