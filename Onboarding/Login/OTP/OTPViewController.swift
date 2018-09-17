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

/* - AlertvieDelegate Protocol is passing the data to mainviewcontroller.
 - activityIndicator_function : used to display the popup & alertvie with resepect time.
 - Global variable to store users UID. */

protocol AlertViewDelegate {
    func activityIndicator_function(withData : Any)
}
var userUID = ""

class OTPViewController: NANavigationViewController {
    
    var delegateData : DataPass!
    var familyDelegateData : FamilyDataPass!
    
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var txtOTP5: UITextField!
    @IBOutlet weak var txtOTP6: UITextField!
    @IBOutlet weak var lbl_OTP_Validation: UILabel!
    @IBOutlet weak var lbl_ShowTimer: UILabel!
    @IBOutlet weak var lbl_WaitingForOTP: UILabel!
    
    /* - To take data from add my services.
     - Creating varibale to get mobile number string from Login VC TextField and Firebase DB Reference variable.
     - Store verification ID.
     - Create Alert View Delegate Object. */
    
    //To take data from add my services
    var newOtpString = String()
    var dailyServiceType = String()
    var familyMemberType = String()
    
    var getMobileString = String()
    var getCountryCodeString = String()
    var finalOTPString = String()
    
    var userMobileNumberRef : DatabaseReference?
    var mobileNumberValidRef : DatabaseReference?
    
    var credentialID = String()
    var delegate : AlertViewDelegate?
    
    //Created variables for timer functionality
    var countdownTimer: Timer!
    var totalTime = 120
    var timeisOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* - Hiding validation label and tn Verify.
         - Calling trigger OTP function on viewDidLoad.
         - Creating string to take OTP Description from Add my daily services according to service which user will select.
         - Button,Label,Textfield,Navigation Bar formatting & setting.
         - Assigned delegate method on textFields and Set Textfield bottom border line. */
        
        lbl_OTP_Validation.isHidden = true
        triggerOTPFromFirebase()
        self.lbl_OTPDescription.text = newOtpString
        
        btnVerify.backgroundColor = NAColor().buttonBgColor()
        btnVerify.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnVerify.setTitle(NAString().verify_otp_button(), for: .normal)
        btnVerify.titleLabel?.font = NAFont().buttonFont()
        
        lbl_OTPDescription.font = NAFont().headerFont()
        lbl_OTP_Validation.font = NAFont().descriptionFont()
        
        txtOTP1.font = NAFont().textFieldFont()
        txtOTP2.font = NAFont().textFieldFont()
        txtOTP3.font = NAFont().textFieldFont()
        txtOTP6.font = NAFont().textFieldFont()
        txtOTP4.font = NAFont().textFieldFont()
        txtOTP5.font = NAFont().textFieldFont()
        
        self.btnVerify.isHidden =  true
        
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        txtOTP5.delegate = self
        txtOTP6.delegate = self
        
        super.ConfigureNavBarTitle(title: NAString().phone_verification_activity_title())
        navigationItem.rightBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        txtOTP1.underlined()
        txtOTP2.underlined()
        txtOTP3.underlined()
        txtOTP4.underlined()
        txtOTP5.underlined()
        txtOTP6.underlined()
        
        //Start timer on View load
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        timeisOn = true
        
