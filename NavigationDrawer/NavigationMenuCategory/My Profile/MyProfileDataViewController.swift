//
//  MyProfileDataViewController.swift
//  nammaApartment
//
//  Created by Srilatha on 10/16/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class MyProfileDataViewController: NANavigationViewController {
    
    @IBOutlet weak var txt_Name: UITextField!
    
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Done: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackView_Bottom_Constraint: NSLayoutConstraint!
    
    var name = String()
    var email = String()
    var navTitle = String()
    var existedName : String?
    var existedEmail : String?
    
    var updateUserRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        if navTitle == NAString().enter_your_data(name: NAString().enter_email_Data()) {
            self.txt_Name.text = email
        } else {
            self.txt_Name.text = name
        }
        
        self.stackView_Bottom_Constraint.constant = self.stackView_Bottom_Constraint.constant - 5
        txt_Name.underlined()
        txt_Name.font = NAFont().textFieldFont()
        
        //Button Formatting & settings
        btn_Cancel.setTitle(NAString().cancel(), for: .normal)
        btn_Cancel.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Cancel.backgroundColor = NAColor().buttonBgColor()
        btn_Cancel.titleLabel?.font = NAFont().buttonFont()
        
        btn_Done.setTitle(NAString().done(), for: .normal)
        btn_Done.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Done.backgroundColor = NAColor().buttonBgColor()
        btn_Done.titleLabel?.font = NAFont().buttonFont()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Create Keyboard Showing Function
    @objc func keyboardWillShow(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                
                self.stackView_Bottom_Constraint.constant = keyBoardHeight
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    //Create Keyboard Hiding Function
    @objc func keyboardWillHide(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                
                self.stackView_Bottom_Constraint.constant = self.stackView_Bottom_Constraint.constant - keyBoardHeight
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func cancelButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Email Validation Function
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let validEmail = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let emailTextInput = try NSRegularExpression(pattern: validEmail)
            let emailString = emailAddressString as NSString
            let results = emailTextInput.matches(in: emailAddressString, range: NSRange(location: 0, length: emailString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch {
            returnValue = false
        }
        return  returnValue
    }
    
    @IBAction func doneButtonAction() {
        self.updateUserRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        if existedName != self.txt_Name.text {
            if navTitle == NAString().enter_your_data(name: NAString().enter_email_Data()) {
                if existedEmail != self.txt_Name.text {
                    let newMail = self.txt_Name.text
                    updateUserRef?.child(Constants.FIREBASE_CHILD_EMAIL).setValue(newMail)
                    //setting the email value in GlobalUser data after User Updated his email.
                    GlobalUserData.shared.personalDetails_Items.first?.setEmail(email: newMail!)
                }
            } else {
                let newName = self.txt_Name.text
                updateUserRef?.child(Constants.FIREBASE_CHILD_FULLNAME).setValue(newName)
                //setting the Name value in GlobalUser data after User Updated his Name.
                GlobalUserData.shared.personalDetails_Items.first?.setFullName(fullName: newName!)
                NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().update_Alert_Title(), Message: NAString().update_Successfull_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        let providedEmailAddress = self.txt_Name.text
        let isEmailAddressIsValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        if isEmailAddressIsValid == true {
            NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().update_Alert_Title(), Message: NAString().update_Successfull_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}
