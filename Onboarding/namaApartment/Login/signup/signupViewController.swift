//
//  signupViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

//To create UnderLine for Textfield
extension UITextField{
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func redunderlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.red.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
class signupViewController: NANavigationViewController {
    @IBOutlet weak var signupScrollView : UIScrollView!
    
    @IBOutlet weak var signup_TxtFullName: UITextField!
    @IBOutlet weak var signup_TxtEmailId: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var lbl_TermsCondition: UILabel!
    @IBOutlet weak var lbl_Fullname: UILabel!
    @IBOutlet weak var lbl_EmailId: UILabel!
    
    @IBOutlet weak var lbl_Image_Validation: UILabel!
    @IBOutlet weak var lbl_FullName_Validation: UILabel!
    @IBOutlet weak var lbl_Email_Validation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Error Labels
        lbl_FullName_Validation.isHidden = true
        lbl_Email_Validation.isHidden = true
        lbl_Image_Validation.isHidden = true
        
        //assigned delegate method on textFields
        signup_TxtEmailId.delegate = self
        signup_TxtFullName.delegate = self
        
        //Label formatting & setting
        lbl_Fullname.font = NAFont().headerFont()
        lbl_EmailId.font = NAFont().headerFont()
        lbl_TermsCondition.font = NAFont().descriptionFont()
        lbl_Fullname.text = NAString().full_name()
        lbl_EmailId.text = NAString().email_id()
        lbl_TermsCondition.text = NAString().i_agree_to_terms_and_conditions()
        
        lbl_Image_Validation.font = NAFont().descriptionFont()
        lbl_Email_Validation.font = NAFont().descriptionFont()
        lbl_FullName_Validation.font = NAFont().descriptionFont()
        
        //Textfield formatting & setting
        signup_TxtFullName.font = NAFont().textFieldFont()
        signup_TxtEmailId.font = NAFont().textFieldFont()
        
        //Button formatting & setting
        btnSignup.backgroundColor = NAColor().buttonBgColor()
        btnSignup.setTitle(NAString().signup(), for: .normal)
        btnSignup.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnSignup.titleLabel?.font = NAFont().buttonFont()
        btnLogin.backgroundColor = UIColor.white
        btnLogin.setTitle(NAString().i_already_have_an_account(), for: .normal)
        
        //scrollView
        signupScrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
        //tapGasture for upload new image
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.profileImage.addGestureRecognizer(tapGesture)
        
        //creating image round
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        //Set Textfield bottom border line
        signup_TxtFullName.underlined()
        signup_TxtEmailId.underlined()
    
        //Become First Responder
        signup_TxtFullName.becomeFirstResponder()
        
        //Hiding Navigation bar Back Button
         self.navigationItem.hidesBackButton = true
        
        //set Title to Navigation Bar
         super.ConfigureNavBarTitle(title: NAString().signup())
        navigationItem.rightBarButtonItem = nil
        navigationItem.backBarButtonItem = nil
    }
    @IBAction func signup_BtnSignup(_ sender: Any) {
        let providedEmailAddress = signup_TxtEmailId.text
        let isEmailAddressIsValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        
        if profileImage.image == #imageLiteral(resourceName: "imageIcon") {
            lbl_Image_Validation.isHidden = false
            lbl_Image_Validation.text = NAString().please_upload_Image()
        }
        if (signup_TxtFullName.text?.isEmpty)! {
            lbl_FullName_Validation.isHidden = false
            lbl_FullName_Validation.text = NAString().please_enter_name()
            signup_TxtFullName.redunderlined()
        } else {
            lbl_FullName_Validation.isHidden = true
            signup_TxtFullName.underlined()
        }
        if (signup_TxtEmailId.text?.isEmpty)! {
            lbl_Email_Validation.isHidden = false
            lbl_Email_Validation.text = NAString().please_enter_email()
            signup_TxtEmailId.redunderlined()
        } else {
            lbl_Email_Validation.isHidden = true
            signup_TxtEmailId.underlined()
        }
        if profileImage.image != #imageLiteral(resourceName: "imageIcon") && !(signup_TxtFullName.text?.isEmpty)! && isEmailAddressIsValid == true {
            let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        }
        if !(signup_TxtEmailId.text?.isEmpty)! && !(signup_TxtFullName.text?.isEmpty)! {
            if isEmailAddressIsValid {
                lbl_Email_Validation.isHidden = true
                signup_TxtEmailId.underlined()
            } else {
                lbl_Email_Validation.isHidden = false
                lbl_Email_Validation.text = NAString().please_enter_Valid_email()
                signup_TxtEmailId.redunderlined()
            }
        }
    }
    @IBAction func signup_BtnLogin(_ sender: UIButton) {
        let lv : loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginViewController
       self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
}
extension signupViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //Function to appear select image from by tapping image
    @objc func imageTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: NAString().camera(), style: .default, handler: {
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
        let cancel = UIAlertAction(title: NAString().cancel(), style: .cancel, handler: { (alert: UIAlertAction!) -> Void in })
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = image
            lbl_Image_Validation.isHidden = true
        }
        self.dismiss(animated: true, completion: nil)
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        if textField == signup_TxtFullName {
            if (newLength == NAString().zero_length()) {
                lbl_FullName_Validation.isHidden = false
                signup_TxtFullName.redunderlined()
                lbl_FullName_Validation.text = NAString().please_enter_name()
            } else {
                lbl_FullName_Validation.isHidden = true
                signup_TxtFullName.underlined()
            }
        }
        if textField == signup_TxtEmailId {
            if (newLength == NAString().zero_length()) {
                lbl_Email_Validation.isHidden = false
                signup_TxtEmailId.redunderlined()
                lbl_Email_Validation.text = NAString().please_enter_email()
            } else {
                lbl_Email_Validation.isHidden = true
                signup_TxtEmailId.underlined()
            }
        }
        return true
    }
}