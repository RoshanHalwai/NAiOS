//
//  loginViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 01/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseAuth

//Creating Variable to store FirebaseUser Data in Class.
var flatDetailsFB = [UserFlatDetails]()
var personalDetails = [UserPersonalDetails]()
var userprivileges = [UserPrivileges]()

class LoginViewController: NANavigationViewController {
    
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbl_Validation: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lbl_CountryCode: UILabel!
    @IBOutlet weak var lbl_Arrow: UILabel!
    @IBOutlet weak var stack_CountryCode: UIStackView!
    
    var countryCodeArray = [NAString().unitedStateCode(),NAString().indianStateCode()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        lbl_CountryCode.textColor = UIColor.black
        lbl_CountryCode.text = NAString()._91()
        lbl_Arrow.text = NAString().image()
        lbl_Arrow.textColor = UIColor.black
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0)
        scrollView.layoutIfNeeded()
        
        //assigned delegate method on textFields
        txt_MobileNo.delegate = self
        
        //hide validation label
        lbl_Validation.isHidden = true
        
        //Button formatting & setting
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
        lbl_CountryCode.font = NAFont().textFieldFont()
        
        self.view.layoutIfNeeded()
        //Set Textfield bottom border line
        txt_MobileNo.underlined()
        
        //Hiding Navigation bar Back Button
        self.navigationItem.hidesBackButton = true
        
        //set Title to Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().login_button())
        navigationItem.rightBarButtonItem = nil
        
        //Calling function from NANavigationViewController class to hide numberPad on done pressed
        hideNumberPad(numberTextField: txt_MobileNo)
        
        let selectCountryCode = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        stack_CountryCode.isUserInteractionEnabled = true
        stack_CountryCode.addGestureRecognizer(selectCountryCode)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        let actionSheet = UIAlertController(title:NAString().selectCountryCode(), message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: countryCodeArray[0], style: .default, handler: countryCodeSelected)
        let action2 = UIAlertAction(title: countryCodeArray[1], style: .default, handler: countryCodeSelected)
        
        let cancel = UIAlertAction(title: NAString().cancel(), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        
        actionSheet.addAction(cancel)
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func countryCodeSelected(alert: UIAlertAction!) {
        if alert.title == NAString().unitedStateCode() {
            lbl_CountryCode.text = NAString()._1()
            lbl_Arrow.text = NAString().image()
            lbl_CountryCode.textColor = UIColor.black
            lbl_Arrow.textColor = UIColor.black
        } else {
            lbl_CountryCode.text = NAString()._91()
            lbl_Arrow.text = NAString().image()
            lbl_CountryCode.textColor = UIColor.black
            lbl_Arrow.textColor = UIColor.black
        }
    }
    
    //Accept only 10 digit mobile number in MobileNumber TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        lbl_Validation.isHidden = true
        txt_MobileNo.underlined()
        
        return newLength <= NAString().required_mobileNo_Length() // Bool
    }
    
    @IBAction func btnSignin(_ sender: Any) {
        lbl_Validation.isHidden = true
        
        if (self.txt_MobileNo.text?.isEmpty)! {
            lbl_Validation.isHidden = false
            lbl_Validation.text = NAString().please_enter_your_mobile_no()
            txt_MobileNo.redunderlined()
        } else if ((txt_MobileNo.text?.count)! < NAString().required_mobileNo_Length()) {
            lbl_Validation.isHidden = false
            lbl_Validation.text =  NAString().please_enter_10_digit_no()
            txt_MobileNo.redunderlined()
        } else if ((txt_MobileNo.text?.count)! == NAString().required_mobileNo_Length()) {
            txt_MobileNo.resignFirstResponder()
            let lv = NAViewPresenter().otpViewController()
            let otpString = NAString().enter_verification_code(first: "your", second: "your")
            lv.newOtpString = otpString
            
            //Passing mobile number string to OTP VC (For mapping No with UID)
            lv.getMobileString = txt_MobileNo.text!
            lv.getCountryCodeString = lbl_CountryCode.text!
            self.navigationController?.pushViewController(lv, animated: true)
        }
    }
}

//Created Extention to get HexaString For Verification Code
extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}
