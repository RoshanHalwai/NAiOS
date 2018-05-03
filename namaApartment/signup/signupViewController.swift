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
        
    }
    
    @IBAction func signup_BtnLogin(_ sender: UIButton)
    {
//        let lv : loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginViewController
//        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    

}
