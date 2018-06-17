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
    @IBOutlet weak var lbl_GetAccess: UILabel!
    
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mobile_Validation: UILabel!
    
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_InTime: UITextField!
    
    @IBOutlet weak var btn_Update: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    //stackView Outlets
    @IBOutlet weak var stack_InTime: UIStackView!
    @IBOutlet weak var stack_GrantAccess: UIStackView!
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    //get data from My Visitor List VC
    var getName = String()
    var getMobile = String()
    var getTime = String()
    var getDescription = String()
    var getTitle = String()
    
    var getNewName = String()
    var getNewMobile = String()
    var getNewTime = String()
    
    //To get particular service type string from Add My Services 
    var servicesString = String()
    
    //get segmented string from card view to select default IndexValue
    var getSegmentValue = String()
    
    //Length Variables
    var nameTextFieldLength = NAString().zero_length()
    var mobileNumberTextFieldLength = NAString().zero_length()
    var dateTextFieldLength = NAString().zero_length()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Segmented Controller is selected according to CardView Data.
       if getSegmentValue == NAString().yes() {
        segment.selectedSegmentIndex = 0
        } else {
        segment.selectedSegmentIndex = 1
        }
        //hide error labels
        lbl_Name_Validation.isHidden = true
        lbl_Mobile_Validation.isHidden = true
        
        //keyboard appear when screen load
        self.txt_Name.becomeFirstResponder()
        
        //hide stackview according to Title of the view
        hideStackViews()
        
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
      
        //Formattimg & setting Label
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_InTime.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Description.font = NAFont().descriptionFont()
        self.lbl_GetAccess.font = NAFont().headerFont()
        
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        self.lbl_InTime.text = NAString().time()
        self.lbl_GetAccess.text = NAString().grant_access()
    
        //Formatting & setting TextField
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_InTime.font = NAFont().textFieldFont()
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().textFieldFont()
        self.txt_CountryCode.text = NAString()._91()
        
        //creating black underline in bottom of texfield
        self.txt_MobileNo.underlined()
        self.txt_Name.underlined()
        self.txt_InTime.underlined()
        
        //Formatting & setting Button
        self.btn_Update.setTitle(NAString().update().uppercased(), for: .normal)
        self.btn_Update.titleLabel?.font = NAFont().buttonFont()
        self.btn_Update.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_Update.backgroundColor = UIColor.black
        
        // adding image on date TextField
        self.txt_InTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_InTime.rightView = imageView
    }
    
    //hide contents according to Title of the View
    func hideStackViews() {
        if getTitle == NAString().edit_my_family_member_details().capitalized {
            self.stack_InTime.isHidden = true
            self.stack_GrantAccess.isHidden = false
            self.lbl_Description.text = NAString().otp_message_family_member()
        } else {
            self.stack_InTime.isHidden = false
            self.stack_GrantAccess.isHidden = true
            self.lbl_Description.text! = getDescription
        }
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
    
    //action function for datePicker "Done" button
    @objc func donePressed() {
        // Time Formate
        let time = DateFormatter()
        time.dateFormat = NAString().timeFormate()
        let dateString = time.string(from: picker.date)
        txt_InTime.text = dateString
        self.view.endEditing(true)
        
        //show btn update on time change (done button pressed)
        btn_Update.isHidden = false
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        
            //if Mobile Number will change then navigate to OTP Screen
        if ((getTitle == NAString().edit_my_daily_service_details().capitalized) && lbl_Description.isHidden == false) {
            let dv = NAViewPresenter().otpViewController()
            let passToOTP = NAString().enter_verification_code(first: "your \(servicesString)", second: "their")
                dv.newOtpString = passToOTP
            self.navigationController?.pushViewController(dv, animated: true)
        }
            //if Mobile Number will not change then navigate to My Daily Services VC
        else if (getTitle == NAString().edit_my_daily_service_details().capitalized) {
            let dv = NAViewPresenter().myDailyServicesVC()
            self.navigationController?.pushViewController(dv, animated: true)
            
        } else if (getTitle == NAString().edit_my_family_member_details().capitalized) {
            //Modify EDIT MY FAMILY MEMBER VC while YES is already selected while modifying
            if segment.selectedSegmentIndex == 0 {
                let alert = UIAlertController(title: NAString().edit_my_family_member_grantAccess_alertBox(first:NAString().granting_access()) , message:nil, preferredStyle: .alert)
                
                let reject = UIAlertAction(title:NAString().reject(), style: .cancel) { (action) in }
                let accept = UIAlertAction(title:NAString().accept(), style: .default) { (action) in
                    
                    if (self.lbl_Description.isHidden == false) {
                        //navigate to OTP
                        let dv = NAViewPresenter().otpViewController()
                        let passToOTP = NAString().enter_verification_code(first:"your Family Member", second: "their")
                        dv.newOtpString = passToOTP
                        self.navigationController?.pushViewController(dv, animated: true)
                    } else {
                        //navigate back to card view
                        let dv = NAViewPresenter().mySweetHomeVC()
                        self.navigationController?.pushViewController(dv, animated: true)
                    }
                }
                alert.addAction(accept) //add accept action on AlertView
                alert.addAction(reject) //add reject action on AlertView
                present(alert, animated: true, completion: nil)
            }
            
             //Modify EDIT MY FAMILY MEMBER VC while NO is already selected at the time of modifying
            if segment.selectedSegmentIndex == 1 {
                isNoSegmentSelected()
            }
        }
        if ((getTitle == NAString().edit_my_family_member_details().capitalized) && lbl_Description.isHidden == false) {
            let dv = NAViewPresenter().otpViewController()
            let passToOTP = NAString().enter_verification_code(first: "your Family Member", second: "their")
            dv.newOtpString = passToOTP
            self.navigationController?.pushViewController(dv, animated: true)
        }
         if (getTitle == NAString().edit_my_family_member_details().capitalized) && lbl_Description.isHidden == true {
            let dv = NAViewPresenter().mySweetHomeVC()
            self.navigationController?.pushViewController(dv, animated: true)
        }
    }
    //Displaying Update Button on change of both the index values of segmentController
    @IBAction func btnSegmentController(_ sender: Any) {
        if segment.selectedSegmentIndex == 0 {
            self.btn_Update.isHidden = false
        }
        if segment.selectedSegmentIndex == 1 {
            self.btn_Update.isHidden = false
        }
    }
    //Creted alertview to Modify EDIT MY FAMILY MEMBER VC while YES is already selected at the time of modifying
    func isNoSegmentSelected() {
            let alert = UIAlertController(title: NAString().edit_my_family_member_grantAccess_alertBox(first:NAString().not_granting_access()) , message:nil, preferredStyle: .alert)
            
            let reject = UIAlertAction(title:NAString().reject(), style: .cancel) { (action) in }
        
            let accept = UIAlertAction(title:NAString().accept(), style: .default) { (action) in
                
                if (self.lbl_Description.isHidden == false) {
                    //navigate to OTP
                    let dv = NAViewPresenter().otpViewController()
                    let passToOTP = NAString().enter_verification_code(first:"your Family Member", second: "their")
                    dv.newOtpString = passToOTP
                    self.navigationController?.pushViewController(dv, animated: true)
                } else {
                    //navigate back to card view
                    let dv = NAViewPresenter().mySweetHomeVC()
                    self.navigationController?.pushViewController(dv, animated: true)
                }
            }
            alert.addAction(accept) //add accept action on AlertView
            alert.addAction(reject) //add reject action on AlertView
            present(alert, animated: true, completion: nil)
        }
}

