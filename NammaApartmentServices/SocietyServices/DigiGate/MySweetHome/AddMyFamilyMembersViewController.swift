//
//  AddMyFamilyMembersViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 21/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import ContactsUI
import FirebaseDatabase
import FirebaseAuth
import Firebase
import FirebaseStorage

//Created Delegate method for storing data, After verifying Flat members Mobile Number
protocol FamilyDataPass {
    func familydataPassing()
}

class AddMyFamilyMembersViewController: NANavigationViewController, CNContactPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,AlertViewDelegate, FamilyDataPass {
    
    @IBOutlet weak var img_Profile: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_OR: UILabel!
    @IBOutlet weak var lbl_OTPDescription: UILabel!
    @IBOutlet weak var lbl_Relation: UILabel!
    @IBOutlet weak var lbl_GrantAccess: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    @IBOutlet weak var superView: UIView!
    
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Mobile_Validation: UILabel!
    @IBOutlet weak var lbl_Picture_Validation: UILabel!
    @IBOutlet weak var lbl_Email_Validation: UILabel!
    @IBOutlet weak var lbl_Relation_Validation: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    
    @IBOutlet weak var btn_SelectContact: UIButton!
    @IBOutlet weak var btn_addDetails: UIButton!
    
    @IBOutlet weak var Relation_Segment: UISegmentedControl!
    @IBOutlet weak var grantAcess_Segment: UISegmentedControl!
    
    var userDataRef : DatabaseReference?
    var userFlatDetailsRef : DatabaseReference?
    var userPersonalDetailsRef : DatabaseReference?
    var userPrivilegesRef : DatabaseReference?
    var userUIDRef : DatabaseReference?
    var userAllRef : DatabaseReference?
    var userFamilyMemberRef : DatabaseReference?
    var currentUserRef : DatabaseReference?
    
    /* - Scrollview.
     - To set navigation title.
     - Gettig data from previous screen string. */
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var timer = Timer()
    var count = 3
    
    var navTitle: String?
    
    var AddOtpString = String()
    var familyMember = String()
    var friend = String()
    var familyType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* - Create Name textfield first letter capital.
         - Add border color and round Image on profile image.
         - Hiding error labels.
         - Assigned delegate methods and Black underline for textFields.
         - TapGasture for upload new image.
         - Label,Button and TextField formatting & setting. */
        
        txt_Name.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        img_Profile.layer.borderColor = UIColor.black.cgColor
        
        lbl_Name_Validation.isHidden = true
        lbl_Mobile_Validation.isHidden = true
        lbl_Picture_Validation.isHidden = true
        lbl_Email_Validation.isHidden = true
        lbl_Relation_Validation.isHidden = true
        
        txt_Name.delegate = self
        txt_CountryCode.delegate = self
        txt_MobileNo.delegate = self
        txt_Email.delegate = self
        
        super.ConfigureNavBarTitle(title: navTitle!)
        self.navigationItem.title = ""
        
        //Setting By defalut No selection in Segment Control
        Relation_Segment.selectedSegmentIndex = UISegmentedControlNoSegment
        
