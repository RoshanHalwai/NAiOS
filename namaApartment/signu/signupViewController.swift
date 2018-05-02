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
    
    @IBOutlet weak var signup_TxtMobileNo: UITextField!
    
    @IBOutlet weak var signup_TxtEmailId: UITextField!
    
    //for hidding purpose on click Already have an account.
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbl_TermsCondition: UILabel!
    
    @IBOutlet weak var lbl_Fullname: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_EmailId: UILabel!
    @IBOutlet weak var btn_Back: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for hidding on login Click
//        self.signup_TxtMobileNo.isHidden =  false
//        self.signup_TxtEmailId.isHidden =  false
//        self.signup_TxtFullName.isHidden =  false
//        self.lbl_EmailId.isHidden = false
//        self.lbl_Fullname.isHidden = false
//        self.lbl_MobileNo.isHidden = false
//        self.lbl_TermsCondition.isHidden = false
//        self.btnLogin.isHidden = false
//        //self.btn_Back.title = ""
        
        

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
        
       // self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationItem.title = "SIGN UP"
      //  self.navigationController?.navigationBar.backgroundColor = UIColor.black
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func signup_BtnSignup(_ sender: Any)
    {
        
    }
    
    @IBAction func signup_BtnLogin(_ sender: UIButton)
    {
      
//        self.signup_TxtEmailId.isHidden =  true
//        self.signup_TxtFullName.isHidden =  true
//
//        self.lbl_EmailId.isHidden = true
//        self.lbl_Fullname.isHidden = true
//
//        self.lbl_TermsCondition.isHidden = true
//        self.btnLogin.isHidden = true
//
//        self.btnSignup.setTitle("Login",for: .normal)
//        self.btnSignup.frame = CGRect(x: 20, y: 194, width: 335, height: 40)
//
//         signup_TxtMobileNo.becomeFirstResponder()
//        self.btnLogin.setTitle("Create an Account", for: .normal)
        
//        self.lbl_TermsCondition.text = "Create an account"
//        self.lbl_TermsCondition.font = UIFont.boldSystemFont(ofSize: 22.0)
//        self.lbl_TermsCondition.font = UIFont(name: "Lato-Light", size: 22.0)
//        self.lbl_TermsCondition.textAlignment = .center
        
      
        
        self.navigationItem.title = "LOGIN"
       
       
    }
    
    
    
    @IBAction func signup_BtnBack(_ sender: UIBarButtonItem)
    {
        self.signup_TxtEmailId.isHidden =  false
        self.signup_TxtFullName.isHidden =  false
        
        self.lbl_EmailId.isHidden = false
        self.lbl_Fullname.isHidden = false
        
        self.lbl_TermsCondition.isHidden = false
        self.btnLogin.isHidden = false
        
        self.btnSignup.setTitle("SIGN UP",for: .normal)
        self.btnSignup.frame = CGRect(x: 20, y: 284, width: 335, height: 40)
        signup_TxtFullName.becomeFirstResponder()
        
        self.navigationItem.title = "SIGN UP"
       
        
        
        
    }
    

}