        //Performing action on Change Mobile Number Function
        let tapChangeMobile = UITapGestureRecognizer(target: self, action: #selector(tapChangeMobileNumber))
        lbl_ShowTimer.isUserInteractionEnabled = true
        lbl_ShowTimer.addGestureRecognizer(tapChangeMobile)
        
        //Performing action on Resend OTP Function
        let tapResendOTP = UITapGestureRecognizer(target: self, action: #selector(tapResend))
        lbl_WaitingForOTP.isUserInteractionEnabled = true
        lbl_WaitingForOTP.addGestureRecognizer(tapResendOTP)
    }
    
    //Resend OTP Action
    @objc func tapResend(sender:UITapGestureRecognizer) {
        if lbl_WaitingForOTP.text == NAString().resendOTP() {
            //Generating OTP again & again changing Text of lables
            lbl_WaitingForOTP.text = NAString().waitingForOTP()
            
            //resetting Time
            totalTime = 120
            lbl_ShowTimer.text = "\(timeFormatted(totalTime))"
            timeisOn = true
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            triggerOTPFromFirebase()
        }
    }
    
    //Craeted Functions for getting timer count
    @objc func updateTime() {
        lbl_WaitingForOTP.text = NAString().waitingForOTP()
        lbl_ShowTimer.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
            timeisOn = false
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        timeisOn = false
        lbl_WaitingForOTP.text = NAString().resendOTP()
        lbl_ShowTimer.text = NAString().changeMobileNumber()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    //Change Mobile number Action (navigating back to Login Screen)
    @objc func tapChangeMobileNumber(sender:UITapGestureRecognizer) {
        if lbl_ShowTimer.text == NAString().changeMobileNumber() {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnVerifyOTP(_ sender: Any) {
        
        btnVerify.tag = NAString().verifyOTPButtonTagValue()
        OpacityView.shared.addButtonTagValue = btnVerify.tag
        
        //Assigning OTP TextFields To Variables.
        let Otp_Strig1 = self.txtOTP1.text!
        let Otp_Strig2 = self.txtOTP2.text!
        let Otp_Strig3 = self.txtOTP3.text!
        let Otp_Strig4 = self.txtOTP4.text!
        let Otp_Strig5 = self.txtOTP5.text!
        let Otp_Strig6 = self.txtOTP6.text!
        
        //Concatinating all the OTP String variables to get Final String.
        finalOTPString = Otp_Strig1 + Otp_Strig2 + Otp_Strig3 + Otp_Strig4 + Otp_Strig5 + Otp_Strig6
        
        if (lbl_OTPDescription.text == NAString().enter_verification_code(first: "your", second: "your")) {
            
            /* - Calling verify OTP function, When OTP Screen is Coming From Login VC.
             - Back to My Sweet Home screen and My Daily Services Screen. */
            
            verifyOTPWithFirebase()
        }
        //Back to My Sweet Home screen
        if(lbl_OTPDescription.text == self.familyMemberType) {
            //Creating Credential variable to check correct OTP String.
            let Credentials  = PhoneAuthProvider.provider().credential(withVerificationID: self.credentialID, verificationCode: self.finalOTPString)
            
            //If OTP is Valid then Login Sucess else show Error message in Console
            //TODO: Priniting Errors in Console so that other developer can identify that whats going on.
            Auth.auth().signInAndRetrieveData(with: Credentials) { (authResult, error) in
                if let error = error {
                    print("error",error.localizedDescription)
                    self.lbl_OTP_Validation.isHidden = false
                    self.lbl_OTP_Validation.text = NAString().incorrect_otp()
                    return
                } else {
                    //Setting delegete for after verifying OTP It will stores the daily Service Data in Firebase & navigating back to Add My daily Service Screen.
                    self.familyDelegateData.familydataPassing()
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.activityIndicator_function(withData: (Any).self)              }
            }
        }
        //Back to My Daily Services Screen
        if (lbl_OTPDescription.text ==  NAString().enter_verification_code(first: "your \(self.dailyServiceType)", second: "their"))  {
            
            //Creating Credential variable to check correct OTP String.
            let Credentials  = PhoneAuthProvider.provider().credential(withVerificationID: self.credentialID, verificationCode: self.finalOTPString)
            
            //If OTP is Valid then Login Sucess else show Error message in Console
            //TODO: Priniting Errors in Console so that other developer can identify that whats going on.
            Auth.auth().signInAndRetrieveData(with: Credentials) { (authResult, error) in
                if let error = error {
                    print("error",error.localizedDescription)
                    self.lbl_OTP_Validation.isHidden = false
                    self.lbl_OTP_Validation.text = NAString().incorrect_otp()
                    return
                } else {
                    //Setting delegete for after verifying OTP It will stores the daily Service Data in Firebase & navigating back to Add My daily Service Screen.
                    self.delegateData.dataPassing()
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.activityIndicator_function(withData: (Any).self)                }
            }
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
                txtOTP6?.resignFirstResponder()
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
    
    /* - Generating OTP From Firebase Authentication.
     - IF verification code not sent. */
    
    func triggerOTPFromFirebase() {
        //TODO: Printing Errors in Console so that other developers can understand.
        PhoneAuthProvider.provider().verifyPhoneNumber(getCountryCodeString + getMobileString, uiDelegate: nil) { (verificationID, error) in
            if ((error) != nil) {
                
                print(error as Any)
            } else {
                print("verificatinCode",verificationID as Any)
                self.credentialID = verificationID!
            }
        }
    }
}

/* - Created Extension for Verify OTP Function and Credential variable to check correct OTP String.
 - Assigning OTP TextFields To Variables.
 - Concatinating all the OTP String variables to get Final String.
 - Once verified we check if user mobile number exists under users->all.
 - Maping Mobile Number with UID & Storing in Users/All.
 - If Data Exists into Firebase then navigate to Namma Apartment Home Screen.
 - Else navigating to Sign Up screen for allowing them to create New User. */

extension OTPViewController {
    
    func verifyOTPWithFirebase() {
        
        //Showing Please wait PopUpView while while Verifying OTP
        OpacityView.shared.showingOpacityView(view: self)
        OpacityView.shared.showingPopupView(view: self)
        
        let Otp_Strig1 = self.txtOTP1.text!
        let Otp_Strig2 = self.txtOTP2.text!
        let Otp_Strig3 = self.txtOTP3.text!
        let Otp_Strig4 = self.txtOTP4.text!
        let Otp_Strig5 = self.txtOTP5.text!
        let Otp_Strig6 = self.txtOTP6.text!
        
        finalOTPString = Otp_Strig1 + Otp_Strig2 + Otp_Strig3 + Otp_Strig4 + Otp_Strig5 + Otp_Strig6
        
        let Credentials  = PhoneAuthProvider.provider().credential(withVerificationID: self.credentialID, verificationCode: self.finalOTPString)
        
        //If OTP is Valid then Login Sucess else show Error message in Console
        //TODO: Priniting Errors in Console so that other developer can identify that whats going on.
        Auth.auth().signInAndRetrieveData(with: Credentials) { (authResult, error) in
            if Reachability.Connection() {
                if let error = error {
                    print("error",error.localizedDescription)
                    OpacityView.shared.hidingOpacityView()
                    OpacityView.shared.hidingPopupView()
                    self.lbl_OTP_Validation.isHidden = false
                    self.lbl_OTP_Validation.text = NAString().incorrect_otp()
                    return
                }
            } else {
                self.Alert(Message: NAString().connectivity_Validation())
            }
            
            self.mobileNumberValidRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_ALL).child(self.getMobileString)
            
            self.userMobileNumberRef?.child(self.getMobileString).setValue(userUID)
            
            self.mobileNumberValidRef?.observeSingleEvent(of: .value, with: { snapshot in
                
                if snapshot.exists() {
                    
                    let userUID = Auth.auth().currentUser?.uid
                    let userActivationRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID!).child(Constants.FIREBASE_CHILD_PRIVILEGES).child(Constants.FIREBASE_CHILD_VERIFIED)
                    
                    //Navigate to NAHome or Activation Requried Screen According to verified value.
                    userActivationRef.observeSingleEvent(of: .value, with: { (activationSnapshot) in
                        let verified = activationSnapshot.value as! Int
                        
                        if verified == 0 {
                            let dest = NAViewPresenter().activationRequiredVC()
                            self.navigationController?.pushViewController(dest, animated: true)
                        } else {
                            let dest = NAViewPresenter().mainScreenVC()
                            self.navigationController?.pushViewController(dest, animated: true)
                        }
                    })
                } else {
                    let dest = NAViewPresenter().signupVC()
                    dest.getNewMobileString = self.getMobileString
                    self.navigationController?.pushViewController(dest, animated: true)
                }
            })
        }
    }
}