//Created separate extention to use UITextfiled delegate Properties
extension EditMyServicesViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_InTime
        {
            lbl_Description.isHidden = true
            dateTextFieldLength = newLength
            nameTextFieldLength = txt_Name.text!.count
            mobileNumberTextFieldLength = txt_MobileNo.text!.count
            updateAddButtonVisibilty(nameLength: nameTextFieldLength, mobileNumberLength: mobileNumberTextFieldLength, dateLength: dateTextFieldLength)
        }
        if textField == txt_Name {
            if newLength == getName.count{
                btn_Update.isHidden = true
            } else {
                btn_Update.isHidden = false
            }
            if txt_Name.text == txt_Name.text! {
                btn_Update.isHidden = true
                lbl_Description.isHidden = true
            }
            if (newLength == NAString().zero_length()) {
                lbl_Name_Validation.isHidden = false
                txt_Name.redunderlined()
                lbl_Name_Validation.text = NAString().please_enter_name()
                btn_Update.isHidden = true
            } else {
                lbl_Name_Validation.isHidden = true
                txt_Name.underlined()
                btn_Update.isHidden = false
            }
        }
        if textField == txt_MobileNo
        {
            if (newLength > NAString().required_mobileNo_Length()){
                btn_Update.isHidden = true
                lbl_Description.isHidden = true
            }
            if NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength)
            {
                lbl_Mobile_Validation.isHidden = true
                txt_MobileNo.underlined()
            }
            else
            {
                lbl_Mobile_Validation.isHidden = false
                txt_MobileNo.redunderlined()
                btn_Update.isHidden = true
                lbl_Description.isHidden = true
                lbl_Mobile_Validation.text = NAString().please_enter_10_digit_no()
            }
            if (newLength == NAString().required_mobileNo_Length()) && !(txt_InTime.text?.isEmpty)!
            {
                btn_Update.isHidden = false
                lbl_Description.isHidden = false
            }
            nameTextFieldLength = txt_Name.text!.count
            dateTextFieldLength = txt_InTime.text!.count
            mobileNumberTextFieldLength = newLength
            updateAddButtonVisibilty(nameLength: nameTextFieldLength, mobileNumberLength: mobileNumberTextFieldLength, dateLength: dateTextFieldLength)
            
            //Check for Text Removal
            if string.isEmpty
            {
                return true
            }
            else
            {
                return newLength <= NAString().required_mobileNo_Length()
            }
        }
        return true
    }
    
    func configureTextFields() {
        txt_MobileNo.delegate = self
        txt_Name.delegate = self
        txt_InTime.delegate = self
        //txt_MobileNo.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        //txt_Name.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
/*@objc func textFieldDidChange(textField: UITextField) {
    
}*/
    
    func updateAddButtonVisibilty(nameLength:Int, mobileNumberLength:Int, dateLength:Int)
    {
        if stack_InTime.isHidden == true {
            if nameLength > NAString().zero_length() &&  NAValidation().isValidMobileNumber(isNewMobileNoLength: mobileNumberLength)
            {
                btn_Update.isHidden = false
                lbl_Description.isHidden = false
            } else {
                btn_Update.isHidden = true
                lbl_Description.isHidden = true
            }
        }
        if stack_GrantAccess.isHidden == true {
            if nameLength > NAString().zero_length() &&  NAValidation().isValidMobileNumber(isNewMobileNoLength: mobileNumberLength) && dateLength > NAString().zero_length()
            {
                btn_Update.isHidden = false
                lbl_Description.isHidden = false
            }
            if nameLength == NAString().zero_length() || mobileNumberLength == NAString().zero_length()
            {
                btn_Update.isHidden = true
                lbl_Description.isHidden = true
            }
        }
    }
}
