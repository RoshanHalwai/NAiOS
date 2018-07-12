//
//  OTPViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class OTPViewController: NANavigationViewController {
    
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var txtOTP5: UITextField!
    @IBOutlet weak var txtOTP6: UITextField!
    @IBOutlet weak var lbl_OTP_Validation: UILabel!
    
    //to take data from add my services
    var newOtpString = String()
    
    //Creating varibale to get mobile number string from Login VC TextField.
    var getMobileString = String()
    var getCountryCodeString = String()
    var finalOTPString = String()
    
    //Creating Firebase DB Reference variable.
    var userMobileNumberRef : DatabaseReference?
    var isMobileValidRef : DatabaseReference?
    
    //Store verification ID
    var credentialID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding validation label
        lbl_OTP_Validation.isHidden = true

        //Calling trigger OTP function on viewDidLoad
        triggerOTPFromFirebase()

        
        //creating string to take OTP Description from Add my daily services according to service which user will select.
        self.lbl_OTPDescription.text = newOtpString
        
        //Button formatting & setting
        btnVerify.backgroundColor = NAColor().buttonBgColor()
        btnVerify.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnVerify.setTitle(NAString().verify_otp_button(), for: .normal)
        btnVerify.titleLabel?.font = NAFont().buttonFont()
        
        //Label formatting & setting
        lbl_OTPDescription.font = NAFont().headerFont()
        lbl_OTP_Validation.font = NAFont().descriptionFont()
        
        //Textfield formatting & setting
        txtOTP1.font = NAFont().textFieldFont()
        txtOTP2.font = NAFont().textFieldFont()
        txtOTP3.font = NAFont().textFieldFont()
        txtOTP6.font = NAFont().textFieldFont()
        txtOTP4.font = NAFont().textFieldFont()
        txtOTP5.font = NAFont().textFieldFont()
        
        //Hiding Btn Verify
        self.btnVerify.isHidden =  true
        
        //assigned delegate method on textFields
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        txtOTP5.delegate = self
        txtOTP6.delegate = self
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().phone_verification_activity_title())
        navigationItem.rightBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        //Set Textfield bottom border line
        txtOTP1.underlined()
        txtOTP2.underlined()
        txtOTP3.underlined()
        txtOTP4.underlined()
        txtOTP5.underlined()
        txtOTP6.underlined()
    }
    @IBAction func btnVerifyOTP(_ sender: Any) {
        
        if (lbl_OTPDescription.text == NAString().enter_verification_code(first: "your", second: "your")) {
            
            //Calling verify OTP function, When OTP Screen is Coming From Login VC.
            verifyOTPWithFirebase()
        }
        //Back to My Sweet Home screen
        else if(lbl_OTPDescription.text == NAString().enter_verification_code(first: "your Family Member", second: "their")) {
            let lv = NAViewPresenter().mySweetHomeVC()
            self.navigationController?.pushViewController(lv, animated: true)
        }
            //Back to My Daily Services Screen
        else {
            let lv = NAViewPresenter().myDailyServicesVC()
            self.navigationController?.pushViewController(lv, animated: true)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.isEmpty)! || !(textField.text?.isEmpty)! {
            lbl_OTP_Validation.isHidden = true
        }
        if (!string.isEmpty) {
            textField.text = string
            if textField == txtOTP1 {
                txtOTP2?.becomeFirstResponder()
            }
            else if textField == txtOTP2 {
                txtOTP3?.becomeFirstResponder()
            }
            else if textField == txtOTP3 {
                txtOTP4?.becomeFirstResponder()
            }
            else if textField == txtOTP4 {
                txtOTP5?.becomeFirstResponder()
            }
            else if textField == txtOTP5 {
                txtOTP6?.becomeFirstResponder()
            }
            else {
                txtOTP6?.becomeFirstResponder()
                self.btnVerify.isHidden = false
            }
            return false
        }
        else {
            if textField == txtOTP6 {
                txtOTP6?.text = ""
                txtOTP5.becomeFirstResponder()
            }
            else if textField == txtOTP5 {
                txtOTP5?.text = ""
                txtOTP4.becomeFirstResponder()
            }
            else if textField == txtOTP4 {
                txtOTP4?.text = ""
                txtOTP3.becomeFirstResponder()
            }
            else if textField == txtOTP3 {
                txtOTP3?.text = ""
                txtOTP2.becomeFirstResponder()
            }
            else if textField == txtOTP2 {
                txtOTP2?.text = ""
                txtOTP1.becomeFirstResponder()
            }
            else {
                txtOTP1?.text = ""
                textField.resignFirstResponder()
            }
            return false
        }
    }

    func Alert (Message: String) {
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    //Generating OTP From Firebase Authentication
    func triggerOTPFromFirebase() {
        //TODO: Printing Errors in Console so that other developers can understand.
        PhoneAuthProvider.provider().verifyPhoneNumber(getCountryCodeString + getMobileString, uiDelegate: nil) { (verificationID, error) in
            if ((error) != nil) {
                // IF verification code not sent.
                print(error as Any)
            } else {
                print("verificatinCode",verificationID as Any)
                self.credentialID = verificationID!
            }
        }
    }
}

//Created Extension for Verify OTP Function.
extension OTPViewController {
    
    func verifyOTPWithFirebase() {
        
        //Assigning OTP TextFields To Variables.
        let Otp_Strig1 = self.txtOTP1.text!
        let Otp_Strig2 = self.txtOTP2.text!
        let Otp_Strig3 = self.txtOTP3.text!
        let Otp_Strig4 = self.txtOTP4.text!
        let Otp_Strig5 = self.txtOTP5.text!
        let Otp_Strig6 = self.txtOTP6.text!
        
        //Concatinating all the OTP String variables to get Final String.
        finalOTPString = Otp_Strig1 + Otp_Strig2 + Otp_Strig3 + Otp_Strig4 + Otp_Strig5 + Otp_Strig6
        
        //Creating Credential variable to check correct OTP String.
        let Credentials  = PhoneAuthProvider.provider().credential(withVerificationID: self.credentialID, verificationCode: self.finalOTPString)
        
        //If OTP is Valid then Login Sucess else show Error message in Console
        //TODO: Priniting Errors in Console so that other developer can identify that whats going on.
        Auth.auth().signInAndRetrieveData(with: Credentials) { (authResult, error) in
            if Reachability.Connection() {
                if let error = error {
                    print("error",error.localizedDescription)
                    self.lbl_OTP_Validation.isHidden = false
                    self.lbl_OTP_Validation.text = NAString().incorrect_otp()
                    return
                }
            } else {
                self.Alert(Message: NAString().connectivity_Validation())
            }
            
            //Once verified we check if user mobile number exists under users->all
            self.isMobileValidRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_ALL).child(self.getMobileString)
            
            // Maping Mobile Number with UID & Storing in Users/All
            self.userMobileNumberRef?.child(self.getMobileString).setValue(usersUID)

            self.isMobileValidRef?.observeSingleEvent(of: .value, with: { snapshot in
                //If Data Exists into Firebase then navigate to Namma Apartment Home Screen.
                if snapshot.exists() {
                    let dest = NAViewPresenter().mainScreenVC()
                    self.navigationController?.pushViewController(dest, animated: true)
                } else {
                    //Else navigating to Sign Up screen for allowing them to create New User.
                    let dest = NAViewPresenter().signupVC()
                    dest.getNewMobileString = self.getMobileString
                    self.navigationController?.pushViewController(dest, animated: true)
                }
            })
        }
    }
}
