//
//  EditMyProfileViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 01/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class EditMyProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profile_Image: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Mobile: UILabel!
    @IBOutlet weak var lbl_EmailID: UILabel!
    @IBOutlet weak var lbl_Otp_Description: UILabel!
    
    @IBOutlet weak var lbl_Picture_Validation: UILabel!
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mobile_Validation: UILabel!
    @IBOutlet weak var lbl_Email_Validation: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_Mobile: UITextField!
    @IBOutlet weak var txt_EmailId: UITextField!
    
    @IBOutlet weak var change_Admin_btn: UIButton!
    @IBOutlet weak var update_btn: UIButton!
    
    @IBOutlet weak var opacity_View: UIView!
    @IBOutlet weak var list_View: UIView!
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var search_TextField: UITextField!
    @IBOutlet weak var list_View_Height_Constraint: NSLayoutConstraint!
    
    @IBOutlet weak var scroll_View: UIScrollView!
    
    var myName: String = "Sundir Kumar"
    var myMobile: String = "8465945303"
    var myEmail: String = "talarisundir@gmail.com"
    var familyMembersList = ["Vikas Nayak", "Roshan", "Shivam", "Reshma", "Sri Latha", "Avinash", "Ashish Jha"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_Name.underlined()
        txt_Mobile.underlined()
        txt_EmailId.underlined()
        search_TextField.underlined()
        
        opacity_View.isHidden = true
        list_View.isHidden = true
        
        //textField Delegates
        txt_Name.delegate = self
        txt_Mobile.delegate = self
        txt_EmailId.delegate = self
        
        //tableView Delegates
        table_View.delegate = self
        table_View.dataSource = self
    
        //corner Radius For list View
        list_View.layer.cornerRadius = 10
    
        //removing separator lines programatically
        self.table_View.separatorStyle = .none
        
        lbl_Picture_Validation.isHidden = true
        lbl_Name_Validation.isHidden = true
        lbl_Mobile_Validation.isHidden = true
        lbl_Email_Validation.isHidden = true
        lbl_Otp_Description.isHidden = true
        update_btn.isHidden = true
        
        txt_Name.text = "Sundir Kumar"
        txt_Mobile.text = "8465945303"
        txt_EmailId.text = "talarisundir@gmail.com"
        
        //creating image round
        self.profile_Image.layer.cornerRadius = self.profile_Image.frame.size.width/2
        profile_Image.clipsToBounds = true
        
        //scrollView
        scroll_View.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        
        //tapGasture for upload new image
        profile_Image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.profile_Image.addGestureRecognizer(tapGesture)
        
        //Label formatting & setting
        lbl_Name.font = NAFont().headerFont()
        lbl_Mobile.font = NAFont().headerFont()
        lbl_EmailID.font = NAFont().headerFont()
        lbl_Name.text = NAString().name()
        lbl_Mobile.text = NAString().mobile()
        lbl_EmailID.text = NAString().email_id()
        
        lbl_Name_Validation.font = NAFont().descriptionFont()
        lbl_Mobile_Validation.font = NAFont().descriptionFont()
        lbl_Email_Validation.font = NAFont().descriptionFont()
        lbl_Picture_Validation.font = NAFont().descriptionFont()
        
        //Textfield formatting & setting
        txt_Name.font = NAFont().textFieldFont()
        txt_Mobile.font = NAFont().textFieldFont()
        txt_EmailId.font = NAFont().textFieldFont()
        
        //Button formatting & setting
        change_Admin_btn.backgroundColor = NAColor().buttonBgColor()
        change_Admin_btn.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        change_Admin_btn.titleLabel?.font = NAFont().buttonFont()
        update_btn.backgroundColor = NAColor().buttonBgColor()
        update_btn.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        update_btn.titleLabel?.font = NAFont().buttonFont()
        
        //Implemented Tap Gesture to resign PopUp Screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        opacity_View.addGestureRecognizer(tap)
        
        //Implemented to get data content size to change height based on data
        self.table_View.addObserver(self, forKeyPath: NAString().tableView_Content_size(), options: NSKeyValueObservingOptions.new, context: nil)
    }
    //For Resizing TableView based on content
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        table_View.layer.removeAllAnimations()
        list_View_Height_Constraint.constant = table_View.contentSize.height + 33
    }
    //tap Gesture method
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        list_View.isHidden = true
        opacity_View.isHidden = true
        self.view.endEditing(true)
    }
    //Function to appear select image from by tapping image
    @objc func imageTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: NAString().camera(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        })
        let actionGallery = UIAlertAction(title:NAString().gallery(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: NAString().cancel(), style: .cancel, handler: { (alert: UIAlertAction!) -> Void in })
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profile_Image.image = image
            lbl_Picture_Validation.isHidden = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func change_Admin_Action_Btn(_ sender: UIButton) {
        opacity_View.isHidden = false
        list_View.isHidden = false
        table_View.reloadData()
    }
    @IBAction func update_Action_Btn(_ sender: UIButton) {
    }
    //Email Validation Function
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if myName != txt_Name.text && myMobile.count == NAString().required_mobileNo_Length() && txt_EmailId.text == myEmail {
            update_btn.isHidden = false
        } else if  myName != txt_Name.text && myMobile.count != NAString().required_mobileNo_Length() && myEmail != txt_EmailId.text {
            update_btn.isHidden = false
            lbl_Otp_Description.isHidden = false
        } else if myName != txt_Name.text && myMobile.count != NAString().required_mobileNo_Length() && myEmail == txt_EmailId.text {
            update_btn.isHidden = false
        } else {
            update_btn.isHidden = true
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
           
                if textField == txt_Name {
                    if myName == updatedText {
                        update_btn.isHidden = true
                    } else {
                        update_btn.isHidden = false
                    }
                    if (newLength == NAString().zero_length()) {
                        lbl_Name_Validation.isHidden = false
                        txt_Name.redunderlined()
                        lbl_Name_Validation.text = NAString().please_enter_name()
                        update_btn.isHidden = true
                    } else if myName != updatedText {
                        lbl_Name_Validation.isHidden = true
                        txt_Name.underlined()
                        update_btn.isHidden = false
                    }
                }
                if textField == txt_EmailId {
                    let providedEmailAddress = txt_EmailId.text
                    let isEmailAddressIsValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
                    if myEmail == updatedText && isEmailAddressIsValid {
                        update_btn.isHidden = true
                        lbl_Email_Validation.isHidden = true
                        txt_EmailId.underlined()
                    } else {
                        update_btn.isHidden = false
                    }
                    if (newLength == NAString().zero_length()) {
                        lbl_Email_Validation.isHidden = false
                        txt_EmailId.redunderlined()
                        lbl_Email_Validation.text = NAString().please_enter_email()
                        update_btn.isHidden = true
                    } else if myEmail != updatedText && isEmailAddressIsValid {
                        lbl_Email_Validation.isHidden = true
                        txt_EmailId.underlined()
                        update_btn.isHidden = false
                    } else if !(isEmailAddressIsValid) {
                        lbl_Email_Validation.isHidden = false
                        txt_EmailId.redunderlined()
                        lbl_Email_Validation.text = NAString().please_enter_Valid_email()
                        update_btn.isHidden = true
                    }
                }
                if textField == txt_Mobile {
                    if newLength <= NAString().required_mobileNo_Length() {
                        if myMobile == updatedText && NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength) {
                            update_btn.isHidden = true
                        } else {
                            update_btn.isHidden = false
                        }
                        if NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength) {
                            lbl_Mobile_Validation.isHidden = true
                            txt_Mobile.underlined()
                            lbl_Otp_Description.isHidden = false
                        } else {
                            lbl_Mobile_Validation.isHidden = false
                            txt_Mobile.redunderlined()
                            update_btn.isHidden = true
                            lbl_Otp_Description.isHidden = true
                            lbl_Mobile_Validation.text = NAString().please_enter_10_digit_no()
                        }
                        if newLength == NAString().zero_length() {
                            lbl_Mobile_Validation.isHidden = false
                            txt_Mobile.redunderlined()
                            lbl_Mobile_Validation.text = NAString().please_enter_mobile_no()
                        }
                        if myMobile == updatedText {
                            lbl_Otp_Description.isHidden = true
                        }
                    }
                    //Check for Text Removal
                    if string.isEmpty {
                        return true
                    } else {
                        return newLength <= NAString().required_mobileNo_Length()
                    }
                }
        }
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyMembersList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! EditMyProfileTableViewCell
        cell.lbl_Family_Members_List.text = familyMembersList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertWithTitle()
    }
    func showAlertWithTitle() {
        let alertController = UIAlertController(title: "Alert Message", message: "Once you Click on Ok Button You will loose your Admin Access", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            self.list_View.isHidden = true
            self.opacity_View.isHidden = true
            self.change_Admin_btn.isHidden = true
        }
        let action2 = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
}
