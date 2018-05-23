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

class AddMyServicesViewController: NANavigationViewController,UITextFieldDelegate,CNContactPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
    @IBOutlet weak var btn_AddDetails: UIButton!
    
    //for Coming from my sweet home
    @IBOutlet weak var segment: UISegmentedControl!
    
    //to set navigation title
    var navTitle: String?
    
    //gettig data from previous screen string
    var AddOtpString = String()
    
    //created variable to hold mydailybservices temp variable
    var holdString = String()
    
    //to check from which view value is comming
    var vcValue = String()
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    //scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding dateTextField & segment when screen is coming from ADD MY SERVICES VC
        self.segment.isHidden = true
        
        //identify screen coming from which screen
        screenComingFrom()

        // adding image on date TextField
        txt_Date.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_Date.rightView = imageView
    
        super.ConfigureNavBarTitle(title: navTitle!)
        //become first responder
        self.txt_Name.becomeFirstResponder()
        
        //getting string from my Daily Services for OTP
                    //self.lbl_OTPDescription.text = AddOtpString
        
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
    
        //label formatting & setting
        self.lbl_OR.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_Date.font = NAFont().headerFont()
        self.lbl_OTPDescription.font = NAFont().descriptionFont()
    
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        
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
    
    //Grant access -> if yes the go to OTP else back to self view
    @IBAction func SegmentAcessGranted(_ sender: Any)
    {

    }
    
    //alert Popup when user give  grant access & try to add details
    func grantAccessAlert() {
        
        //creating alert controller
        let alert = UIAlertController(title: "Notification Alert" , message: NAString().family_member_alert_message(), preferredStyle: .alert)

          //creating Reject alert actions
        let rejectAction = UIAlertAction(title: "Reject", style: .cancel) { (action) in
            print("Rejected")
        }
        
        //creating Accept alert actions
        let acceptAction = UIAlertAction(title: "Accept", style: .default) { (action) in

            let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
            let familyString = NAString().enter_verification_code(first: "your Family Member", second: "their")
            lv.newOtpString = familyString
            self.navigationController?.pushViewController(lv, animated: true)
            
            print("Accepted")
        }
        
        alert.addAction(rejectAction)
        alert.addAction(acceptAction)
        present(alert, animated: true, completion: nil)
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
        picker.datePickerMode = .time
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = "HH:mm"
        let dateString = date.string(from: picker.date)
        txt_Date.text = dateString
        self.view.endEditing(true)
        
        //after adding date this will shows
        self.lbl_OTPDescription.isHidden = false
        self.btn_AddDetails.isHidden = false
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
    
    //identify from which page screen is coming
    func screenComingFrom() {
        if self.navTitle == NAString().addFamilyMemberTitle() {
            self.segment.isHidden = false
            self.txt_Date.isHidden = true
            self.lbl_Date.text = NAString().grant_access().capitalized
            self.lbl_OTPDescription.isHidden = false
            
            let FamilyString = NAString().otp_message_family_member()
            self.lbl_OTPDescription.text = FamilyString
    
        } else {
            
            self.segment.isHidden = true
            self.txt_Date.isHidden = false
            self.lbl_Date.text = NAString().time()
            self.lbl_OTPDescription.text = AddOtpString
            
            if (txt_Date.text?.isEmpty)!
            {
                lbl_OTPDescription.isHidden = true
                btn_AddDetails.isHidden = true
            }
        }
    }
    
    @IBAction func btnAddDetails(_ sender: Any)
    {
        if (navTitle! == NAString().add_my_service().capitalized)
        {
            print("add my services")
        let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
        
       // passing data
        let servicesString = NAString().enter_verification_code(first: "your \(holdString)", second: "their")
        lv.newOtpString = servicesString
        
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
        }
            
        else if (navTitle! == NAString().addFamilyMemberTitle().capitalized)
        {
           if(segment.selectedSegmentIndex == 0)
           {
            //calling AlertBox on click of YES
            grantAccessAlert()
            print("Selected Yes")
            }
            else
           {
        //if NO is selected then directly it will go to OTP Page.
            let lv : OTPViewController = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
            let familyString = NAString().enter_verification_code(first: "your Family Member", second: "their")
            lv.newOtpString = familyString
              self.navigationController?.pushViewController(lv, animated: true)
            
            print("Selected No")
            }
        }
    }
}
