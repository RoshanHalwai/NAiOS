//
//  signupViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

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
    
    //for hidding purpose on click Already have an account.
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbl_TermsCondition: UILabel!
    
    @IBOutlet weak var lbl_Fullname: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_EmailId: UILabel!
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting font for labes & style textfield & label
        signup_TxtFullName.font = NAFont().textFieldFont()
        signup_TxtEmailId.font = NAFont().textFieldFont()
        signup_TxtCountryCode.font = NAFont().textFieldFont()
        signup_TxtMobileNo.font = NAFont().textFieldFont()

        lbl_Fullname.font = NAFont().headerFont()
        lbl_EmailId.font = NAFont().headerFont()
        lbl_MobileNo.font = NAFont().headerFont()
    
        lbl_TermsCondition.font = NAFont().descriptionFont()
        
        //set string on lables
        lbl_Fullname.text = NAString().full_name()
        lbl_MobileNo.text = NAString().phone_numbe()
        lbl_EmailId.text = NAString().email_id()
        signup_TxtCountryCode.text = NAString()._91()
        lbl_TermsCondition.text = NAString().i_agree_to_terms_and_conditions()
    
        btnSignup.setTitle(NAString().signup(), for: .normal)
        
        //color & font for button
        btnSignup.backgroundColor = NAColor().buttonBgColor()
       
        
        btnSignup.setTitleColor(NAColor().buttonFontColor(), for: .normal)
       
    
        //scrollView
         signupScrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
        //Set Textfield bottom border line
        signup_TxtFullName.underlined()
        signup_TxtEmailId.underlined()
        signup_TxtMobileNo.underlined()
    
        //keyboard will appear when textfield got focus
        
        signup_TxtFullName.becomeFirstResponder()
        
        //hide back button
         self.navigationItem.hidesBackButton = true
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
