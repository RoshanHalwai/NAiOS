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
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

//Created Delegate method for storing data, After verifying DS Mobile Number
protocol DataPass {
    func dataPassing()
}

class AddMyServicesViewController: NANavigationViewController, CNContactPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DataPass {
    
    @IBOutlet weak var img_Profile: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_OR: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mobile_Validation: UILabel!
    @IBOutlet weak var lbl_Picture_Validation: UILabel!
    @IBOutlet weak var lbl_Date_Validation: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_Date: UITextField!
    
    @IBOutlet weak var btn_SelectContact: UIButton!
    @IBOutlet weak var btn_AddDetails: UIButton!
    
    @IBOutlet weak var stackView_InTime: UIStackView!
    
    var timer = Timer()
    var count = 5
    
    /* - To set navigation title.
     - Gettig data from previous screen string.
     - To check from which view value is comming.
     - Created date picker programtically.
     - Scrollview. */
    
    var navTitle: String?
    var AddOtpString = String()
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    var dailyServiceType = String()
    var dailyServiceKey = String()
    //scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Database References
    var userDataRef : DatabaseReference?
    var dailyServicesPublicRef: DatabaseReference?
    var dailyServicesPrivateRef : DatabaseReference?
    var dailyServicesImageRef : StorageReference?
    var dailyServicesTypeRef : DatabaseReference?
    var dailyServicesStatusRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* - Create Name textfield first letter capital.
         - Add border color and round Image on profile imageview.
         - Assigned delegate method on textFields and Hiding error labels.
         - Identify screen coming from which screen and Setting navigation title.
         - Adding image on date TextField and Black underline for textfileds.
         - TapGasture for upload new image and Calling datePicker.
         - Set local date to Europe to show 24 hours.
         - TextField,Button,Label formatting & setting. */
        
        //Switch case to get selected value from ActionSheet
        switch dailyServiceType {
        case NAString().cook():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_COOKS
            break
        case NAString().maid():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_MAIDS
            break
        case NAString().car_bike_cleaning():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_CARBIKE_CLEANER
        case NAString().child_day_care():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_CHILDDAY_CARE
            break
        case NAString().daily_newspaper():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_DAILY_NEWSPAPER
            break
        case NAString().milk_man():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_MILKMEN
            break
        case NAString().laundry():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_LAUNDRIES
            break
        case NAString().driver():
            dailyServiceKey = Constants.FIREBASE_DSTYPE_DRIVERS
            break
        default:
            break
        }
        
        //Create Name textfield first letter capital
        txt_Name.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        img_Profile.layer.borderColor = UIColor.black.cgColor
        
        lbl_Name_Validation.isHidden = true
        lbl_Mobile_Validation.isHidden = true
        lbl_Picture_Validation.isHidden = true
        lbl_Date_Validation.isHidden = true
        
        txt_Name.delegate = self
        txt_CountryCode.delegate = self
        txt_MobileNo.delegate = self
        txt_Date.delegate = self
        
        screenComingFrom()
        
        txt_Date.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newClock")
        imageView.image = image
        txt_Date.rightView = imageView
        
        super.ConfigureNavBarTitle(title: navTitle!)
        
