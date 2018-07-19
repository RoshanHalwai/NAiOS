//
//  ExpectingCabArrivalViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 09/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ExpectingArrivalViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_cabNumber: UILabel!
    @IBOutlet weak var lbl_DateTime: UILabel!
    @IBOutlet weak var lbl_ValidFor: UILabel!
    
    @IBOutlet weak var cabNumber_stack : UIStackView!
    
    @IBOutlet weak var lbl_cabNumber_Validation: UILabel!
    @IBOutlet weak var lbl_dateField_Validation: UILabel!
    @IBOutlet weak var lbl_expectedHours_Validation: UILabel!
    
    @IBOutlet weak var txt_PackageVendor: UITextField!
    @IBOutlet weak var txt_CabStateCode: UITextField!
    @IBOutlet weak var txt_CabRtoNumber: UITextField!
    @IBOutlet weak var txt_CabSerialNumberOne: UITextField!
    @IBOutlet weak var txt_CabSerialNumberTwo: UITextField!
    @IBOutlet weak var txt_DateTime: UITextField!
    
    @IBOutlet weak var btn_NotifyGate: UIButton!
    
    @IBOutlet weak var btn_1Hour: UIButton!
    @IBOutlet weak var btn_2Hour: UIButton!
    @IBOutlet weak var btn_4Hour: UIButton!
    @IBOutlet weak var btn_6Hour: UIButton!
    @IBOutlet weak var btn_8Hour: UIButton!
    @IBOutlet weak var btn_12Hour: UIButton!
    @IBOutlet weak var btn_16Hour: UIButton!
    @IBOutlet weak var btn_24Hour: UIButton!
    
    //array of buttons for color changing purpose
    var buttons : [UIButton] = []
    var isValidButtonClicked: [Bool] = []
    
    //to set navigation title
    var navTitle: String?
    
    //Assigning Strings according to title
    var vendorCabNameString: String?
    
    //for card view
    @IBOutlet weak var cardView: UIView!
    
    // for scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    
    //created date picker programtically
    var picker: UIDatePicker?
    
    //Database References
    var userDataCabRef : DatabaseReference?
    var cabsPrivateRef : DatabaseReference?
    var cabsPublicRef : DatabaseReference?
    
    var userDataPackageRef : DatabaseReference?
    var packagePrivateRef : DatabaseReference?
    var packagePublicRef : DatabaseReference?
    
    var finalCabString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding Cab TextFields & Pacakge Vandor textFields According to Title
        hidingTextFiledAccordingToTitle()
        
        //hiding error Label
        lbl_cabNumber_Validation.isHidden = true
        lbl_dateField_Validation.isHidden = true
        lbl_expectedHours_Validation.isHidden = true
        
        //assigned delegate method on textFields
        txt_DateTime.delegate = self
        txt_CabStateCode.delegate = self
        txt_CabRtoNumber.delegate = self
        txt_CabSerialNumberOne.delegate = self
        txt_CabSerialNumberTwo.delegate = self
        txt_PackageVendor.delegate = self
        
        //set tag values to textFields
        txt_CabStateCode.tag = 1
        txt_CabRtoNumber.tag = 2
        txt_CabSerialNumberOne.tag = 3
        txt_CabSerialNumberTwo.tag = 4
        
        //placing image calender imgage inside the Date&Time TextField
        self.txt_DateTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newCalender")
        imageView.image = image
        txt_DateTime.rightView = imageView
        
        // become first responder
        self.txt_CabRtoNumber.becomeFirstResponder()
        self.txt_CabSerialNumberOne.becomeFirstResponder()
        self.txt_CabSerialNumberTwo.becomeFirstResponder()
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: navTitle!)
        
        //Assigning Strings to the label tile according to title
        self.lbl_cabNumber.text = vendorCabNameString
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
        //calling datePicker On ViewLoad
        createDatePicker()
        
        //putting black bottom line on textFields
        txt_CabStateCode.underlined()
        txt_CabRtoNumber.underlined()
        txt_CabSerialNumberOne.underlined()
        txt_CabSerialNumberTwo.underlined()
        txt_DateTime.underlined()
        txt_PackageVendor.underlined()
        
        //Label formatting & setting
        lbl_DateTime.text = NAString().date_Time()
        lbl_ValidFor.text = NAString().valid_for()
        
        //lbl_Title.font = NAFont().headerFont()
        lbl_ValidFor.font = NAFont().headerFont()
        lbl_DateTime.font = NAFont().headerFont()
        lbl_cabNumber.font = NAFont().headerFont()
        
        //Error Labels Font Style
        lbl_cabNumber_Validation.font = NAFont().descriptionFont()
        lbl_dateField_Validation.font = NAFont().descriptionFont()
        lbl_expectedHours_Validation.font = NAFont().descriptionFont()
        
        //Textfield formatting & setting
        txt_CabStateCode.font = NAFont().textFieldFont()
        txt_CabRtoNumber.font = NAFont().textFieldFont()
        txt_CabSerialNumberOne.font = NAFont().textFieldFont()
        txt_CabSerialNumberTwo.font = NAFont().textFieldFont()
        txt_PackageVendor.font = NAFont().textFieldFont()
        txt_DateTime.font = NAFont().textFieldFont()
        
        //for changing button color
        buttons.removeAll()
        buttons.append(btn_1Hour)
        buttons.append(btn_2Hour)
        buttons.append(btn_4Hour)
        buttons.append(btn_6Hour)
        buttons.append(btn_8Hour)
        buttons.append(btn_12Hour)
        buttons.append(btn_16Hour)
        buttons.append(btn_24Hour)
        
        //button Formatting & setting
        btn_1Hour.setTitle(NAString()._1_hr(), for: .normal)
        btn_2Hour.setTitle(NAString()._2_hrs(), for: .normal)
        btn_4Hour.setTitle(NAString()._4_hrs(), for: .normal)
        btn_6Hour.setTitle(NAString()._6_hrs(), for: .normal)
        btn_8Hour.setTitle(NAString()._8_hrs(), for: .normal)
        btn_12Hour.setTitle(NAString()._12_hrs(), for: .normal)
        btn_16Hour.setTitle(NAString()._16_hrs(), for: .normal)
        btn_24Hour.setTitle(NAString()._24_hrs(), for: .normal)
        btn_NotifyGate.setTitle(NAString().notify_gate(), for: .normal)
        
        //color set on selected
        btn_1Hour.setTitleColor(UIColor.black, for: .selected)
        btn_2Hour.setTitleColor(UIColor.black, for: .selected)
        btn_4Hour.setTitleColor(UIColor.black, for: .selected)
        btn_6Hour.setTitleColor(UIColor.black, for: .selected)
        btn_8Hour.setTitleColor(UIColor.black, for: .selected)
        btn_12Hour.setTitleColor(UIColor.black, for: .selected)
        btn_16Hour.setTitleColor(UIColor.black, for: .selected)
        btn_24Hour.setTitleColor(UIColor.black, for: .selected)
        
        //Button Formatting & settings
        btn_NotifyGate.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_NotifyGate.backgroundColor = NAColor().buttonBgColor()
        btn_NotifyGate.titleLabel?.font = NAFont().buttonFont()
        
        //set tag values to buttons
        btn_1Hour.tag = 1
        btn_2Hour.tag = 2
        btn_4Hour.tag = 3
        btn_6Hour.tag = 4
        btn_8Hour.tag = 5
        btn_12Hour.tag = 6
        btn_16Hour.tag = 7
        btn_24Hour.tag = 8
        
        //make buttons rounded corner
        btn_1Hour.layer.cornerRadius = 15.0
        btn_2Hour.layer.cornerRadius = 15.0
        btn_4Hour.layer.cornerRadius = 15.0
        btn_6Hour.layer.cornerRadius = 15.0
        btn_8Hour.layer.cornerRadius = 15.0
        btn_12Hour.layer.cornerRadius = 15.0
        btn_16Hour.layer.cornerRadius = 15.0
        btn_24Hour.layer.cornerRadius = 15.0
        
        //settin border width for buttons
        btn_1Hour.layer.borderWidth = 1
        btn_2Hour.layer.borderWidth = 1
        btn_4Hour.layer.borderWidth = 1
        btn_6Hour.layer.borderWidth = 1
        btn_8Hour.layer.borderWidth = 1
        btn_12Hour.layer.borderWidth = 1
        btn_16Hour.layer.borderWidth = 1
        btn_24Hour.layer.borderWidth = 1
        
        //setting button hight
        btn_16Hour.heightAnchor.constraint(equalToConstant: 39.0).isActive = true
        btn_1Hour.heightAnchor.constraint(equalToConstant: 39).isActive = true
        btn_NotifyGate.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        //cardUIView
        cardView.layer.cornerRadius = 3
        cardView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView.layer.shadowRadius = 1.7
        cardView.layer.shadowOpacity = 0.45
    }
    
    //Hiding & Setting First Responder for Cab TextFields & Pacakge Vandor textFields According to Title
    func hidingTextFiledAccordingToTitle() {
        if (navTitle == NAString().expecting_cab_arrival()) {
            self.txt_CabStateCode.becomeFirstResponder()
            self.txt_PackageVendor.isHidden = true
        } else {
            self.txt_PackageVendor.becomeFirstResponder()
            cabNumber_stack.isHidden = true
        }
    }
    
    //for datePicker
    func createDatePicker() {
        //toolbar
        picker = UIDatePicker()
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_DateTime.inputAccessoryView = toolbar
        txt_DateTime.inputView =  picker
        
        // format picker for date
        picker?.datePickerMode = .dateAndTime
        
        //minimum date
        picker?.minimumDate = NSDate() as Date
        
        //set local date to Europe to show 24 hours
        picker?.locale = Locale(identifier: "en_GB")
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = (NAString().dateFormat() + "\t\t " + NAString().timeFormat())
        let dateString = date.string(from: (picker?.date)!)
        txt_DateTime.text = dateString
        self.view.endEditing(true)
        if !(txt_DateTime.text?.isEmpty)! {
            lbl_dateField_Validation.isHidden = true
            txt_DateTime.underlined()
        }
    }
    
    @IBAction func btnSelectHours(_ sender: UIButton) {
        selectedColor(tag: sender.tag)
    }
    
    @IBAction func btnNotifyGate(_ sender: Any) {
        if (txt_CabStateCode.text?.isEmpty)! {
            inviteLabelCabNumberTitle()
            txt_CabStateCode.redunderlined()
        } else {
            lbl_cabNumber_Validation.isHidden = true
            txt_CabStateCode.underlined()
        }
        if (txt_CabRtoNumber.text?.isEmpty)! {
            inviteLabelCabNumberTitle()
            txt_CabRtoNumber.redunderlined()
        } else {
            lbl_cabNumber_Validation.isHidden = true
            txt_CabRtoNumber.underlined()
        }
        if (txt_CabSerialNumberOne.text?.isEmpty)! {
            inviteLabelCabNumberTitle()
            txt_CabSerialNumberOne.redunderlined()
        } else {
            lbl_cabNumber_Validation.isHidden = true
            txt_CabSerialNumberOne.underlined()
        }
        if (txt_CabSerialNumberTwo.text?.isEmpty)! {
            inviteLabelCabNumberTitle()
            txt_CabSerialNumberTwo.redunderlined()
        } else {
            lbl_cabNumber_Validation.isHidden = true
            txt_CabSerialNumberTwo.underlined()
        }
        if (txt_PackageVendor.text?.isEmpty)! {
            inviteLabelCabNumberTitle()
            txt_PackageVendor.redunderlined()
        } else {
            lbl_cabNumber_Validation.isHidden = true
            txt_PackageVendor.underlined()
        }
        if (txt_DateTime.text?.isEmpty)! {
            lbl_dateField_Validation.isHidden = false
            lbl_dateField_Validation.text = NAString().Please_select_date()
            txt_DateTime.redunderlined()
        } else {
            lbl_dateField_Validation.isHidden = true
            txt_DateTime.underlined()
        }
        if !(txt_DateTime.text?.isEmpty)! && (isValidButtonClicked.index(of: true) == nil) {
            lbl_expectedHours_Validation.isHidden = false
            lbl_expectedHours_Validation.text = NAString().Please_select_expected_Hours()
        } else if (isValidButtonClicked.index(of: true) != nil) {
            lbl_expectedHours_Validation.isHidden = true
        }
        if !(txt_CabStateCode.text?.isEmpty)! &&  !(txt_CabRtoNumber.text?.isEmpty)! && !(txt_CabSerialNumberOne.text?.isEmpty)! && !(txt_CabSerialNumberTwo.text?.isEmpty)! {
            lbl_cabNumber_Validation.isHidden = true
        }
        if !(txt_CabStateCode.text?.isEmpty)! &&  !(txt_CabRtoNumber.text?.isEmpty)! && !(txt_CabSerialNumberOne.text?.isEmpty)! && !(txt_CabSerialNumberTwo.text?.isEmpty)!  && !(txt_DateTime.text?.isEmpty)! &&  (isValidButtonClicked.index(of: true) != nil) {
            
            //Calling Expecting Cab Function
            expectingCabArrival()
        }
        if !(txt_PackageVendor.text?.isEmpty)!  && !(txt_DateTime.text?.isEmpty)! &&  (isValidButtonClicked.index(of: true) != nil) {
            
            //Calling Expecting Package Function
            expectingPackageArrival()
        }
    }
    
    //Creating CablabelNumber validation and text
    func inviteLabelCabNumberTitle() {
        lbl_cabNumber_Validation.isHidden = false
        lbl_cabNumber_Validation.text = NAString().please_fill_details()
    }
    
    //AlertView For navigation
    func inviteAlertView() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().notifyButtonAlertViewTitle() , message: NAString().notifyButtonAlertViewMessage(), preferredStyle: .alert)
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
            if self.lbl_cabNumber.text == NAString().cab_number() {
                let lv1 = NAViewPresenter().cabAndPackageArrivalListVC()
                lv1.navTitle = NAString().cab_arrival()
                self.navigationController?.pushViewController(lv1, animated: true)
            } else if self.lbl_cabNumber.text == NAString().package_vendor_name() {
                let lv1 = NAViewPresenter().cabAndPackageArrivalListVC()
                lv1.navTitle = NAString().package_arrival()
                self.navigationController?.pushViewController(lv1, animated: true)
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //creating function to highlight select button color
    func selectedColor(tag: Int) {
        for button in buttons as [UIButton] {
            isValidButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
                lbl_expectedHours_Validation.isHidden = true
            } else {
                button.isSelected = false
            }
            let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
            button.backgroundColor = color
            button.tintColor = color
        }
    }
    
    // Creating CabStateCodeAndSerailCodeLength Validation and cabSerialNumberLength Validation
    func cabStateCodeAndSerailCodeLength(isCabNumberLength: Int) -> Bool{
        if (isCabNumberLength >= 2) {
            return true
        }else{
            return false
        }
    }
    
    func cabSerialNumberLength(isCabSerialNumberLength: Int) -> Bool {
        if (isCabSerialNumberLength >= 4) {
            return true
        }else{
            return false
        }
    }
    
    // Creating move cursor from One textField to another TextField
    func shouldChangeCustomCharacters(textField:UITextField, string: String) ->Bool {
        //Check if textField has two chacraters
        if ((textField.text?.count)! == 1  && string.count > 0) {
            // get next TextField
            let nextTag = textField.tag + 1
            var nextTextField = textField.superview?.viewWithTag(nextTag)
            if (nextTextField == nil) {
                nextTextField = textField.superview?.viewWithTag(1)
            }
            textField.text = textField.text! + string
            //write here your last textfield tag
            if textField.tag == 4 {
                //Dissmiss keyboard on last entry
                textField.resignFirstResponder()
            }
            else {
                //Appear keyboard
                nextTextField?.becomeFirstResponder()
            }
            return false
        } else if ((textField.text?.count)! == 1  && string.count == 0) {
            // on deleteing value from Textfield
            let previousTag = textField.tag - 1
            // get previous TextField
            var previousTextField = textField.superview?.viewWithTag(previousTag)
            if (previousTextField == nil) {
                previousTextField = textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousTextField?.becomeFirstResponder()
            return false
        }
        return true
    }
}

