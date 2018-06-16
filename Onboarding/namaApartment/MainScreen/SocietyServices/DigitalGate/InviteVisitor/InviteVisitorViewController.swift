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

class InviteVisitorViewController: NANavigationViewController,CNContactPickerDelegate {
    @IBOutlet weak var lbl_InvitorName: UILabel!
    @IBOutlet weak var lbl_InvitorMobile: UILabel!
    @IBOutlet weak var lbl_Or: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var txtInvitorName: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtInvitorMobile: UITextField!
    @IBOutlet weak var btnSelectContact: UIButton!
   
    @IBOutlet weak var lbl_InviteDescription: UILabel!
    @IBOutlet weak var btnInviteVisitor: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mob_Validation: UILabel!
    @IBOutlet weak var img_Profile: UIImageView!
   
    //created date picker programtically
    let picker = UIDatePicker()
    
    //data recieve purpose from getContactView Controller
    var dataName : String!
    var dataMobile : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding error labels while view load.
        lbl_Name_Validation.isHidden = true
        lbl_Mob_Validation.isHidden = true
        
        //assigned delegate method on textFields
        txtInvitorMobile.delegate = self
        txtInvitorName.delegate = self
        txtDate.delegate = self
        
        //tapGasture for upload new image
        img_Profile.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.img_Profile.addGestureRecognizer(tapGesture)
        
        //placing image calender imgage inside the Date&Time TextField
        self.txtDate.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newCalender")
        imageView.image = image
        txtDate.rightView = imageView
        
        //creating image round
        self.img_Profile.layer.cornerRadius = self.img_Profile.frame.size.width/2
        img_Profile.clipsToBounds = true
        
       //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: NAString().visitorNameViewTitle())
        self.navigationItem.title = ""

       //become first responder
        self.txtInvitorName.becomeFirstResponder()
        
        //hide invite Desc & invite button
        self.lbl_InviteDescription.isHidden = true
        self.btnInviteVisitor.isHidden = true

        //calling date picker function on view didload.
        createDatePicker(dateTextField: txtDate)
        
        //set local date to Europe to show 24 hours
        picker.locale = Locale(identifier: "en_GB")