        img_Profile.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.img_Profile.addGestureRecognizer(tapGesture)
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 210, 0)
        
        createDatePicker()
        
        picker.locale = Locale(identifier: "en_GB")
        
        txt_Date.underlined()
        txt_Name.underlined()
        txt_MobileNo.underlined()
        
        self.lbl_OR.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_Date.font = NAFont().headerFont()
        self.lbl_OTPDescription.font = NAFont().descriptionFont()
        self.lbl_Name_Validation.font = NAFont().descriptionFont()
        self.lbl_Mobile_Validation.font = NAFont().descriptionFont()
        self.lbl_Picture_Validation.font = NAFont().descriptionFont()
        self.lbl_Date_Validation.font = NAFont().descriptionFont()
        
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        
        self.txt_Date.font = NAFont().textFieldFont()
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().headerFont()
        self.txt_CountryCode.text = NAString()._91()
        
        self.btn_SelectContact.backgroundColor = NAColor().buttonBgColor()
        self.btn_SelectContact.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_SelectContact.setTitle(NAString().BtnselectFromContact().capitalized, for: .normal)
        
        self.btn_AddDetails.backgroundColor = NAColor().buttonBgColor()
        self.btn_AddDetails.setTitle(NAString().add().uppercased(), for: .normal)
        self.btn_AddDetails.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        self.btn_SelectContact.titleLabel?.font = NAFont().buttonFont()
        self.btn_AddDetails.titleLabel?.font = NAFont().buttonFont()
        
        self.img_Profile.layer.cornerRadius = self.img_Profile.frame.size.width/2
        img_Profile.clipsToBounds = true
    }
    
    /* - Create name textfield first letter capital function.
     - Alert Popup when user give  grant access & try to add details.
     - Showing alert controller while giving Grant Access to family members.
     - Creating Reject & alert actions.
     - Function to appear select image from by tapping image.
     - DatePicker Done button for toolbar and Format picker for date. */
    
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    @objc func imageTapped() {
        let actionSheet = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title:NAString().camera(), style: .default, handler: {
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
        let cancel = UIAlertAction(title:NAString().cancel(), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in})
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
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_Date.inputAccessoryView = toolbar
        txt_Date.inputView = picker
        
        picker.datePickerMode = .time
    }
    
    @objc func donePressed() {
        
        let date = DateFormatter()
        date.dateFormat = NAString().timeFormat()
        let dateString = date.string(from: picker.date)
        txt_Date.text = dateString
        self.view.endEditing(true)
        
        lbl_Date_Validation.isHidden = true
        txt_Date.underlined()
    }
    
    /* - Open App Setting if user cannot able to access Contacts.
     - To call default address book app & User select any contact particular part.
     - Identify from which page screen is coming.
     - Create alert controller,Timer Function,AlertView Action and OK button.
     - Retrive Data from AlertView Delegate. */
    
    @IBAction func btnSelectContact(_ sender: Any) {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        if authStatus == CNAuthorizationStatus.notDetermined {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, nil) in
                if success {
                    self.openContacts()
                }
            })
        } else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts()
        }
            
        else if authStatus == CNAuthorizationStatus.denied {
            
            let alert = UIAlertController(title: NAString().setting_Permission_AlertBox() , message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NAString().cancel(), style: .cancel) { (action) in }
            let settingAction = UIAlertAction(title: NAString().settings(), style: .default) { (action) in
                UIApplication.shared.open(URL(string: "App-prefs:root=Privacy")!)
            }
            alert.addAction(cancelAction)
            alert.addAction(settingAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openContacts() {
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        self.txt_Name.text = fullName
        
        var mobileNo = NAString().mobile_number_not_available()
        let mobileString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
        mobileNo = mobileString! as! String
        var mobileNumber = mobileNo.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
        
        if mobileNumber.count > NAString().required_mobileNo_Length() {
            let range1 = mobileNumber.characters.index(mobileNumber.startIndex, offsetBy: 2)..<mobileNumber.endIndex
            mobileNumber = String(mobileNumber[range1])
        }
        self.txt_MobileNo.text = mobileNumber
    }
    
    func screenComingFrom() {
        if self.navTitle == NAString().add_my_service() {
            self.lbl_Date.text = NAString().time()
            self.lbl_OTPDescription.text = NAString().inviteVisitorOTPDesc()
        }
    }
    
    @IBAction func btnAddDetails(_ sender: Any) {
        if img_Profile.image == #imageLiteral(resourceName: "ExpectingVisitor") {
            lbl_Picture_Validation.isHidden = false
            lbl_Picture_Validation.text = NAString().please_upload_Image()
        }
        if (txt_Date.text?.isEmpty)! {
            lbl_Date_Validation.isHidden = false
            lbl_Date_Validation.text = NAString().Please_select_date()
            txt_Date.redunderlined()
        } else {
            lbl_Date_Validation.isHidden = true
            txt_Date.underlined()
        }
        if (txt_Name.text?.isEmpty)! {
            lbl_Name_Validation.isHidden = false
            lbl_Name_Validation.text = NAString().please_enter_name()
            txt_Name.redunderlined()
        } else {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if (txt_MobileNo.text?.isEmpty)! {
            lbl_Mobile_Validation.isHidden = false
            lbl_Mobile_Validation.text = NAString().please_enter_mobile_no()
            txt_MobileNo.redunderlined()
        } else if (!(txt_MobileNo.text?.isEmpty)!) && (txt_MobileNo.text?.count != NAString().required_mobileNo_Length()) {
            lbl_Mobile_Validation.isHidden = false
            txt_MobileNo.redunderlined()
            lbl_Mobile_Validation.text = NAString().please_enter_10_digit_no()
        } else if (txt_MobileNo.text?.count == NAString().required_mobileNo_Length()) {
            txt_MobileNo.underlined()
            lbl_Mobile_Validation.isHidden = true
        }
        if !(txt_Name.text?.isEmpty)! && !(txt_MobileNo.text?.isEmpty)! && !(txt_Date.text?.isEmpty)! && img_Profile.image != #imageLiteral(resourceName: "ExpectingVisitor") {
            if (navTitle! == NAString().add_my_service().capitalized) {
                
                AlertViewAction()
                
            }
        }
    }
    
    // Create Timer Function
    @objc func stopTimer() {
        OpacityView.shared.hidingPopupView()
        if (count >= 0){
            if(count == 0) {
                self.AlertViewAction()
            }
        }
    }
    
    //Create AlertView Action
    func AlertViewAction() {
        let alertController = UIAlertController(title:NAString().add_my_service(), message:NAString().addButtonloadViewMessage(), preferredStyle: .alert)
        // Create OK button
        let OKAction = UIAlertAction(title: NAString().ok(), style: .default) { (action:UIAlertAction!) in
            let lv = NAViewPresenter().otpViewController()
            let dailyServicesString = NAString().enter_verification_code(first: "your \(self.dailyServiceType)", second: "their")
            lv.getCountryCodeString = self.txt_CountryCode.text!
            lv.getMobileString = self.txt_MobileNo.text!
            lv.newOtpString = dailyServicesString
            lv.dailyServiceType = self.dailyServiceType
            //Assigning Delegate
            lv.delegateData = self
            
            self.navigationController?.pushViewController(lv, animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_Name {
            txt_MobileNo.becomeFirstResponder()
        } else if textField == txt_MobileNo {
            txt_Date.becomeFirstResponder()
        }
        return true
    }
}

// Accept only 10 digit mobile number & Check for Text Removal. 

extension AddMyServicesViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_Name {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if textField == txt_MobileNo {
            txt_MobileNo.underlined()
            lbl_Mobile_Validation.isHidden = true
            if NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength) {
            }
            if newLength >= NAString().required_mobileNo_Length() && !(txt_Name.text?.isEmpty)! && !(txt_Date.text?.isEmpty)! {
            }
            
            if string.isEmpty {
                return true
            } else {
                return newLength <= NAString().required_mobileNo_Length() // Bool
            }
        }
        return true
    }
}

