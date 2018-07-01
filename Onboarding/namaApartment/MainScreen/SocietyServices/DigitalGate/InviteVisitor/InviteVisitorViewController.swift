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
import FirebaseDatabase
import FirebaseAuth
import Firebase

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
    
    @IBOutlet weak var lbl_Picture_Validation: UILabel!
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mob_Validation: UILabel!
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var seperatingLineView: UIView!
    
    //Creating Firebase DB Reference variable.
    var preApprovedVisitorsRef : DatabaseReference?
    var preApprovedVisitorsMobileNoRef : DatabaseReference?
   
    //created date picker programtically
    let picker = UIDatePicker()
    
    //data recieve purpose from getContactView Controller
    var dataName : String!
    var dataMobile : String!
    
    //Length Variables
    var nameTextFieldLength = NAString().zero_length()
    var mobileNumberTextFieldLength = NAString().zero_length()
    var dateTextFieldLength = NAString().zero_length()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Hiding error labels while view load.
        lbl_Name_Validation.isHidden = true
        lbl_Mob_Validation.isHidden = true
        lbl_Picture_Validation.isHidden = true
        
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
        
        lbl_Name_Validation.font = NAFont().descriptionFont()
        lbl_Mob_Validation.font = NAFont().descriptionFont()
        lbl_Picture_Validation.font = NAFont().descriptionFont()
        
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
    func createDatePicker(dateTextField : UITextField) {
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

    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = (NAString().dateFormate() + "\t\t" + NAString().timeFormate())
        let dateString = date.string(from: picker.date)
        txtDate.text = dateString
        self.view.endEditing(true)
        
        //after adding date this will shows
        self.btnInviteVisitor.isHidden = true
        self.lbl_InviteDescription.isHidden = true
        
        if (txtInvitorName.text?.isEmpty)! {
            lbl_Name_Validation.isHidden = false
            txtInvitorName.redunderlined()
            btnInviteVisitor.isHidden = true
            lbl_InviteDescription.isHidden = true
            lbl_Name_Validation.text = NAString().please_enter_name()
        } else {
            lbl_Name_Validation.isHidden = true
            txtInvitorName.underlined()
        }
        if (txtInvitorMobile.text?.isEmpty)! {
            lbl_Mob_Validation.isHidden = false
            lbl_Mob_Validation.text = NAString().please_enter_mobile_no()
            txtInvitorMobile.redunderlined()
            btnInviteVisitor.isHidden = true
            lbl_InviteDescription.isHidden = true
        } else {
            lbl_Mob_Validation.isHidden = true
            txtInvitorMobile.underlined()
        }
        if (!(txtInvitorMobile.text?.isEmpty)!) && (txtInvitorMobile.text?.count != NAString().required_mobileNo_Length()) {
            lbl_Mob_Validation.isHidden = false
            txtInvitorMobile.redunderlined()
            btnInviteVisitor.isHidden = true
            lbl_InviteDescription.isHidden = true
            lbl_Mob_Validation.text = NAString().please_enter_10_digit_no()
        } else if (txtInvitorMobile.text?.count == NAString().required_mobileNo_Length()) {
            txtInvitorMobile.underlined()
            lbl_Mob_Validation.isHidden = true
        }
        if (!(txtInvitorName.text?.isEmpty)!) && (txtInvitorMobile.text?.count == NAString().required_mobileNo_Length()) {
            btnInviteVisitor.isHidden = false
            lbl_InviteDescription.isHidden = false
        }
    }
    @IBAction func btnSelectContact(_ sender: Any) {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, nil) in
                
                if success {
                    self.openContacts()
                } else {
                }
            })
        } else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts()
        }
        //Open App Setting if user cannot able to access Contacts
        else if authStatus == CNAuthorizationStatus.denied {
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
    func openContacts() {
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        //uses did select method here
        self.present(contactPicker, animated: true, completion: nil)
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //user select any contact particular part
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        self.txtInvitorName.text = fullName
        
        lbl_Name_Validation.isHidden = true
        txtInvitorName.underlined()
        lbl_Mob_Validation.isHidden = true
        txtInvitorMobile.underlined()
        if !(txtDate.text?.isEmpty)! {
            btnInviteVisitor.isHidden = false
            lbl_InviteDescription.isHidden = false
        }
        
        var mobileNo = NAString().mobile_number_not_available()
        let mobileString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
        mobileNo = mobileString! as! String
        self.txtInvitorMobile.text = mobileNo
    }
    //Navigate to My Visitor List Screen After Click on Inviting button alertView
    @IBAction func btnInviteVisitor(_ sender: UIButton) {
        if img_Profile.image == #imageLiteral(resourceName: "imageIcon") {
            lbl_Picture_Validation.isHidden = false
            lbl_Picture_Validation.text = NAString().please_upload_Image()
        } else {
            //Calling storeVisitorDatailsInFirebase fucntion on click of Invite Visitor button & Showing alertView.
                self.storeVisitorDetailsInFirebase()
                inviteAlertView()
        }
    }
    //AlertView For navigation
    func inviteAlertView() {
        
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
    
    //Created Function for inviting visitor with the help of firebase.
    func storeVisitorDetailsInFirebase() {
        //Creating visitors UID
        preApprovedVisitorsMobileNoRef = Database.database().reference().child(Constants.FIREBASE_CHILD_VISITORS).child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS_MOBILENUMBER)
        
        let visitorUID : String?
        visitorUID = (preApprovedVisitorsMobileNoRef?.childByAutoId().key)!
        
        //Mapping Visitor's mobile number with their UID
        preApprovedVisitorsMobileNoRef?.child(self.txtInvitorMobile.text!).setValue(visitorUID)
        preApprovedVisitorsRef = Database.database().reference().child(Constants.FIREBASE_CHILD_VISITORS).child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS).child(visitorUID!)

        
       
        
        //image
        
        
        var visitorImageRef: StorageReference?
        
        visitorImageRef = Storage.storage().reference().child(Constants.FIREBASE_CHILD_VISITORS).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS)
        
        
        
        func uploadImageToFirebase()
        {
            guard let image = img_Profile.image else { return }
            guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
            
            let uploadImageRef = visitorImageRef?.child(visitorUID!)
            
            let uploadTask = uploadImageRef?.putData(imageData, metadata: nil, completion: { (metadata, error) in
                print("upload task finished")
                print(metadata ?? "NO Metadata")
                print(error ?? "No Error")
            })
            
            //to get progress of uploading image
            uploadTask?.observe(.progress, handler: { (snapshot) in
                print(snapshot.progress ?? "No More Progress")
            })
            
            
            uploadTask?.resume()
            
            
        }
       
        
        
        
        
        
        //Creating variable for status & assigning status string on it.
        var status = String()
        status = NAString().statusNotEntered()
        
        //TODO: Need to replace hardcoded inviterUID with Default User's UID.
        var inviterUID = String()
        inviterUID = "aMNacKnX44Zk006VZcSng9ilEcF3"
        
        //defining node with type of data in it.
        let visitorData = [
            VisitorListFBKeys.uid.key : visitorUID!,
            VisitorListFBKeys.dateAndTimeOfVisit.key : txtDate.text! as String,
            VisitorListFBKeys.mobileNumber.key : txtInvitorMobile.text! as String,
            VisitorListFBKeys.status.key : status,
            VisitorListFBKeys.fullName.key : txtInvitorName.text! as String,
            VisitorListFBKeys.inviterUID.key : inviterUID,
            //VisitorListFBKeys.profilePhoto.key : uploadImageToFirebase()
            ]
        
        // Adding visitor data under preApproved visitors
        preApprovedVisitorsRef?.child(visitorUID!).setValue(visitorData)
    }
}
extension InviteVisitorViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //Function to appear select image from by tapping image
    @objc func imageTapped() {
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img_Profile.image = image
            lbl_Picture_Validation.isHidden = true
        }
        self.dismiss(animated: true, completion: nil)
    }

    //Accept only 10 digit mobile number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        if textField == txtDate {
            dateTextFieldLength = newLength
            nameTextFieldLength = txtInvitorName.text!.count
            mobileNumberTextFieldLength = txtInvitorMobile.text!.count
        }
        if textField == txtInvitorName {
            if (newLength == NAString().zero_length()) {
                lbl_Name_Validation.isHidden = false
                txtInvitorName.redunderlined()
                lbl_Name_Validation.text = NAString().please_enter_name()
            } else {
                lbl_Name_Validation.isHidden = true
                txtInvitorName.underlined()
            }
            nameTextFieldLength = newLength
            dateTextFieldLength = txtDate.text!.count
            mobileNumberTextFieldLength = txtInvitorMobile.text!.count
        }
        if textField == txtInvitorMobile {
            if NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength) {
                lbl_Mob_Validation.isHidden = true
                txtInvitorMobile.underlined()
            } else {
                lbl_Mob_Validation.isHidden = false
                txtInvitorMobile.redunderlined()
                btnInviteVisitor.isHidden = true
                lbl_InviteDescription.isHidden = true
                lbl_Mob_Validation.text = NAString().please_enter_10_digit_no()
            }
            if newLength >= NAString().required_mobileNo_Length() && !(txtInvitorName.text?.isEmpty)! && !(txtDate.text?.isEmpty)! {
                btnInviteVisitor.isHidden = false
                lbl_InviteDescription.isHidden = false
            }
            nameTextFieldLength = txtInvitorName.text!.count
            dateTextFieldLength = txtDate.text!.count
            mobileNumberTextFieldLength = newLength
            
            //Check for Text Removal
            if string.isEmpty {
                return true
            } else {
                return newLength <= NAString().required_mobileNo_Length() // Bool
            }
        }
        updateInviteButtonVisibility(nameLength: nameTextFieldLength, mobileNumberLength: mobileNumberTextFieldLength, dateLength: dateTextFieldLength)
        return true
    }

    func updateInviteButtonVisibility(nameLength:Int, mobileNumberLength:Int, dateLength:Int) {
        
        //Conditions 1.Atleast 1 character. 2.10 Chracters Must. 3.Date Should Set
        if nameLength > NAString().zero_length() &&  NAValidation().isValidMobileNumber(isNewMobileNoLength: mobileNumberLength) && dateLength > NAString().zero_length() {
            btnInviteVisitor.isHidden = false
            lbl_InviteDescription.isHidden = false
        } else if nameLength == NAString().zero_length() || mobileNumberLength == NAString().zero_length() {
            btnInviteVisitor.isHidden = true
            lbl_InviteDescription.isHidden = true
        }
    }
}




