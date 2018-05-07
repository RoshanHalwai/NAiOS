//
//  InviteVisitorViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 05/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class InviteVisitorViewController: UIViewController,CNContactPickerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var lbl_InvitorName: UILabel!
    @IBOutlet weak var lbl_InvitorMobile: UILabel!
    @IBOutlet weak var lbl_Or: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
   
    
    @IBOutlet weak var txtInvitorName: UITextField!
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtInvitorMobile: UITextField!
    
    @IBOutlet weak var btnSelectContact: UIButton!
    @IBOutlet weak var btnCalander: UIButton!
    
     @IBOutlet weak var lbl_InviteDescription: UILabel!
    @IBOutlet weak var btnInviteVisitor: UIButton!
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    //created date picker programtically
    let picker = UIDatePicker()
    
    //data recieve purpose from getContactView Controller
    var dataName : String!
    var dataMobile : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtDate.delegate = self
        
        //hide invite Desc & invite button
        self.lbl_InviteDescription.isHidden = true
      self.btnInviteVisitor.isHidden = true

        
         createDatePicker()
        picker.locale = Locale(identifier: "en_GB")

        
        //assign values to upper strings
        txtInvitorName.text = dataName
        txtInvitorMobile.text = dataMobile
        
       // self.datePicker.isHidden = true
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)

        //balck under line
        txtDate.underlined()
        txtInvitorName.underlined()
        txtInvitorMobile.underlined()

       //set font  & color to ui controllers
        lbl_InvitorName.font = NAFont().headerFont()
        lbl_InvitorMobile.font = NAFont().headerFont()
        lbl_Or.font = NAFont().headerFont()

        lbl_Date.font = NAFont().headerFont()
        txtInvitorMobile.font = NAFont().textFieldFont()
        txtInvitorName.font = NAFont().textFieldFont()
        txtDate.font =  NAFont().textFieldFont()
        
        btnSelectContact.titleLabel?.font = NAFont().buttonFont()
        btnSelectContact.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnSelectContact.backgroundColor = NAColor().buttonBgColor()
        
    }

    //for datePicker
    func createDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
       
        
        toolbar.setItems([done], animated: false)
        
        txtDate.inputAccessoryView = toolbar
        
        txtDate.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .dateAndTime
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = "MMM d YY, HH:mm"
        
        let dateString = date.string(from: picker.date)
        txtDate.text = dateString
        
        self.view.endEditing(true)
        
        self.btnInviteVisitor.isHidden = false
        self.lbl_InviteDescription.isHidden = false
        
    }
    
    @IBAction func btnSelectContact(_ sender: Any)
    {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined
        {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, nil) in
                
                if success {
                    self.openContacts()
                }
                else
                {
                    print("No Authorization")
                }
            })
        }
        else if authStatus == CNAuthorizationStatus.authorized
        {
            self.openContacts()
            print("Get Authorization")
        }
    }
    
    
    //to call default address book app
    func openContacts()
    {
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        
        //uses did select method here
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //user select any contact particular part
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact)
    {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        self.txtInvitorName.text = fullName
        
        var mobileNo = "Not Available"
        let mobileString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
            
        mobileNo = mobileString! as! String
        self.txtInvitorMobile.text = mobileNo
        
    }
    
 
    @IBAction func btnBackToVisitor(_ sender: UIBarButtonItem)
    {
        let lv : DigitalGateViewController = self.storyboard?.instantiateViewController(withIdentifier: "digitalGateVC") as! DigitalGateViewController
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
        
    }
    
    @IBAction func btnShowCalender(_ sender: UIButton)
    {
        createDatePicker()
    }
    
    
    
    
    
}