extension ExpectingArrivalViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let cab_New_TextLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_CabStateCode {
            if (cab_New_TextLength == NAString().zero_length()) {
                inviteLabelCabNumberTitle()
                txt_CabStateCode.redunderlined()
            } else {
                lbl_cabNumber_Validation.isHidden = true
                txt_CabStateCode.underlined()
            }
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if cabStateCodeAndSerailCodeLength(isCabNumberLength: cab_New_TextLength) {
                    return cab_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_CabRtoNumber {
            if (cab_New_TextLength == NAString().zero_length()) {
                inviteLabelCabNumberTitle()
                txt_CabRtoNumber.redunderlined()
            } else {
                lbl_cabNumber_Validation.isHidden = true
                txt_CabRtoNumber.underlined()
            }
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if cabStateCodeAndSerailCodeLength(isCabNumberLength: cab_New_TextLength) {
                    return cab_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_CabSerialNumberOne {
            if (cab_New_TextLength == NAString().zero_length()) {
                inviteLabelCabNumberTitle()
                txt_CabSerialNumberOne.redunderlined()
            } else {
                lbl_cabNumber_Validation.isHidden = true
                txt_CabSerialNumberOne.underlined()
            }
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if cabStateCodeAndSerailCodeLength(isCabNumberLength: cab_New_TextLength) {
                    return cab_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_CabSerialNumberTwo {
            if cabSerialNumberLength(isCabSerialNumberLength: cab_New_TextLength) {
                if (cab_New_TextLength == NAString().zero_length()) {
                    inviteLabelCabNumberTitle()
                    txt_CabSerialNumberTwo.redunderlined()
                } else {
                    lbl_cabNumber_Validation.isHidden = true
                    txt_CabSerialNumberTwo.underlined()
                }
            }
            return cab_New_TextLength <= 4
        }
        if textField == txt_PackageVendor {
            if (cab_New_TextLength == NAString().zero_length()) {
                inviteLabelCabNumberTitle()
                txt_PackageVendor.redunderlined()
            } else {
                lbl_cabNumber_Validation.isHidden = true
                txt_PackageVendor.underlined()
            }
        }
        if textField == txt_DateTime {
            if (cab_New_TextLength == NAString().zero_length()) {
                lbl_dateField_Validation.isHidden = false
                txt_DateTime.redunderlined()
                lbl_dateField_Validation.text = NAString().Please_select_date()
            } else {
                lbl_dateField_Validation.isHidden = true
                txt_DateTime.underlined()
            }
        }
        if (navTitle == NAString().expecting_cab_arrival()) {
            return false
        }
        return true
    }
}

extension ExpectingArrivalViewController {
    
    //Creating Function for expecting Package Arrival
    func expectingCabArrival() {
        
        //Concatination of Cab textFields
        let cabStateCode  = self.txt_CabStateCode.text!
        let cabRTOCode  = self.txt_CabRtoNumber.text!
        let cabSerialOne  = self.txt_CabSerialNumberOne.text!
        let cabSerialTwo = self.txt_CabSerialNumberTwo.text!
        let hyphen = "-"
        self.finalCabString = cabStateCode + hyphen + cabRTOCode + hyphen + cabSerialOne + hyphen + cabSerialTwo
        
        //getting users Flat Details Form Singaltone class
        let flatValues = Singleton_FlatDetails.shared.flatDetails_Items
        let userFlatDetailValues = flatValues.first
        
        cabsPublicRef = Database.database().reference().child(Constants.FIREBASE_CHILD_CABS).child(Constants.FIREBASE_USER_PUBLIC)
        
        //Generating Cab UID
        let cabUID : String?
        cabUID = (cabsPublicRef?.childByAutoId().key)!
        
        cabsPrivateRef = Database.database().reference().child(Constants.FIREBASE_CHILD_CABS).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        userDataCabRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child((userFlatDetailValues?.city)!).child((userFlatDetailValues?.societyName)!).child((userFlatDetailValues?.apartmentName)!).child((userFlatDetailValues?.flatNumber)!).child(Constants.FIREBASE_CHILD_CABS).child(userUID!)
        
        
        //Mapping CabUID with true under UsersData -> Flat
        userDataCabRef?.child(cabUID!).setValue(NAString().gettrue())
        
        //Mapping Cab Number With  Cab UID
        cabsPrivateRef?.child(finalCabString).setValue(cabUID)
        
        let expectingCabData = [
            ArrivalListFBKeys.dateAndTimeOfArrival.key : txt_DateTime.text! as String?,
            ArrivalListFBKeys.inviterUID.key : userUID,
            ArrivalListFBKeys.reference.key : finalCabString,
            ArrivalListFBKeys.status.key :NAString().notEntered(),
            
            //TODO: Hardcoded valid For Button Value.
            ArrivalListFBKeys.validFor.key : "1 hr"
        ]
        //Adding data in Firebase from dictionary
        self.cabsPublicRef?.child(cabUID!).setValue(expectingCabData)
        //Calling Alert Function After Storing Data in Firebase
        inviteAlertView()
    }
    
    //Creating Function for Expecting Package Arrival
    func expectingPackageArrival() {
        
        //getting users Personal Detail Form Singaltone class
        let personalValue = Singleton_PersonalDetails.shared.personalDetails_Items
        let userPersonalValues = personalValue.first
        
        //getting users Flat Details Form Singaltone class
        let flatValues = Singleton_FlatDetails.shared.flatDetails_Items
        let userFlatDetailValues = flatValues.first
        
        packagePublicRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DELIVERIES).child(Constants.FIREBASE_USER_PUBLIC)
        
        //Generating Cab UID
        let packageUID : String?
        packageUID = (packagePublicRef?.childByAutoId().key)!
        
        packagePrivateRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DELIVERIES).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        userDataPackageRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child((userFlatDetailValues?.city)!).child((userFlatDetailValues?.societyName)!).child((userFlatDetailValues?.apartmentName)!).child((userFlatDetailValues?.flatNumber)!).child(Constants.FIREBASE_CHILD_DELIVERIES).child(userUID!)
        
        
        //Mapping PackageUID with true under UsersData -> Flat
        userDataPackageRef?.child(packageUID!).setValue(NAString().gettrue())
        
        //Mapping User Mobile Number With Package UID
        packagePrivateRef?.child((userPersonalValues?.phoneNumber)!).setValue(packageUID)
        
        let expectingPackageData = [
            ArrivalListFBKeys.dateAndTimeOfArrival.key : txt_DateTime.text! as String?,
            ArrivalListFBKeys.inviterUID.key : userUID,
            ArrivalListFBKeys.reference.key : txt_PackageVendor.text! as String,
            ArrivalListFBKeys.status.key :NAString().notEntered(),
            
            //TODO: Hardcoded valid For Button Value.
            ArrivalListFBKeys.validFor.key : "1 hr"
        ]
        //Adding data in Firebase from dictionary
        self.packagePublicRef?.child(packageUID!).setValue(expectingPackageData)
        //Calling Alert View Function After Storing Data in Firebase
        inviteAlertView()
    }
}


