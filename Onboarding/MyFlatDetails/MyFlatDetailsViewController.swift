//
//  myFlatDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

//Calling class & adding in singleton class to get values
class SingletonFlatDetails {
    static let shared = SingletonFlatDetails()
    var flatDetails = [UserFlatDetails]()
}
//Creating Array variable to access item of FlatDetails class.
var flatDetails = [UserFlatDetails]()

class MyFlatDetailsViewController: NANavigationViewController {
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var segment_ResidentType: UISegmentedControl!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtApartment: UITextField!
    @IBOutlet weak var txtSociety: UITextField!
    @IBOutlet weak var txtFlat: UITextField!
    @IBOutlet weak var lbl_City: UILabel!
    @IBOutlet weak var lbl_Apartment: UILabel!
    @IBOutlet weak var lbl_Flat: UILabel!
    @IBOutlet weak var lbl_Society: UILabel!
    @IBOutlet weak var lbl_ResidentType: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var cities = [String]()
    var societyDatabaseURL = String()
    var otpVC = OTPViewController()
    
    //placeHolder instance
    var placeHolder = NSMutableAttributedString()
    
    var cityString = String()
    var societyString = String()
    var apartmentString = String()
    var flatString = String()
    var selectedSegmentValue = String()
    
    var newProfileImage: UIImage!
    var newMobileNumber = String()
    var newEmail = String()
    var newFullName = String()
    var fullName = String()
    
    //Firebase Database Reference
    var usersFlatDetailsRef : DatabaseReference?
    var usersPrivilegeDetailsRef : DatabaseReference?
    
    //Firebase Database Reference
    var usersPersonalDetailsRef : DatabaseReference?
    var usersUIDRef : DatabaseReference?
    var UsersDataRef : DatabaseReference?
    var usersMobileNumberRef : DatabaseReference?
    var userFlatMemberRef : DatabaseReference?
    var userNotificationSoundRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To hide keyboard on textFiled click
        txtFlat.inputView = UIView()
        txtApartment.inputView = UIView()
        txtSociety.inputView = UIView()
        txtCity.inputView = UIView()
        
        //To get Selected Segment text
        if segment_ResidentType.selectedSegmentIndex == 0 {
            selectedSegmentValue = NAString().owner()
        } else {
            selectedSegmentValue = NAString().tenant()
        }
        
        self.txtCity.text = cityString
        self.txtSociety.text = societyString
        self.txtApartment.text = apartmentString
        self.txtFlat.text = flatString
        
        //Assigning Delegates to TextFields
        txtCity.delegate = self
        txtFlat.delegate = self
        txtSociety.delegate = self
        txtApartment.delegate = self
        
        //hiding all other items on view load except city
        hideDetailsofSociety()
        hideDetailsofAppartment()
        hideDetailsofFlat()
        hideDetailsofResidentandContinueButton()
        
        //TextField formatting & setting
        txtCity.font = NAFont().textFieldFont()
        txtSociety.font = NAFont().textFieldFont()
        txtFlat.font = NAFont().textFieldFont()
        txtApartment.font = NAFont().textFieldFont()
        
        //Label formatting & setting
        lbl_City.font = NAFont().headerFont()
        lbl_Flat.font = NAFont().headerFont()
        lbl_Society.font = NAFont().headerFont()
        lbl_Apartment.font = NAFont().headerFont()
        lbl_ResidentType.font = NAFont().headerFont()
        lbl_Description.font = NAFont().popupViewFont()
        
        lbl_City.text = NAString().city()
        lbl_Society.text = NAString().society()
        lbl_Flat.text = NAString().flat()
        lbl_Apartment.text = NAString().apartment()
        lbl_ResidentType.text = NAString().resident_type()
        lbl_Description.text = NAString().verification_message()
        
        //Button formatting & setting
        btnContinue.backgroundColor = NAColor().buttonBgColor()
        btnContinue.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnContinue.titleLabel?.font = NAFont().buttonFont()
        btnContinue.setTitle(NAString().continue_button(), for: .normal)
        