        img_Profile.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.img_Profile.addGestureRecognizer(tapGesture)
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0)
        
        txt_Name.underlined()
        txt_MobileNo.underlined()
        txt_Email.underlined()
        
        self.lbl_OR.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_OTPDescription.font = NAFont().popupViewFont()
        self.lbl_Relation.font = NAFont().headerFont()
        self.lbl_Email.font = NAFont().headerFont()
        self.lbl_GrantAccess.font = NAFont().headerFont()
        self.lbl_Name_Validation.font = NAFont().descriptionFont()
        self.lbl_Mobile_Validation.font = NAFont().descriptionFont()
        self.lbl_Picture_Validation.font = NAFont().descriptionFont()
        self.lbl_Email_Validation.font = NAFont().descriptionFont()
        self.lbl_Relation_Validation.font = NAFont().descriptionFont()
        self.lbl_OTPDescription.text = NAString().otp_message_family_member(name:NAString().family_Member())
        self.lbl_Relation.text = NAString().relation()
        self.lbl_GrantAccess.text = NAString().grant_access()
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_Email.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().headerFont()
        self.txt_CountryCode.text = NAString()._91()
        
        self.btn_SelectContact.backgroundColor = NAColor().buttonBgColor()
        self.btn_SelectContact.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_SelectContact.setTitle(NAString().BtnselectFromContact().capitalized, for: .normal)
        
        self.btn_addDetails.backgroundColor = NAColor().buttonBgColor()
        self.btn_addDetails.setTitle(NAString().add().uppercased(), for: .normal)
        self.btn_addDetails.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        self.btn_SelectContact.titleLabel?.font = NAFont().buttonFont()
        self.btn_addDetails.titleLabel?.font = NAFont().buttonFont()
        
        self.img_Profile.layer.cornerRadius = self.img_Profile.frame.size.width/2
        img_Profile.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if self.view.frame.origin.y >= 0 {
            self.view.frame.origin.y -= 150
        }
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 150
    }
    
    // Create name textField first letter capital function and RelationSegment Action.
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    @IBAction func relationSegmentAction() {
        if Relation_Segment.selectedSegmentIndex == 0 {
            lbl_Relation_Validation.isHidden = true
            lbl_OTPDescription.text = NAString().otp_message_family_member(name: NAString().family_Member())
            familyMember = lbl_OTPDescription.text!
        } else {
            lbl_Relation_Validation.isHidden = true
            lbl_OTPDescription.text = NAString().otp_message_family_member(name:NAString().friend())
            friend = lbl_OTPDescription.text!
        }
    }
    
    /* - Alert Popup when user give  grant access & try to add details and Showing alert controller while giving Grant Access to family members.
     - AddFamily_UseID.
     - Creating Accept alert actions. */
    
    func grantAccessAlert() {
        
        let alert = UIAlertController(title:nil , message: NAString().edit_my_family_member_grantAccess_alertBox(first:NAString().granting_access()), preferredStyle: .alert)
        
        let rejectAction = UIAlertAction(title:NAString().reject(), style: .cancel) { (action) in }
        
        let acceptAction = UIAlertAction(title:NAString().accept(), style: .default) { (action) in
            
            let lv = NAViewPresenter().otpViewController()
            let familyString = NAString().enter_verification_code(first: NAString().your_Family_Member(), second: NAString().their())
            lv.newOtpString = familyString
            self.navigationController?.pushViewController(lv, animated: true)
        }
        alert.addAction(rejectAction)
        alert.addAction(acceptAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Function to appear select image from by tapping image.
    
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
        }
        else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts()
        }
            //Open App Setting if user cannot able to access Contacts
        else if authStatus == CNAuthorizationStatus.denied {
            //creating alert controller
            let alert = UIAlertController(title: NAString().setting_Permission_AlertBox() , message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NAString().cancel(), style: .cancel) { (action) in }
            let settingAction = UIAlertAction(title: NAString().settings(), style: .default) { (action) in
                UIApplication.shared.open(URL(string: "App-prefs:root=Privacy")!) }
            alert.addAction(cancelAction)
            alert.addAction(settingAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    /* - To call default address book app.
     - User select any contact particular part.
     - Retrive Data Alert View Delegate.
     - Create Timer Function,AlertView Action and OK button. */
    
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
            let range1 = mobileNumber.index(mobileNumber.startIndex, offsetBy: 2)..<mobileNumber.endIndex
            mobileNumber = String(mobileNumber[range1])
        }
        self.txt_MobileNo.text = mobileNumber
        lbl_Name_Validation.isHidden = true
        lbl_Mobile_Validation.isHidden = true
        txt_Name.underlined()
        txt_MobileNo.underlined()
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func activityIndicator_function(withData: Any) {
        btn_addDetails.tag = NAString().addMyFamilyMemberButtonTagValue()
        OpacityView.shared.addButtonTagValue = btn_addDetails.tag
    }
    
    func addAlertViewAction() {
        var alertController = UIAlertController()
        if familyType == familyMember {
            alertController = UIAlertController(title:NAString().addFamilyMember_AlertView_Title(), message:NAString().addFamilyMember_AlertView_Message(name:NAString().friend()), preferredStyle: .alert)
        } else {
            alertController = UIAlertController(title:NAString().addFamilyMember_AlertView_Title(), message:NAString().addFamilyMember_AlertView_Message(name: NAString().family_Member()), preferredStyle: .alert)
        }
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            let lv = NAViewPresenter().mySweetHomeVC()
            lv.navTitle = NAString().my_sweet_home()
            lv.fromMySweetHomeScreenVC = true
            self.navigationController?.pushViewController(lv, animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    @IBAction func btn_Action_addDetails(_ sender: UIButton) {
        let providedEmailAddress = txt_Email.text
        let isEmailAddressIsValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        if !(txt_Email.text?.isEmpty)! {
            if isEmailAddressIsValid {
                lbl_Email_Validation.isHidden = true
                txt_Email.underlined()
            } else {
                lbl_Email_Validation.isHidden = false
                lbl_Email_Validation.text = NAString().please_enter_Valid_email()
                txt_Email.redunderlined()
            }
        }
        if img_Profile.image == #imageLiteral(resourceName: "ExpectingVisitor") {
            lbl_Picture_Validation.isHidden = false
            lbl_Picture_Validation.text = NAString().please_upload_Image()
        }
        if (txt_Name.text?.isEmpty)! {
            lbl_Name_Validation.isHidden = false
            lbl_Name_Validation.text = NAString().please_enter_name()
            txt_Name.redunderlined()
        } else {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if (txt_Email.text?.isEmpty)! {
            lbl_Email_Validation.isHidden = false
            lbl_Email_Validation.text = NAString().please_enter_email()
            txt_Email.redunderlined()
        }
        if  Relation_Segment.selectedSegmentIndex == UISegmentedControlNoSegment {
            lbl_Relation_Validation.isHidden = false
            lbl_Relation_Validation.text = NAString().Please_select_atleast_oneRelation()
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
        if !(txt_Name.text?.isEmpty)! && isEmailAddressIsValid == true && txt_MobileNo.text?.count == NAString().required_mobileNo_Length() && img_Profile.image != #imageLiteral(resourceName: "ExpectingVisitor") {
            if(grantAcess_Segment.selectedSegmentIndex == 0) {
                //calling AlertBox on click of YES
                grantAccessAlert()
            } else {
                self.txt_Email.endEditing(true)
                let destVC = NAViewPresenter().otpViewController()
                var segmentType = String()
                if familyType == familyMember {
                    segmentType = NAString().enter_verification_code(first: NAString().your_Friend(), second: NAString().their())
                } else {
                    segmentType = NAString().enter_verification_code(first:NAString().your_Family_Member(), second: NAString().their())
                }
                destVC.newOtpString = segmentType
                destVC.getCountryCodeString = self.txt_CountryCode.text!
                destVC.getMobileString = self.txt_MobileNo.text!
                //Assigning Delegate
                destVC.familyDelegateData = self
                destVC.familyMemberType = segmentType
                destVC.delegate = self
                familyMemberExistsOrNot(VC: destVC)
            }
        }
    }
    
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
    
    //Accept only 10 digit mobile number and Check for Text Removal. 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_Name {
            lbl_Name_Validation.isHidden = true
            txt_Name.underlined()
        }
        if textField == txt_Email {
            lbl_Email_Validation.isHidden = true
            txt_Email.underlined()
        }
        if textField == txt_MobileNo {
            lbl_Mobile_Validation.isHidden = true
            txt_MobileNo.underlined()
            if NAValidation().isValidMobileNumber(isNewMobileNoLength: newLength) {
            }
            
            if string.isEmpty {
                return true
            } else {
                return newLength <= NAString().required_mobileNo_Length()
            }
        }
        return true
    }
}

