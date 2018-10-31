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
    @IBOutlet weak var lbl_Validation: UILabel!
    
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
        lbl_Validation.font = NAFont().descriptionFont()
        lbl_Validation.isHidden = true
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        lbl_Validation.isHidden = true
        txt_Name.underlined()
        return true
    }
    
    @IBAction func doneButtonAction() {
        
        self.updateUserRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        if existedName != self.txt_Name.text {
            if navTitle == NAString().enter_your_data(name: NAString().enter_email_Data()) {
                if existedEmail != self.txt_Name.text {
                    let newMail = self.txt_Name.text
                    if (newMail?.isEmpty)! {
                        lbl_Validation.isHidden = false
                        txt_Name.redunderlined()
                        lbl_Validation.text = NAString().please_enter_email()
                    } else {
                        lbl_Validation.isHidden = true
                        txt_Name.underlined()
                        let providedEmailAddress = self.txt_Name.text
                        let isEmailAddressIsValid = NAFirebase().isValidEmailAddress(emailAddressString: providedEmailAddress!)
                        if !(newMail?.isEmpty)! {
                            if isEmailAddressIsValid {
                                lbl_Validation.isHidden = true
                                txt_Name.underlined()
                                updateUserRef?.child(Constants.FIREBASE_CHILD_EMAIL).setValue(newMail)
                                self.txt_Name.resignFirstResponder()
                                //setting the email value in GlobalUser data after User Updated his email.
                                GlobalUserData.shared.personalDetails_Items.first?.setEmail(email: newMail!)
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                lbl_Validation.isHidden = false
                                lbl_Validation.text = NAString().please_enter_Valid_email()
                                txt_Name.redunderlined()
                            }
                        }
                    }
                }
            } else {
                let newName = self.txt_Name.text
                if (newName?.isEmpty)! {
                    lbl_Validation.isHidden = false
                    txt_Name.redunderlined()
                    lbl_Validation.text = NAString().please_enter_name()
                } else {
                    lbl_Validation.isHidden = true
                    txt_Name.underlined()
                    updateUserRef?.child(Constants.FIREBASE_CHILD_FULLNAME).setValue(newName)
                    self.txt_Name.resignFirstResponder()
                    //setting the Name value in GlobalUser data after User Updated his Name.
                    GlobalUserData.shared.personalDetails_Items.first?.setFullName(fullName: newName!)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
