//
//  loginViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class loginViewController: NANavigationViewController
{
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var lbl_Validation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigned delegate method on textFields
        txt_MobileNo.delegate = self
        txt_CountryCode.delegate = self
        
       //hide Signup button
       self.btnSignup.isHidden = true

        //hide validation label
        lbl_Validation.isHidden = true
       
        //Button formatting & setting
        btnSignup.titleLabel?.font = NAFont().buttonFont()
        btnLogin.titleLabel?.font = NAFont().buttonFont()
        btnLogin.backgroundColor = NAColor().buttonBgColor()
        btnLogin.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnLogin.setTitle(NAString().login_button(), for: .normal)
        
        //Label formatting & setting
        lbl_MobileNo.font = NAFont().headerFont()
        lbl_MobileNo.text = NAString().phone_numbe()
        lbl_Validation.font = NAFont().descriptionFont()
        
        //TextField formatting & setting
        txt_MobileNo.font = NAFont().textFieldFont()
        txt_CountryCode.font = NAFont().textFieldFont()
        txt_CountryCode.text = NAString()._91()
        
        //become First Responder
          self.txt_MobileNo?.becomeFirstResponder()
        
        //Set Textfield bottom border line
        txt_MobileNo.underlined()

       //Hiding Navigation bar Back Button
         self.navigationItem.hidesBackButton = true
        
        //set Title to Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().login_button())
       // navigationItem.title = ""
        navigationItem.rightBarButtonItem = nil
        //navigationItem.backBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func btnSignup(_ sender: Any)
    {
        let lv = NAViewPresenter().signupVC()
        self.navigationController?.pushViewController(lv, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }
    
    //Accept only 10 digit mobile number in MobileNumber TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        if ((txt_MobileNo.text) == "")
        {
            lbl_Validation.isHidden = true
            txt_MobileNo.underlined()
        }
        else if((txt_MobileNo.text?.count) != 10){
            lbl_Validation.isHidden = true
            txt_MobileNo.underlined()
        }
        return newLength < 11 // Bool
    }
    
    @IBAction func btnSignin(_ sender: Any) {
        
        //Provide Validation Functionality on button click
        lbl_Validation.isHidden = true
        
        if (self.txt_MobileNo.text == "")
        {
            lbl_Validation.isHidden = false
            lbl_Validation.text = NAString().please_enter_mobile_no()
            txt_MobileNo.redunderlined()
        }
        else if ((txt_MobileNo.text?.count)! < 10)
        {
            lbl_Validation.isHidden = false
            lbl_Validation.text =  NAString().please_enter_10_digit_no()
            txt_MobileNo.redunderlined()
        }
        else if ((txt_MobileNo.text?.count)! == 10) {
            do {
                let lv = NAViewPresenter().otpViewController()
                let otpString = NAString().enter_verification_code(first: "your", second: "your")
                lv.newOtpString = otpString
                self.navigationController?.setNavigationBarHidden(false, animated: true);
                self.navigationController?.pushViewController(lv, animated: true)
            }
        }
    }
}