extension AddMyFamilyMembersViewController {
    
    func familydataPassing() {
        storingFamilyMembers()
    }
    
    func storingFamilyMembers() {
        //Showing PopupView
        OpacityView.shared.showingOpacityView(view: self)
        OpacityView.shared.showingPopupView(view: self)
        
        let familyMemberUID = Auth.auth().currentUser?.uid
        
        //Map flat Members UID to true in UserData
        userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_FLATMEMBERS)
        userDataRef?.child(familyMemberUID!).setValue(NAString().gettrue())
        
        //Map family member's mobile number with uid in users->all
        userAllRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_ALL)
        userAllRef?.child(self.txt_MobileNo.text!).setValue(familyMemberUID)
        
        //Storing Flat details in firebase under users->private->family member uid
        userFlatDetailsRef =  Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(familyMemberUID!).child(Constants.FIREBASE_CHILD_FLATDETAILS)
        
        let usersFlatData = [
            UserFlatListFBKeys.apartmentName.key : GlobalUserData.shared.flatDetails_Items.first?.apartmentName,
            UserFlatListFBKeys.city.key : GlobalUserData.shared.flatDetails_Items.first?.city,
            UserFlatListFBKeys.flatNumber.key : GlobalUserData.shared.flatDetails_Items.first?.flatNumber,
            UserFlatListFBKeys.societyName.key : GlobalUserData.shared.flatDetails_Items.first?.societyName,
            UserFlatListFBKeys.tenantType.key : GlobalUserData.shared.flatDetails_Items.first?.tenantType
        ]
        userFlatDetailsRef?.setValue(usersFlatData)
        //Storing new flat member Personal details in firebase under users->private->family member uid
        userPersonalDetailsRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(familyMemberUID!).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        
        //Storing FlatMembers data along with their profile photo
        var familyImageRef: StorageReference?
        familyImageRef = Storage.storage().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(familyMemberUID!).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        
        //Compressing profile image and assigning its content type.
        guard let image = img_Profile.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
        
        let metaDataContentType = StorageMetadata()
        metaDataContentType.contentType = "image/jpeg"
        
        //Uploading Visitor image url along with Visitor UID
        let uploadImageRef = familyImageRef?.child(familyMemberUID!)
        let uploadTask = uploadImageRef?.putData(imageData, metadata: metaDataContentType, completion: { (metadata, error) in
            
            uploadImageRef?.downloadURL(completion: { (url, urlError) in
                
                if urlError == nil {
                    
                    let usersPersonalData = [
                        UserPersonalListFBKeys.email.key : self.txt_Email.text as String?,
                        UserPersonalListFBKeys.fullName.key : self.txt_Name.text as String?,
                        UserPersonalListFBKeys.profilePhoto.key : url?.absoluteString,
                        UserPersonalListFBKeys.phoneNumber.key : self.txt_MobileNo.text as String?
                    ]
                    self.userPersonalDetailsRef?.setValue(usersPersonalData)
                    
                    //Hiding PopupView & Showing Alert After Adding Data in Firebase.
                    OpacityView.shared.hidingOpacityView()
                    OpacityView.shared.hidingPopupView()
                    self.addAlertViewAction()
                } else {
                    print(urlError as Any)
                }
            })
        })
        uploadTask?.resume()
        
        //Checking Relation Status
        if Relation_Segment.selectedSegmentIndex == 0 {
            currentUserRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID).child(Constants.FIREBASE_CHILD_FAMILY_MEMBERS).child(familyMemberUID!)
            currentUserRef?.setValue(NAString().gettrue())
            
            userFamilyMemberRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(familyMemberUID!).child(Constants.FIREBASE_CHILD_FAMILY_MEMBERS).child(userUID)
            userFamilyMemberRef?.setValue(NAString().gettrue())
        } else {
            currentUserRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID).child(Constants.FIREBASE_CHILD_FRIENDS).child(familyMemberUID!)
            currentUserRef?.setValue(NAString().gettrue())
            
            userFamilyMemberRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(familyMemberUID!).child(Constants.FIREBASE_CHILD_FRIENDS).child(userUID)
            userFamilyMemberRef?.setValue(NAString().gettrue())
        }
        
        //Storing new flat member Privileges in firebase under users->private->family member uid
        userPrivilegesRef =  Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(familyMemberUID!).child(Constants.FIREBASE_CHILD_PRIVILEGES)
        
        var grantAccessValue: Bool?
        if grantAcess_Segment.selectedSegmentIndex == 0 {
            grantAccessValue = NAString().gettrue()
        } else {
            grantAccessValue = NAString().getfalse()
        }
        
        let userPrivilegesData = [
            UserPrivilegesListFBKeys.admin.key : NAString().getfalse(),
            UserPrivilegesListFBKeys.grantedAccess.key : grantAccessValue,
            UserPrivilegesListFBKeys.verified.key : NAString().getfalse()
        ]
        userPrivilegesRef?.setValue(userPrivilegesData)
        
        //Store family member's UID under users data structure for future use
        userUIDRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(familyMemberUID!).child(Constants.FIREBASE_CHILD_UID)
        userUIDRef?.setValue(familyMemberUID!)
    }
}

extension AddMyFamilyMembersViewController {
    
    func familyMemberExistsOrNot(VC: UIViewController)  {
        
        let familyMemberMobileRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_ALL)
        familyMemberMobileRef.observeSingleEvent(of: .value) { (mobileSnapshot) in
            
            var count = 0
            let mobileNumbers = mobileSnapshot.value as! NSDictionary
            for mobileNumber in mobileNumbers.allKeys {
                count = count + 1
                if (mobileNumber as? String == self.txt_MobileNo.text)  {
                    self.lbl_Mobile_Validation.isHidden = false
                    self.lbl_Mobile_Validation.text = NAString().mobileNumberAlreadyExists()
                }
                if count == mobileNumbers.count && self.lbl_Mobile_Validation.isHidden == true {
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }
        }
    }
}

