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
}

class signupViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var signupScrollView : UIScrollView!
    
    @IBOutlet weak var signup_TxtFullName: UITextField!
    @IBOutlet weak var signup_TxtCountryCode: UITextField!
    @IBOutlet weak var signup_TxtMobileNo: UITextField!
    @IBOutlet weak var signup_TxtEmailId: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var lbl_TermsCondition: UILabel!
    @IBOutlet weak var lbl_Fullname: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_EmailId: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Label formatting & setting
        lbl_Fullname.font = NAFont().headerFont()
        lbl_EmailId.font = NAFont().headerFont()
        lbl_MobileNo.font = NAFont().headerFont()
        lbl_TermsCondition.font = NAFont().descriptionFont()
        lbl_Fullname.text = NAString().full_name()
        lbl_MobileNo.text = NAString().phone_numbe()
        lbl_EmailId.text = NAString().email_id()
        lbl_TermsCondition.text = NAString().i_agree_to_terms_and_conditions()
        
         //Textfield formatting & setting
        signup_TxtFullName.font = NAFont().textFieldFont()
        signup_TxtEmailId.font = NAFont().textFieldFont()
        signup_TxtCountryCode.font = NAFont().textFieldFont()
        signup_TxtMobileNo.font = NAFont().textFieldFont()
        signup_TxtCountryCode.text = NAString()._91()
        
        //Button formatting & setting
        btnSignup.backgroundColor = NAColor().buttonBgColor()
        btnSignup.setTitle(NAString().signup(), for: .normal)
        btnSignup.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnSignup.titleLabel?.font = NAFont().buttonFont()
        btnLogin.backgroundColor = UIColor.white
        btnLogin.setTitle(NAString().i_already_have_an_account(), for: .normal)
        
        //scrollView
         signupScrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
        //Set Textfield bottom border line
        signup_TxtFullName.underlined()
        signup_TxtEmailId.underlined()
        signup_TxtMobileNo.underlined()
    
        //Become First Responder
        signup_TxtFullName.becomeFirstResponder()
        
        //Hiding Navigation bar Back Button
         self.navigationItem.hidesBackButton = true
        
        //set Title to Navigation Bar
        self.navigationItem.title = "SIGN UP"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signup_BtnSignup(_ sender: Any)
    {
        let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    @IBAction func signup_BtnLogin(_ sender: UIButton)
    {
        let lv : loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginViewController
       self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    

}