/*  - Created Extension to write code seperatly in the file,So other can know easily
 - Using delegate method after coming from otp data is saving in Firebase
 - Mapping dailyservice UID with true in UserData -> DailyServices
 - Mapping dailyservice UID with Mobile Number in DailyServices -> All -> Private
 - Mapping dailyservice UID with its DSType
 - Storing Daily services details in DailyServices -> All -> Public
 - Mapping status with type  Not Entered inside DS UID
 - Storing Profile Image in Storage Folder
 - Compressing profile image and assigning its content type.
 - Uploading Daily Services image url along with DailyServices UID
 - Adding Daily Services data under Daily Services -> UID */

extension AddMyServicesViewController {
    
    func dataPassing() {
        storingDailyServicesInFirebase()
    }
    
    func storingDailyServicesInFirebase()  {
        let flatValues = Singleton_FlatDetails.shared.flatDetails_Items
        let userFlatDetailValues = flatValues.first
        
        userDataRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child((userFlatDetailValues?.city)!).child((userFlatDetailValues?.societyName)!).child((userFlatDetailValues?.apartmentName)!).child((userFlatDetailValues?.flatNumber)!).child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(dailyServiceKey)
        
        userDataRef?.child(dailyServicesUID!).setValue(NAString().gettrue())
        
        dailyServicesPrivateRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
        
        dailyServicesPrivateRef?.child(txt_MobileNo.text!).setValue(dailyServicesUID!)
        
        dailyServicesTypeRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(Constants.FIREBASE_CHILD_DAILY_SERVICES_TYPE)
        
        dailyServicesTypeRef?.child(dailyServicesUID!).setValue(dailyServiceKey)
        
        dailyServicesPublicRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(dailyServiceKey).child(dailyServicesUID!).child(userUID)
        
        dailyServicesStatusRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(dailyServiceKey).child(dailyServicesUID!)
        
        self.dailyServicesStatusRef?.child(NAString().status()).setValue(NAString().notEntered())
        
        dailyServicesImageRef = Storage.storage().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(dailyServiceKey)
        
        guard let image = self.img_Profile.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
        
        let metaDataContentType = StorageMetadata()
        metaDataContentType.contentType = NAString().imageContentType()
        
        let uploadImageRef = dailyServicesImageRef?.child(dailyServicesUID!)
        let uploadTask = uploadImageRef?.putData(imageData, metadata: metaDataContentType, completion: { (metadata, error) in
            
            uploadImageRef?.downloadURL(completion: { (url, urlError) in
                
                if urlError == nil {
                    //TODO: Hardcoded rating, Need to change in future.
                    let dailyServicesData = [
                        NADailyServicesStringFBKeys.fullName.key : self.txt_Name.text! as String,
                        NADailyServicesStringFBKeys.phoneNumber.key : self.txt_MobileNo.text!,
                        NADailyServicesStringFBKeys.rating.key : 3,
                        NADailyServicesStringFBKeys.timeOfVisit.key : self.txt_Date.text! as String,
                        NADailyServicesStringFBKeys.uid.key : dailyServicesUID!,
                        NADailyServicesStringFBKeys.profilePhoto.key : url?.absoluteString ?? ""
                        ] as [String : Any]
                    
                    self.dailyServicesPublicRef?.setValue(dailyServicesData)
                } else {
                    //TODO: Using else condtion for printing error if anything is wrong while storing data
                    print("Error is:",urlError as Any)
                }
            })
        })
        uploadTask?.resume()
    }
}
