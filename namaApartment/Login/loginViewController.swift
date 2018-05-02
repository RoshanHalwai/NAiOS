//
//  loginViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
extension UITextField{
    
    func underlined1(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}


class loginViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var txt_MobileNo: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //open number pad
          self.txt_MobileNo?.becomeFirstResponder()
        
        //Set Textfield bottom border line
        txt_MobileNo.underlined1()

       //navigation bar
        self.navigationItem.hidesBackButton = true
       
         self.navigationItem.title = "LOGIN"
        
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
//      
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func btnSignup(_ sender: Any)
    {
        let lv : signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupViewController
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    @IBAction func btnSignin(_ sender: Any)
    {
       
//        let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
//        self.navigationController?.pushViewController(lv, animated: true)
    }
    

}
