//
//  loginViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class loginViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide Signup button
        self.btnSignup.isHidden = true
        
        //Button formatting & setting
        btnSignup.titleLabel?.font = NAFont().buttonFont()
        btnLogin.titleLabel?.font = NAFont().buttonFont()
        btnLogin.backgroundColor = NAColor().buttonBgColor()
        btnLogin.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnLogin.setTitle(NAString().login_button(), for: .normal)
        
        //Label formatting & setting
        lbl_MobileNo.font = NAFont().headerFont()
        lbl_MobileNo.text = NAString().phone_numbe()
        
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
         self.navigationItem.title = "LOGIN"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSignup(_ sender: Any)
    {
        let lv : signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupViewController
        
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    @IBAction func btnSignin(_ sender: Any)
    {
        let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
        
        let otpString = NAString().enter_verification_code()
        lv.newOtpString = otpString
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
}
