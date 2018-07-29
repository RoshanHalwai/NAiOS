//
//  signupViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

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

class SignupViewController: NANavigationViewController {
    
    @IBOutlet weak var signupScrollView : UIScrollView!
    
    @IBOutlet weak var signup_TxtFullName: UITextField!
    @IBOutlet weak var signup_TxtEmailId: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var btnSignup: UIButton!
    
    @IBOutlet weak var lbl_TermsCondition: UILabel!
    @IBOutlet weak var lbl_Fullname: UILabel!
    @IBOutlet weak var lbl_EmailId: UILabel!
    
    @IBOutlet weak var lbl_Image_Validation: UILabel!
    @IBOutlet weak var lbl_FullName_Validation: UILabel!
    @IBOutlet weak var lbl_Email_Validation: UILabel!
    
    //To getMobileString from Previous Screen (OTP View Controller)
    var getNewMobileString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Name textfield first letter capital
        signup_TxtFullName.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        //Add border color on profile imageview
        profileImage.layer.borderColor = UIColor.black.cgColor
        
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
        lbl_TermsCondition.font = NAFont().popupViewFont()
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
        
        //scrollView
        signupScrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
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
        
        //Hiding Navigation bar Back Button
        self.navigationItem.hidesBackButton = true
        
        //set Title to Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().signup())
        navigationItem.rightBarButtonItem = nil
        navigationItem.backBarButtonItem = nil
    }
    
    //Create name textfield first letter capital function
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    @IBAction func signup_BtnSignup(_ sender: Any) {
        let providedEmailAddress = signup_TxtEmailId.text
        let isEmailAddressIsValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        if profileImage.image == #imageLiteral(resourceName: "ExpectingVisitor") {
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
        }
        if !(signup_TxtEmailId.text?.isEmpty)! {
            if isEmailAddressIsValid {
                lbl_Email_Validation.isHidden = true
                signup_TxtEmailId.underlined()
            } else {
                lbl_Email_Validation.isHidden = false
                lbl_Email_Validation.text = NAString().please_enter_Valid_email()
                signup_TxtEmailId.redunderlined()
            }
        }
        if profileImage.image != #imageLiteral(resourceName: "ExpectingVisitor") && !(signup_TxtFullName.text?.isEmpty)! && isEmailAddressIsValid == true {
            
            //Navigation to MyFlatDetail Screen With Personal Details Data.
            let dest = NAViewPresenter().myFlatDEtailsVC()
            dest.title = NAString().My_flat_Details_title()
            dest.newProfileImage = self.profileImage.image
            dest.newMobileNumber = self.getNewMobileString
            dest.newEmail = self.signup_TxtEmailId.text!
            dest.newFullName = self.signup_TxtFullName.text!
            self.navigationController?.pushViewController(dest, animated: true)
        }
    }
}
extension SignupViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
        
        if textField == signup_TxtFullName {
            lbl_FullName_Validation.isHidden = true
            signup_TxtFullName.underlined()
        }
        if textField == signup_TxtEmailId {
            lbl_Email_Validation.isHidden = true
            signup_TxtEmailId.underlined()
        }
        return true
    }
}
