//
//  OTPViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var txtOTP5: UITextField!
    @IBOutlet weak var txtOTP6: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Button formatting & setting
        btnVerify.backgroundColor = NAColor().buttonBgColor()
        btnVerify.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnVerify.setTitle(NAString().verify_otp_button(), for: .normal)
        btnVerify.titleLabel?.font = NAFont().buttonFont()
        
        //Label formatting & setting
        lbl_OTPDescription.text = NAString().enter_verification_code()
        lbl_OTPDescription.font = NAFont().headerFont()
        
        //Textfield formatting & setting
        txtOTP1.font = NAFont().textFieldFont()
        txtOTP2.font = NAFont().textFieldFont()
        txtOTP3.font = NAFont().textFieldFont()
        txtOTP6.font = NAFont().textFieldFont()
        txtOTP4.font = NAFont().textFieldFont()
        txtOTP5.font = NAFont().textFieldFont()
        
        //Become First Responder
        self.txtOTP1?.becomeFirstResponder()
        
        //Hiding Btn Verify
        self.btnVerify.isHidden =  true
        
        //textfield set targetting for the responder to next textview
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        txtOTP5.delegate = self
        txtOTP6.delegate = self
        
        //hide back button
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "PHONE VERIFICATION"
        
        //Set Textfield bottom border line
        txtOTP1.underlined()
        txtOTP2.underlined()
        txtOTP3.underlined()
        txtOTP4.underlined()
        txtOTP5.underlined()
        txtOTP6.underlined()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnVerifyOTP(_ sender: Any)
    {
        let lv : MainScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainScreenVC") as! MainScreenViewController
        
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true
    }
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (!string.isEmpty)
        {
            textField.text = string
            
            if textField == txtOTP1
            {
                txtOTP2?.becomeFirstResponder()
            }
            
            else if textField == txtOTP2
            {
                txtOTP3?.becomeFirstResponder()
            }
                
            else if textField == txtOTP3
            {
                txtOTP4?.becomeFirstResponder()
            }
            
            else if textField == txtOTP4
            {
                txtOTP5?.becomeFirstResponder()
            }
            
            else if textField == txtOTP5
            {
                txtOTP6?.becomeFirstResponder()
            }
            
            else
            {
                txtOTP6?.becomeFirstResponder()
                self.btnVerify.isHidden = false
            }
            
            return false
        }
        
        else
        {
            if textField == txtOTP6
            {
                txtOTP6?.text = ""
                txtOTP5.becomeFirstResponder()
            }
            
            else if textField == txtOTP5
            {
                txtOTP5?.text = ""
                txtOTP4.becomeFirstResponder()
            }
            
            else if textField == txtOTP4
            {
                txtOTP4?.text = ""
                txtOTP3.becomeFirstResponder()
            }
            
            else if textField == txtOTP3
            {
                txtOTP3?.text = ""
                txtOTP2.becomeFirstResponder()
            }
            
            else if textField == txtOTP2
            {
                txtOTP2?.text = ""
                txtOTP1.becomeFirstResponder()
            }
            
            else
            {
                txtOTP1?.text = ""
                textField.resignFirstResponder()
            }
            return false
        }
    }
}
