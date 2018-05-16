//
//  AddMyDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class AddMyDetailsViewController: NANavigationViewController,UITextFieldDelegate,CNContactPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_OR: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_Date: UITextField!
    
    @IBOutlet weak var btn_SelectContact: UIButton!
    @IBOutlet weak var btn_ShowCalender: UIButton!
    @IBOutlet weak var btn_AddDetails: UIButton!
    
    //gettig data from previous screen string
    var AddOtpString = String()
    
    //created variable to hold mydailybservices temp variable
    var holdString = String()
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    //scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getting string from my Daily Services for OTP
        self.lbl_OTPDescription.text = AddOtpString
        
        //tapGasture for upload new image
        img_Profile.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.img_Profile.addGestureRecognizer(tapGesture)
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
        //Calling datePicker
          createDatePicker()
        
        //set local date to Europe to show 24 hours
        picker.locale = Locale(identifier: "en_GB")
        
        //black underline for textfileds
        txt_Date.underlined()
        txt_Name.underlined()
        txt_MobileNo.underlined()
    
        //Setting Title of the screen
        super.ConfigureNavBarTitle(title: "Add My Service")
        
        //hide info button from navigation bar
        navigationItem.rightBarButtonItem = nil
        
        //label formatting & setting
        self.lbl_OR.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_Date.font = NAFont().headerFont()
        self.lbl_OTPDescription.font = NAFont().descriptionFont()
    
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        self.lbl_Date.text = NAString().date()
        
        //textField formatting & setting
        self.txt_Date.font = NAFont().textFieldFont()
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().textFieldFont()
        
        //button formatting & setting
        self.btn_SelectContact.backgroundColor = NAColor().buttonBgColor()
        self.btn_SelectContact.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_SelectContact.setTitle(NAString().BtnselectFromContact(), for: .normal)
        
        self.btn_AddDetails.backgroundColor = NAColor().buttonBgColor()
        self.btn_AddDetails.setTitle(NAString().add(), for: .normal)
        self.btn_AddDetails.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        self.btn_SelectContact.titleLabel?.font = NAFont().buttonFont()
        
        self.btn_AddDetails.titleLabel?.font = NAFont().buttonFont()
        //creating image round
        self.img_Profile.layer.cornerRadius = self.img_Profile.frame.size.width/2
        img_Profile.clipsToBounds = true
    }
    
    //Function to appear select image from by tapping image
    @objc func imageTapped()
    {
        let actionSheet = UIAlertController(title: "Choose one to select image ", message: "Choose your image from your Destination.", preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: "Camera", style: .default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = true

            self.present(pickerController, animated: true, completion: nil)
            print("Camera tapped")
        })
        
        let actionGallery = UIAlertAction(title: "Gallery", style: .default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing = true
            
            print("Gallery tapped")
            
            self.present(pickerController, animated: true, completion: nil)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_Profile.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //for datePicker
    func createDatePicker() {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_Date.inputAccessoryView = toolbar
        txt_Date.inputView = picker
        // format picker for date
        picker.datePickerMode = .dateAndTime
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = "MMM d, YY \t HH:mm"
        let dateString = date.string(from: picker.date)
        txt_Date.text = dateString
        self.view.endEditing(true)
      // self.btnInviteVisitor.isHidden = false
       // self.lbl_InviteDescription.isHidden = false
    }
    
    @IBAction func btnSelectContact(_ sender: Any) {
        
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
        self.txt_Name.text = fullName
        
        var mobileNo = "Not Available"
        let mobileString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
        
        mobileNo = mobileString! as! String
        self.txt_MobileNo.text = mobileNo
    }
    
    @IBAction func btnAddDetails(_ sender: Any)
    {
        let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
        
       // passing data
        let cookString = NAString().dailyServicesOTPDescription()
        let replaced = cookString.replacingOccurrences(of: "account", with: (self.holdString))
        lv.newOtpString = replaced
        
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
        
        
       
    }
    
}