        //assign values to upper strings
        txtInvitorName.text = dataName
        txtInvitorMobile.text = dataMobile
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0)

        //For Textfield under black line
        txtDate.underlined()
        txtInvitorName.underlined()
        txtInvitorMobile.underlined()

        //Label formatting & setting
        lbl_InvitorName.font = NAFont().headerFont()
        lbl_InvitorMobile.font = NAFont().headerFont()
        lbl_Or.font = NAFont().headerFont()
        lbl_Date.font = NAFont().headerFont()
        lbl_InvitorName.text = NAString().visitorName()
        lbl_InvitorMobile.text = NAString().visitorMobile()
        lbl_InviteDescription.text = NAString().inviteVisitorOTPDesc()
        
        //TextField Formatting & setting
        txtInvitorMobile.font = NAFont().textFieldFont()
        txtInvitorName.font = NAFont().textFieldFont()
        txtDate.font =  NAFont().textFieldFont()
        
        //Button formatting & Setting
        btnSelectContact.titleLabel?.font = NAFont().buttonFont()
        btnSelectContact.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnSelectContact.backgroundColor = NAColor().buttonBgColor()
        btnInviteVisitor.setTitle(NAString().btnInvite().uppercased(), for: .normal)
        btnSelectContact.setTitle(NAString().BtnselectFromContact().capitalized, for: .normal)
    }
    
    //for datePicker
    func createDatePicker(dateTextField : UITextField)
    {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .dateAndTime
        picker.minimumDate = NSDate() as Date
    }
    
    @objc func donePressed()
    {
        // format date
        let date = DateFormatter()
        date.dateFormat = "MMM d, YYYY \t HH:mm"
        let dateString = date.string(from: picker.date)
        txtDate.text = dateString
        self.view.endEditing(true)
        self.btnInviteVisitor.isHidden = true
        self.lbl_InviteDescription.isHidden = true
        
        if (txtInvitorName.text?.isEmpty)!
        {
            lbl_Name_Validation.isHidden = false
            txtInvitorName.redunderlined()
            txtDate.text = ""
            lbl_Name_Validation.text = NAString().please_enter_name()
        }
        else
        {
            lbl_Name_Validation.isHidden = true
            txtInvitorName.underlined()
            txtDate.text = dateString
        }
        if (txtInvitorMobile.text?.isEmpty)!
        {
            lbl_Mob_Validation.isHidden = false
            lbl_Mob_Validation.text = NAString().please_enter_mobile_no()
            txtInvitorMobile.redunderlined()
            txtDate.text = ""
        }
        else
        {
            lbl_Mob_Validation.isHidden = true
            txtDate.text = dateString
            txtInvitorMobile.underlined()
        }
        if (!(txtInvitorMobile.text?.isEmpty)!) && (txtInvitorMobile.text?.count != NAString().required_mobileNo_Length())
        {
            txtDate.text = ""
            lbl_Mob_Validation.isHidden = false
            txtInvitorMobile.redunderlined()
            lbl_Mob_Validation.text = NAString().please_enter_10_digit_no()
        }
        else if (txtInvitorMobile.text?.count == NAString().required_mobileNo_Length())
        {
            txtDate.text = dateString
            txtInvitorMobile.underlined()
            lbl_Mob_Validation.isHidden = true
        }
        if (!(txtInvitorName.text?.isEmpty)!) && (txtInvitorMobile.text?.count == NAString().required_mobileNo_Length())
        {
            txtDate.text = dateString
        }
        else
        {
            txtDate.text = ""
        }
        //To update visiblity of InviteButton according to text changes.
        updateInviteButtonVisibility()
    }
    @IBAction func btnSelectContact(_ sender: Any)
    {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined
        {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, nil) in
                
                if success
                {
                    self.openContacts()
                    print("Authorization")
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
        //Open App Setting if user cannot able to access Contacts
        else if authStatus == CNAuthorizationStatus.denied
        {
            //creating alert controller
            let alert = UIAlertController(title:NAString().setting_Permission_AlertBox() , message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title:NAString().cancel(), style: .cancel) { (action) in}
            let settingAction = UIAlertAction(title:NAString().settings(), style: .default) { (action) in
                UIApplication.shared.open(URL(string: "App-prefs:root=Privacy")!)}
            alert.addAction(cancelAction)
            alert.addAction(settingAction)
            present(alert, animated: true, completion: nil)
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
    //Navigate to My Visitor List Screen After Click on Inviting button alertView
    @IBAction func btnInviteVisitor(_ sender: UIButton)
    {
        inviteAlertView()
    }
    //AlertView For navigation
    func inviteAlertView()
    {
        
        //creating alert controller
        let alert = UIAlertController(title: NAString().inviteButtonAlertViewTitle() , message: NAString().inviteButtonAlertViewMessage(), preferredStyle: .alert)
       
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
            
            let dv = NAViewPresenter().myVisitorListVC()
            self.navigationController?.pushViewController(dv, animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    }

extension InviteVisitorViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    //Function to appear select image from by tapping image
    @objc func imageTapped()
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: NAString().camera(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        })
        let actionGallery = UIAlertAction(title:NAString().gallery(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing = true
            
            self.present(pickerController, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: NAString().cancel(), style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            img_Profile.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }

    //Accept only 10 digit mobile number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        if !(txtInvitorName.text?.isEmpty)! && !(txtDate.text?.isEmpty)!
        {
            btnInviteVisitor.isHidden = false
            lbl_InviteDescription.isHidden = false
        }
        if textField == txtInvitorName
        {
            if(newLength == NAString().zero_length())
            {
            lbl_Name_Validation.isHidden = false
            lbl_Name_Validation.text = NAString().please_enter_name()
                
            }
        }
        if textField == txtInvitorMobile
        {
            if NAValidation().isValidMobileNumberLength(isNewMobileNoLength: newLength)
            {
                lbl_Mob_Validation.isHidden = true
                txtInvitorMobile.underlined()
            }
            else
            {
                lbl_Mob_Validation.isHidden = false
                txtInvitorMobile.redunderlined()
                lbl_Mob_Validation.text = NAString().please_enter_10_digit_no()
                btnInviteVisitor.isHidden = true
                lbl_InviteDescription.isHidden = true
            }
            if (newLength == NAString().required_mobileNo_Length()) && !(txtDate.text?.isEmpty)!
            {
                btnInviteVisitor.isHidden = false
                lbl_InviteDescription.isHidden = false
            }
            //Check for Text Removal
            if string.isEmpty
            {
                return true
            }
            else
            {
                return newLength <= NAString().required_mobileNo_Length() // Bool
            }
        }
        else
        {
            if (newLength > NAString().zero_length())
            {
                lbl_Name_Validation.isHidden = true
                txtInvitorName.underlined()
            }
            else if (newLength == NAString().zero_length())
            {
                lbl_Mob_Validation.isHidden = true
                txtInvitorName.underlined()
            }
        }
        updateInviteButtonVisibility()
        return true
    }

     func updateInviteButtonVisibility()
     {
        //Conditions 1.Atleast 1 character. 2.10 Chracters Must. 3.Date Should Set
        if !(txtInvitorName.text?.isEmpty)! && (txtInvitorMobile.text?.count)! >= NAString().required_mobileNo_Length() && !(txtDate.text?.isEmpty)!
        {
            lbl_InviteDescription.isHidden = false
            btnInviteVisitor.isHidden = false
        }
        else
        {
            lbl_InviteDescription.isHidden = true
            btnInviteVisitor.isHidden = true
        }
    }
}




