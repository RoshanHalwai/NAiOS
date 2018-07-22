//
//  AddMyDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class AddMyServicesViewController: NANavigationViewController, CNContactPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,AlertViewDelegate
{
    @IBOutlet weak var img_Profile: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_OR: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mobile_Validation: UILabel!
    @IBOutlet weak var lbl_Picture_Validation: UILabel!
    @IBOutlet weak var lbl_Date_Validation: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_Date: UITextField!
    
    @IBOutlet weak var btn_SelectContact: UIButton!
    @IBOutlet weak var btn_AddDetails: UIButton!
    
    @IBOutlet weak var stackView_InTime: UIStackView!
    
    var timer = Timer()
    var count = 5
    
    /* * To set navigation title.
     * Gettig data from previous screen string.
     * To check from which view value is comming.
     * Created date picker programtically.
     * Scrollview. */
    
    var navTitle: String?
    
    var AddOtpString = String()
    
    var vcValue = String()
    
    let picker = UIDatePicker()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* * Create Name textfield first letter capital.
         * Add border color on profile imageview.
         * Hiding error labels.
         * Assigned delegate method on textFields.
         * Identify screen coming from which screen.
         * Adding image on date TextField.
         * Setting navigation title.
         * TapGasture for upload new image.
         * ScrollView.
         * Calling datePicker.
         * Set local date to Europe to show 24 hours.
         * Black underline for textfileds.
         * Label formatting & setting.
         * TextField formatting & setting.
         * Button formatting & setting..
         * Creating round Image usig Corner radius. */
        
        txt_Name.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        img_Profile.layer.borderColor = UIColor.black.cgColor
        
        lbl_Name_Validation.isHidden = true
        lbl_Mobile_Validation.isHidden = true
        lbl_Picture_Validation.isHidden = true
        lbl_Date_Validation.isHidden = true
        
        txt_Name.delegate = self
        txt_CountryCode.delegate = self
        txt_MobileNo.delegate = self
        txt_Date.delegate = self
        
        screenComingFrom()
        
        txt_Date.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_Date.rightView = imageView
        
        super.ConfigureNavBarTitle(title: navTitle!)
        
        img_Profile.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.img_Profile.addGestureRecognizer(tapGesture)
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 210, 0)
        
        createDatePicker()
        
        picker.locale = Locale(identifier: "en_GB")
        
        txt_Date.underlined()
        txt_Name.underlined()
        txt_MobileNo.underlined()
        
        self.lbl_OR.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_Date.font = NAFont().headerFont()
        self.lbl_OTPDescription.font = NAFont().descriptionFont()
        self.lbl_Name_Validation.font = NAFont().descriptionFont()
        self.lbl_Mobile_Validation.font = NAFont().descriptionFont()
        self.lbl_Picture_Validation.font = NAFont().descriptionFont()
        self.lbl_Date_Validation.font = NAFont().descriptionFont()
        
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        
        self.txt_Date.font = NAFont().textFieldFont()
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().headerFont()
        self.txt_CountryCode.text = NAString()._91()
        
        self.btn_SelectContact.backgroundColor = NAColor().buttonBgColor()
        self.btn_SelectContact.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_SelectContact.setTitle(NAString().BtnselectFromContact().capitalized, for: .normal)
        
        self.btn_AddDetails.backgroundColor = NAColor().buttonBgColor()
        self.btn_AddDetails.setTitle(NAString().add().uppercased(), for: .normal)
        self.btn_AddDetails.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        self.btn_SelectContact.titleLabel?.font = NAFont().buttonFont()
        self.btn_AddDetails.titleLabel?.font = NAFont().buttonFont()
        
        self.img_Profile.layer.cornerRadius = self.img_Profile.frame.size.width/2
        img_Profile.clipsToBounds = true
    }
    
    /* * Create name textfield first letter capital function.
     * Alert Popup when user give  grant access & try to add details.
     * Showing alert controller while giving Grant Access to family members.
     * Creating Reject alert actions.
     * Creating Accept alert actions.
     * Function to appear select image from by tapping image.
     * For datePicker.
     * Toolbar.
     * Done button for toolbar.
     * Format picker for date.
     * Format date. */
    
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    func grantAccessAlert() {
        
        let alert = UIAlertController(title:nil , message: NAString().edit_my_family_member_grantAccess_alertBox(first:NAString().granting_access()), preferredStyle: .alert)
        
        let rejectAction = UIAlertAction(title:NAString().reject(), style: .cancel) { (action) in }
        
        let acceptAction = UIAlertAction(title:NAString().accept(), style: .default) { (action) in
            let lv = NAViewPresenter().otpViewController()
            let familyString = NAString().enter_verification_code(first: "your Family Member", second: "their")
            lv.newOtpString = familyString
            self.navigationController?.pushViewController(lv, animated: true)
        }
        alert.addAction(rejectAction)
        alert.addAction(acceptAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func imageTapped() {
        let actionSheet = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title:NAString().camera(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        })
        let actionGallery = UIAlertAction(title:NAString().gallery(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title:NAString().cancel(), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in})
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_Profile.image = image
            lbl_Picture_Validation.isHidden = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_Date.inputAccessoryView = toolbar
        txt_Date.inputView = picker
        
        picker.datePickerMode = .time
    }
    
    @objc func donePressed() {
        
        let date = DateFormatter()
        date.dateFormat = NAString().timeFormat()
        let dateString = date.string(from: picker.date)
        txt_Date.text = dateString
        self.view.endEditing(true)
        
        lbl_Date_Validation.isHidden = true
        txt_Date.underlined()
    }
    
    /* * Open App Setting if user cannot able to access Contacts.
     * Creating alert controller.
     * To call default address book app.
     * User select any contact particular part.
     * Identify from which page screen is coming.
     * Retrive Data from AlertView Delegate.
     * Create Timer Function.
     * Create AlertView Action.
     * Create OK button.
     */
    
    @IBAction func btnSelectContact(_ sender: Any) {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        if authStatus == CNAuthorizationStatus.notDetermined {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, nil) in
                if success {
                    self.openContacts()
                }
            })
        } else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts()
        }
            
        else if authStatus == CNAuthorizationStatus.denied {
            
            let alert = UIAlertController(title: NAString().setting_Permission_AlertBox() , message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NAString().cancel(), style: .cancel) { (action) in }
            let settingAction = UIAlertAction(title: NAString().settings(), style: .default) { (action) in
                UIApplication.shared.open(URL(string: "App-prefs:root=Privacy")!)
            }
            alert.addAction(cancelAction)
            alert.addAction(settingAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openContacts() {
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        self.txt_Name.text = fullName
        
        var mobileNo = NAString().mobile_number_not_available()
        let mobileString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
        mobileNo = mobileString! as! String
        var mobileNumber = mobileNo.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
        
        if mobileNumber.count > NAString().required_mobileNo_Length() {
            let range1 = mobileNumber.characters.index(mobileNumber.startIndex, offsetBy: 2)..<mobileNumber.endIndex
            mobileNumber = String(mobileNumber[range1])
        }
        self.txt_MobileNo.text = mobileNumber
    }
    
    func screenComingFrom() {
        if self.navTitle == NAString().add_my_service() {
            self.lbl_Date.text = NAString().time()
            self.lbl_OTPDescription.text = NAString().inviteVisitorOTPDesc()
        }
    }
    
    func activityIndicator_function(withData: Any) {
        btn_AddDetails.tag = NAString().addMyDailyServicesButtonTagValue()
        OpacityView.shared.addButtonTagValue = btn_AddDetails.tag
        OpacityView.shared.showingPopupView(view: self)
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.stopTimer), userInfo: nil, repeats: true)
    }
    
    @objc func stopTimer() {
        OpacityView.shared.hidingPopupView()
        if (count >= 0){
            if(count == 0)
            {
                self.addAlertViewAction()
            }
            count -= 1
        }
    }
    
    func addAlertViewAction() {
        let alertController = UIAlertController(title:NAString().add_my_service(), message:NAString().addButtonloadViewMessage(), preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            let lv = NAViewPresenter().myDailyServicesVC()
            self.navigationController?.pushViewController(lv, animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    @IBAction func btnAddDetails(_ sender: Any) {
        if img_Profile.image == #imageLiteral(resourceName: "ExpectingVisitor") {
            lbl_Picture_Validation.isHidden = false
            lbl_Picture_Validation.text = NAString().please_upload_Image()
        }
        if (txt_Date.text?.isEmpty)! {
            lbl_Date_Validation.isHidden = false
            lbl_Date_Validation.text = NAString().Please_select_date()
            txt_Date.redunderlined()
        } else {
            lbl_Date_Validation.isHidden = true
            txt_Date.underlined()
        }
        if (txt_Name.text?.isEmpty)! {
            lbl_Name_Validation.isHidden = false
            lbl_Name_Validation.text = NAString().please_enter_name()
            txt_Name.redunderlined()
        } else {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if (txt_MobileNo.text?.isEmpty)! {
            lbl_Mobile_Validation.isHidden = false
            lbl_Mobile_Validation.text = NAString().please_enter_mobile_no()
            txt_MobileNo.redunderlined()
        } else if (!(txt_MobileNo.text?.isEmpty)!) && (txt_MobileNo.text?.count != NAString().required_mobileNo_Length()) {
            lbl_Mobile_Validation.isHidden = false
            txt_MobileNo.redunderlined()
            lbl_Mobile_Validation.text = NAString().please_enter_10_digit_no()
        } else if (txt_MobileNo.text?.count == NAString().required_mobileNo_Length()) {
            txt_MobileNo.underlined()
            lbl_Mobile_Validation.isHidden = true
        }
        if !(txt_Name.text?.isEmpty)! && !(txt_MobileNo.text?.isEmpty)! && !(txt_Date.text?.isEmpty)! && img_Profile.image != #imageLiteral(resourceName: "ExpectingVisitor") {
            if (navTitle! == NAString().add_my_service().capitalized) {
                let lv = NAViewPresenter().otpViewController()
                let familyString = NAString().enter_verification_code(first: "your cook", second: "their")
                lv.newOtpString = familyString
                lv.delegate = self
                self.navigationController?.pushViewController(lv, animated: true)
            }
        }
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_Name {
            txt_MobileNo.becomeFirstResponder()
        } else if textField == txt_MobileNo {
            txt_Date.becomeFirstResponder()
        }
        return true
    }
}

/* * Accept only 10 digit mobile number.
 * Check for Text Removal. */

extension AddMyServicesViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_Name {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if textField == txt_MobileNo {
            txt_MobileNo.underlined()
            lbl_Mobile_Validation.isHidden = true
            if NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength) {
            }
            if newLength >= NAString().required_mobileNo_Length() && !(txt_Name.text?.isEmpty)! && !(txt_Date.text?.isEmpty)! {
            }
            
            if string.isEmpty {
                return true
            } else {
                return newLength <= NAString().required_mobileNo_Length() // Bool
            }
        }
        return true
    }
}
