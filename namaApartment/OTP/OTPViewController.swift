//
//  OTPViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

extension UITextField{
    
    func underlinedOTP(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}

class OTPViewController: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var btnVerify: UIButton!
    
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOPT2: UITextField!
    @IBOutlet weak var txtOPT3: UITextField!
    @IBOutlet weak var txtOPT4: UITextField!
    @IBOutlet weak var txtOPT5: UITextField!
    @IBOutlet weak var txtOPT6: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtOTP1?.becomeFirstResponder()
        self.btnVerify.isHidden =  true
        
        //textfield set targetting for the responder to next textview
        txtOTP1.delegate = self
        txtOPT2.delegate = self
        txtOPT3.delegate = self
        txtOPT4.delegate = self
        txtOPT5.delegate = self
        txtOPT6.delegate = self
        
      
         self.navigationItem.title = "PHONE VERIFICATION"
        
        
        //Set Textfield bottom border line
        txtOPT6.underlinedOTP()
        txtOPT5.underlinedOTP()
        txtOPT3.underlinedOTP()
        txtOPT4.underlinedOTP()
        txtOPT2.underlinedOTP()
        txtOTP1.underlinedOTP()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnVerifyOTP(_ sender: Any)
    {
//        let lv : myFlatDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "flatDetailsVC") as! myFlatDetailsViewController
//        self.navigationController?.pushViewController(lv, animated: true)
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
                txtOPT2?.becomeFirstResponder()
            }
            
            else if textField == txtOPT2
            {
                txtOPT3?.becomeFirstResponder()
            }
                
            else if textField == txtOPT3
            {
                txtOPT4?.becomeFirstResponder()
            }
            
            else if textField == txtOPT4
            {
                txtOPT5?.becomeFirstResponder()
            }
            
            else if textField == txtOPT5
            {
                txtOPT6?.becomeFirstResponder()
            }
            
            else
            {
                txtOPT6?.becomeFirstResponder()
                self.btnVerify.isHidden = false
            }
            
            return false
        }
        
        else
        {
            if textField == txtOPT6
            {
                txtOPT6?.text = ""
                txtOPT5.becomeFirstResponder()
            }
            
           else if textField == txtOPT5
            {
                txtOPT5?.text = ""
                txtOPT4.becomeFirstResponder()
            }
            
            else if textField == txtOPT4
            {
                txtOPT4?.text = ""
                txtOPT3.becomeFirstResponder()
            }
            
            else if textField == txtOPT3
            {
                txtOPT3?.text = ""
                txtOPT2.becomeFirstResponder()
            }
            
            else if textField == txtOPT2
            {
                txtOPT2?.text = ""
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
