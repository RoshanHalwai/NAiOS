//
//  AddMyFamilyMembersViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 21/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import ContactsUI

class AddMyFamilyMembersViewController: NANavigationViewController, CNContactPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var img_Profile: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_OR: UILabel!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    @IBOutlet weak var lbl_Relation: UILabel!
    @IBOutlet weak var lbl_GrantAccess: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    @IBOutlet weak var superView: UIView!
    
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mobile_Validation: UILabel!
    @IBOutlet weak var lbl_Picture_Validation: UILabel!
    @IBOutlet weak var lbl_Email_Validation: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    
    @IBOutlet weak var btn_SelectContact: UIButton!
    @IBOutlet weak var btn_addDetails: UIButton!
    
    @IBOutlet weak var Relation_Segment: UISegmentedControl!
    @IBOutlet weak var grantAcess_Segment: UISegmentedControl!
    
    //scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
    var timer = Timer()
    var count = 5
    
    //to set navigation title
    var navTitle: String?
    
    //gettig data from previous screen string
    var AddOtpString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Name textfield first letter capital
        txt_Name.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        // Add border color on profile image
        img_Profile.layer.borderColor = UIColor.black.cgColor
        
        //hiding error labels
        lbl_Name_Validation.isHidden = true
        lbl_Mobile_Validation.isHidden = true
        lbl_Picture_Validation.isHidden = true
        lbl_Email_Validation.isHidden = true
        
        //assigned delegate method on textFields
        txt_Name.delegate = self
        txt_CountryCode.delegate = self
        txt_MobileNo.delegate = self
        txt_Email.delegate = self
        
        super.ConfigureNavBarTitle(title: navTitle!)
        self.navigationItem.title = ""
        
        //tapGasture for upload new image
        img_Profile.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.img_Profile.addGestureRecognizer(tapGesture)
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0)
        
        //black underline for textfileds
        txt_Name.underlined()
        txt_MobileNo.underlined()
        txt_Email.underlined()
        
        //label formatting & setting
        self.lbl_OR.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_OTPDescription.font = NAFont().descriptionFont()
        self.lbl_Relation.font = NAFont().headerFont()
        self.lbl_Email.font = NAFont().headerFont()
        self.lbl_GrantAccess.font = NAFont().headerFont()
        self.lbl_Name_Validation.font = NAFont().descriptionFont()
        self.lbl_Mobile_Validation.font = NAFont().descriptionFont()
        self.lbl_Picture_Validation.font = NAFont().descriptionFont()
        self.lbl_Email_Validation.font = NAFont().descriptionFont()
        self.lbl_OTPDescription.text = NAString().otp_message_family_member(name: "family Member")
        self.lbl_Relation.text = NAString().relation()
        self.lbl_GrantAccess.text = NAString().grant_access()
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        
        //textField formatting & setting
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_Email.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().headerFont()
        self.txt_CountryCode.text = NAString()._91()
        
        //button formatting & setting
        self.btn_SelectContact.backgroundColor = NAColor().buttonBgColor()
        self.btn_SelectContact.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_SelectContact.setTitle(NAString().BtnselectFromContact().capitalized, for: .normal)
        
        self.btn_addDetails.backgroundColor = NAColor().buttonBgColor()
        self.btn_addDetails.setTitle(NAString().add().uppercased(), for: .normal)
        self.btn_addDetails.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        self.btn_SelectContact.titleLabel?.font = NAFont().buttonFont()
        self.btn_addDetails.titleLabel?.font = NAFont().buttonFont()
        
        //creating round Image using Corner radius
        self.img_Profile.layer.cornerRadius = self.img_Profile.frame.size.width/2
        img_Profile.clipsToBounds = true
    }
    
    //Create name textfield first letter capital function
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    //Create RelationSegment Action
    @IBAction func relationSegmentAction() {
        if Relation_Segment.selectedSegmentIndex == 0 {
            lbl_OTPDescription.text = NAString().otp_message_family_member(name: "family Member")
        } else {
            lbl_OTPDescription.text = NAString().otp_message_family_member(name: "friends")
        }
    }
    
    //alert Popup when user give  grant access & try to add details
    func grantAccessAlert() {
        //showing alert controller while giving Grant Access to family members
        let alert = UIAlertController(title:nil , message: NAString().edit_my_family_member_grantAccess_alertBox(first:NAString().granting_access()), preferredStyle: .alert)
        
        //creating Reject alert actions
        let rejectAction = UIAlertAction(title:NAString().reject(), style: .cancel) { (action) in }
        
        //creating Accept alert actions
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
    
    //Function to appear select image from by tapping image
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
        }
        else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts()
        }
            //Open App Setting if user cannot able to access Contacts
        else if authStatus == CNAuthorizationStatus.denied {
            //creating alert controller
            let alert = UIAlertController(title: NAString().setting_Permission_AlertBox() , message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NAString().cancel(), style: .cancel) { (action) in }
            let settingAction = UIAlertAction(title: NAString().settings(), style: .default) { (action) in
                UIApplication.shared.open(URL(string: "App-prefs:root=Privacy")!) }
            alert.addAction(cancelAction)
            alert.addAction(settingAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    //to call default address book app
    func openContacts() {
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //user select any contact particular part
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
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_Name {
            txt_MobileNo.becomeFirstResponder()
        } else if textField == txt_MobileNo {
            txt_Email.becomeFirstResponder()
        }
        return true
    }
    
    @IBAction func btn_Action_addDetails(_ sender: UIButton) {
        let providedEmailAddress = txt_Email.text
        let isEmailAddressIsValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        if !(txt_Email.text?.isEmpty)! {
            if isEmailAddressIsValid {
                lbl_Email_Validation.isHidden = true
                txt_Email.underlined()
            } else {
                lbl_Email_Validation.isHidden = false
                lbl_Email_Validation.text = NAString().please_enter_Valid_email()
                txt_Email.redunderlined()
            }
        }
        if img_Profile.image == #imageLiteral(resourceName: "ExpectingVisitor") {
            lbl_Picture_Validation.isHidden = false
            lbl_Picture_Validation.text = NAString().please_upload_Image()
        }
        if (txt_Name.text?.isEmpty)! {
            lbl_Name_Validation.isHidden = false
            lbl_Name_Validation.text = NAString().please_enter_name()
            txt_Name.redunderlined()
        } else {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if (txt_Email.text?.isEmpty)! {
            lbl_Email_Validation.isHidden = false
            lbl_Email_Validation.text = NAString().please_enter_email()
            txt_Email.redunderlined()
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
        if !(txt_Name.text?.isEmpty)! && isEmailAddressIsValid == true && txt_MobileNo.text?.count == NAString().required_mobileNo_Length() && img_Profile.image != #imageLiteral(resourceName: "ExpectingVisitor") {
            if(grantAcess_Segment.selectedSegmentIndex == 0) {
                //calling AlertBox on click of YES
                grantAccessAlert()
            } else {
                btn_addDetails.tag = 103
                OpacityView.shared.addButtonTagValue = btn_addDetails.tag
                OpacityView.shared.showingPopupView(view: self)
                timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.stopTimer), userInfo: nil, repeats: true)
            }
        }
    }
    
    //Create Timer Function
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
    
    //Create AlertView Action
    func addAlertViewAction() {
        let alertController = UIAlertController(title:NAString().addFamilyMemberTitle(), message:NAString().addButtonloadViewMessage(), preferredStyle: .alert)
        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            let lv = NAViewPresenter().otpViewController()
            let familyString = NAString().enter_verification_code(first: "your Family Member", second: "their")
            lv.newOtpString = familyString
            self.navigationController?.pushViewController(lv, animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let validEmail = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let emailTextInput = try NSRegularExpression(pattern: validEmail)
            let emailString = emailAddressString as NSString
            let results = emailTextInput.matches(in: emailAddressString, range: NSRange(location: 0, length: emailString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch {
            returnValue = false
        }
        return  returnValue
    }
    
    //Accept only 10 digit mobile number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_Name {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if textField == txt_Email {
            lbl_Email_Validation.isHidden = true
            txt_Email.underlined()
        }
        if textField == txt_MobileNo {
            lbl_Mobile_Validation.isHidden = true
            txt_MobileNo.underlined()
            if NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength) {
            }
            //Check for Text Removal
            if string.isEmpty {
                return true
            } else {
                return newLength <= NAString().required_mobileNo_Length()
            }
        }
        return true
    }
}
