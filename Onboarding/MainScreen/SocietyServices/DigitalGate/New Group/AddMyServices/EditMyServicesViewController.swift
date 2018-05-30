//
//  EditMyServicesViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 23/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class EditMyServicesViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_InTime: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_InTime: UITextField!
    
    @IBOutlet weak var btn_Update: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    //get data from My Visitor List VC
    var getName = String()
    var getMobile = String()
    var getTime = String()
    var getDescription = String()
    var getTitle = String()
    
    //To get particular service type string from Add My Services 
    var servicesString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //calling function for delegate purpose
       configureTextFields()
        
        //set local date to Europe to show 24 hours
        picker.locale = Locale(identifier: "en_GB")
        
        //added datepicker function
        createDatePicker()
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        
        //hiding Update btn & description Label
        self.btn_Update.isHidden = true
        self.lbl_Description.isHidden = true
        
        //Formatting & setting Navigation Bar
        super.ConfigureNavBarTitle(title: getTitle)
        
        //assigning string to labels to get data
        self.txt_Name.text! = getName
        self.txt_MobileNo.text! = getMobile
        self.txt_InTime.text! = getTime
        self.lbl_Description.text! = getDescription
        
        //Formattimg & setting Label
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_InTime.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Description.font = NAFont().descriptionFont()
        
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        self.lbl_InTime.text = NAString().time()
    
        //Formatting & setting TextField
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_InTime.font = NAFont().textFieldFont()
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().textFieldFont()
        
        self.txt_CountryCode.text = NAString()._91()
        
        //creating black underline in bottom of texfield
        self.txt_CountryCode.underlined()
        self.txt_MobileNo.underlined()
        self.txt_Name.underlined()
        self.txt_InTime.underlined()
        
        //Formatting & setting Button
        self.btn_Update.setTitle(NAString().update(), for: .normal)
        self.btn_Update.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_Update.backgroundColor = UIColor.black
        
        // adding image on date TextField
        self.txt_InTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_InTime.rightView = imageView
    }
    
    //for datePicker
    func createDatePicker() {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_InTime.inputAccessoryView = toolbar
        txt_InTime.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .time
    }
    
    @objc func donePressed() {
        // Time Formate
        let time = DateFormatter()
        time.dateFormat = "HH:mm"
        let dateString = time.string(from: picker.date)
        txt_InTime.text = dateString
        self.view.endEditing(true)
        
        //show btn update on time change
        btn_Update.isHidden = false
    }
    
    @IBAction func btnUpdate(_ sender: UIButton){
        if(lbl_Description.isHidden == false)
        {
        let dv = NAViewPresenter().otpViewController()
        let passToOTP = NAString().enter_verification_code(first: "your \(servicesString)", second: "their")
        
        dv.newOtpString = passToOTP
        self.navigationController?.pushViewController(dv, animated: true)
        }
        else
        {
        let lv = NAViewPresenter().myDailyServicesVC()
        self.navigationController?.pushViewController(lv, animated: true)
        }
    }
}

 //Created separate extention to use UITextfiled delegate Properties
extension EditMyServicesViewController : UITextFieldDelegate
{
    
    func configureTextFields()
    {
        txt_MobileNo.delegate = self
        txt_Name.delegate = self
        txt_InTime.delegate = self
        txt_MobileNo.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        txt_Name.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    //Created to Dismiss keyboard when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

@objc func textFieldDidChange(textField: UITextField) {
    
        //your code
    if textField == txt_MobileNo {
        lbl_Description.isHidden = false
    }
        btn_Update.isHidden = false
    }
    
}