        scrollView.layoutIfNeeded()
        self.view.layoutIfNeeded()
        
        //Set Textfield bottom border line
        txtCity.underlined()
        txtFlat.underlined()
        txtSociety.underlined()
        txtApartment.underlined()
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        
        //Created custom back button for going back to Signup VC
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToSignupVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = nil
        
        //set Title in Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().My_flat_Details_title())
    }
    
    func flatDetailsAlertView() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().flat_AlertTitle() , message: NAString().flat_AlertMessage(admin:fullName), preferredStyle: .alert)
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
            OpacityView.shared.hidingOpacityView()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //Action for Navigating Back to SignupVC 
    @objc func goBackToSignupVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtCity.text = cityString
        self.txtSociety.text = societyString
        self.txtApartment.text = apartmentString
        self.txtFlat.text = flatString
        
        if !(txtCity.text?.isEmpty)! && lbl_Society.isHidden == true {
            txtSociety.isHidden = false
            lbl_Society.isHidden = false
            txtSociety.text = ""
        } else if !(txtSociety.text?.isEmpty)! && txtApartment.isHidden == true {
            txtApartment.isHidden = false
            lbl_Apartment.isHidden = false
            txtApartment.text = ""
        } else if !(txtApartment.text?.isEmpty)! && txtFlat.isHidden == true {
            txtFlat.isHidden = false
            lbl_Flat.isHidden = false
            txtFlat.text = ""
        } else if !(txtFlat.text?.isEmpty)! && lbl_ResidentType.isHidden == true {
            lbl_ResidentType.isHidden = false
            segment_ResidentType.isHidden = false
        }
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        
        //Assigning tag value to butto to show popView Title based of button.
        btnContinue.tag = NAString().continueButtonTagValue()
        OpacityView.shared.addButtonTagValue = btnContinue.tag
        OpacityView.shared.showingOpacityView(view: self)
        OpacityView.shared.showingPopupView(view: self)
        
        let databaseURLRef = Constants.FIREBASE_DATABASE_REFERENCE.child("customers").child(Constants.FIREBASE_CHILD_PRIVATE).child("cities").child(txtCity.text!).child("societies").child(txtSociety.text!).child("databaseURL")
        databaseURLRef.observeSingleEvent(of: .value, with: { (URLSnapshot) in
            self.societyDatabaseURL = (URLSnapshot.value as? String)!
            
            //Mapping Mobile number with Database URL for Login Purpose
            let usersAllRef = Constants.FIREBASE_USERS_ALL
            usersAllRef?.child(self.newMobileNumber).setValue(self.societyDatabaseURL, withCompletionBlock: { (error, ref) in
                
                if error == nil {
                    self.otpVC.changeDatabaseInstance(databaseURL: self.societyDatabaseURL)
                    
                    //Calling Function to store UserFlatDetails & Privileges
                    self.storeUsersDetailsInFirebase()
                } else {
                    print("Failure")
                }
            })
        })
    }
    
    @IBAction func btnResidentType(_ sender: Any) {
        lbl_Description.isHidden = false
        btnContinue.isHidden = false
        self.view.endEditing(true)
    }
    
    func hideDetailsofSociety() {
        lbl_Society.isHidden = true
        txtSociety.isHidden = true
        txtSociety.text = ""
    }
    
    func hideDetailsofAppartment() {
        lbl_Apartment.isHidden = true
        txtApartment.isHidden = true
        txtApartment.text = ""
    }
    
    func hideDetailsofFlat() {
        lbl_Flat.isHidden = true
        txtFlat.isHidden = true
        txtFlat.text = ""
    }
    
    func hideDetailsofResidentandContinueButton() {
        lbl_ResidentType.isHidden = true
        segment_ResidentType.isHidden = true
        segment_ResidentType.selectedSegmentIndex = UISegmentedControlNoSegment
        lbl_Description.isHidden = true
        btnContinue.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case txtCity:
            hideDetailsofSociety()
            hideDetailsofAppartment()
            hideDetailsofFlat()
            hideDetailsofResidentandContinueButton()
        case txtSociety:
            hideDetailsofAppartment()
            hideDetailsofFlat()
            hideDetailsofResidentandContinueButton()
        case txtApartment:
            hideDetailsofFlat()
            hideDetailsofResidentandContinueButton()
        case txtFlat:
            hideDetailsofResidentandContinueButton()
        default:
            break
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let searchVC = self.storyboard!.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
        let nav : UINavigationController = UINavigationController(rootViewController: searchVC)
        
        if textField == txtCity {
            searchVC.navigationTitle = NAString().your_city()
            txtCity.resignFirstResponder()
        } else if textField == txtSociety {
            searchVC.textFieldText = self.txtCity.text!
            searchVC.navigationTitle = NAString().your_society()
            txtSociety.resignFirstResponder()
        } else if textField == txtApartment {
            searchVC.navigationTitle = NAString().your_apartment()
            searchVC.textFieldText = self.txtSociety.text!
            txtApartment.resignFirstResponder()
        } else if textField == txtFlat {
            searchVC.navigationTitle = NAString().your_flat()
            searchVC.textFieldText = self.txtApartment.text!
            txtFlat.resignFirstResponder()
        }
        searchVC.myFlatDetailsVC = self
        self.navigationController?.present(nav, animated: true, completion: nil)
        return true
    }
    
    //function to end editing on the touch on the view
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension MyFlatDetailsViewController {
    
    //Save User Personal Details
    func storeUsersDetailsInFirebase() {
        var userPrivateRef : DatabaseReference
        let userUID = Auth.auth().currentUser?.uid
        
        //User Private Reference
        userPrivateRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID!)
        
        //Flat Details Firebase DB Reference
        usersFlatDetailsRef = userPrivateRef.child(Constants.FIREBASE_CHILD_FLATDETAILS)
        
        //Privileges Details Firebase DB Reference
        usersPrivilegeDetailsRef = userPrivateRef.child(Constants.FIREBASE_CHILD_PRIVILEGES)
        
        //Personal Details Firebase DB Reference
        usersPersonalDetailsRef = userPrivateRef.child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        
        //Other Details Firebase DB Reference
        let usersOtherDetailsRef = userPrivateRef.child(Constants.FIREBASE_CHILD_OTHER_DETAILS)
        
        //Storing Data Under UsersData
        UsersDataRef = Constants.FIREBASE_USERDATA_PRIVATE.child(txtCity.text!).child(txtSociety.text!).child(txtApartment.text!).child(txtFlat.text!)
        
        UsersDataRef?.observeSingleEvent(of: .value) { (flatDetailsSnapshot) in
            if flatDetailsSnapshot.exists() {
                let adminUIDRef = self.UsersDataRef?.child(Constants.FIREBASE_CHILD_ADMIN)
                adminUIDRef?.observeSingleEvent(of: .value) { (adminUIDSnapshot) in
                    let adminUID = adminUIDSnapshot.value
                    let adminNameRef = Constants.FIREBASE_USERS_PRIVATE.child(adminUID as! String).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
                    adminNameRef.observeSingleEvent(of: .value) { (adminNameSnapshot) in
                        let usersData = adminNameSnapshot.value as? [String: AnyObject]
                        self.fullName = (usersData?[UserPersonalListFBKeys.fullName.key] as? String)!
                        OpacityView.shared.hidingPopupView()
                        self.flatDetailsAlertView()
                    }
                }
            } else {
                //Storing Data into User Flat Details
                let usersFlatData = [
                    UserFlatListFBKeys.apartmentName.key : self.txtApartment.text! as String?,
                    UserFlatListFBKeys.city.key : self.txtCity.text! as String?,
                    UserFlatListFBKeys.flatNumber.key : self.txtFlat.text! as String?,
                    UserFlatListFBKeys.societyName.key : self.txtSociety.text! as String?,
                    UserFlatListFBKeys.tenantType.key : self.selectedSegmentValue
                ]
                
                //Storing Data into User Privileges
                let userPrivilegesData = [
                    UserPrivilegesListFBKeys.admin.key : NAString().gettrue(),
                    UserPrivilegesListFBKeys.grantedAccess.key : NAString().gettrue(),
                    UserPrivilegesListFBKeys.verified.key : Constants.FIREBASE_CHILD_VERIFIED_PENDING
                    ] as [String : Any]
                
                //Maping UsersUID with admin
                self.UsersDataRef?.child(Constants.FIREBASE_CHILD_ADMIN).setValue(userUID)
                
                //Adding usersFlatDetails data under Users/Private/UID
                self.usersFlatDetailsRef?.setValue(usersFlatData)
                
                //Adding usersPrivilegesDetails data under Users/Private/UID
                self.usersPrivilegeDetailsRef?.setValue(userPrivilegesData)
                
                //Adding Time Stamp in Other Details
                usersOtherDetailsRef.child(Constants.FIREBASE_CHILD_TIMESTAMP).setValue(Int64(Date().timeIntervalSince1970 * 1000))
                
                //Storing Data into User Personal Details
                //Storing users data along with their profile photo
                var usersImageRef: StorageReference?
                usersImageRef = Storage.storage().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_CHILD_PRIVATE)
                
                //Compressing profile image and assigning its content type.
                guard let image = self.newProfileImage else { return }
                guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
                
                let metaDataContentType = StorageMetadata()
                metaDataContentType.contentType = NAString().imageContentType()
                
                //Uploading Visitor image url along with Visitor UID
                let uploadImageRef = usersImageRef?.child(userUID!)
                
                let uploadTask = uploadImageRef?.putData(imageData, metadata: metaDataContentType, completion: { (metadata, error) in
                    
                    uploadImageRef?.downloadURL(completion: { (url, urlError) in
                        
                        if urlError == nil {
                            
                            let usersPersonalData = [
                                UserPersonalListFBKeys.email.key : self.newEmail,
                                UserPersonalListFBKeys.fullName.key : self.newFullName,
                                UserPersonalListFBKeys.profilePhoto.key : url?.absoluteString,
                                UserPersonalListFBKeys.phoneNumber.key : self.newMobileNumber
                            ]
                            
                            //Adding users data under  Users/Private/UID & mapping UID
                            self.usersPersonalDetailsRef?.setValue(usersPersonalData)
                            
                            //Storing UID under Users/Private/UID
                            self.usersUIDRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID!)
                            self.usersUIDRef?.child(NAUser.NAUserStruct.uid).setValue(userUID)
                            
                            //Mapping Mobile Number with UID
                            
                            self.usersMobileNumberRef = Constants.FIREBASE_USERS_ALL
                            self.usersMobileNumberRef?.child(self.newMobileNumber).setValue(userUID)
                            
                            //Storing Flat Member UID
                            self.userFlatMemberRef = Constants.FIREBASE_USERDATA_PRIVATE.child(self.txtCity.text!).child(self.txtSociety.text!).child(self.txtApartment.text!).child(self.txtFlat.text!).child(Constants.FIREBASE_CHILD_FLATMEMBERS)
                            
                            self.userFlatMemberRef?.child(userUID!).setValue(NAString().gettrue())
                            
                            let preferences = UserDefaults.standard
                            let accountCreated = NAString().userDefault_Account_Created()
                            let UserUID = NAString().userDefault_USERUID()
                            preferences.set(true, forKey: accountCreated)
                            preferences.set(userUID, forKey: UserUID)
                            preferences.synchronize()
                            
                            //Navigate to Namma Apartment Welcome Screen After Storing all users data.
                            
                            let dest = NAViewPresenter().activationRequiredVC()
                            self.navigationController?.pushViewController(dest, animated: true)
                            
                            //Using else statement & printing error,so the other developers can know what is going on.                            
                        } else {
                            print(urlError as Any)
                        }
                    })
                })
                uploadTask?.resume()
            }
        }
    }
}


