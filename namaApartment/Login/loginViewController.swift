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


class loginViewController: UIViewController
{
    @IBOutlet weak var txt_MobileNo: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Textfield bottom border line
        txt_MobileNo.underlined1()

        //hide back button
        self.navigationItem.hidesBackButton = true
        //set sext
         self.navigationItem.title = "LOGIN"
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func btnLogin(_ sender: Any)
    {
        let lv : signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupViewController
        self.navigationController?.pushViewController(lv, animated: true)
        
    }
    

}
