//
//  myFlatDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import FirebaseInstanceID
import FirebaseMessaging

class myFlatDetailsViewController: NANavigationViewController {
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
    
    //TODO : Need to get data from firebase
    var cities = ["Bengaluru", "Hyderabad", "Mumbai", "Delhi", "Bombay"]
    var societies = ["Brigade Gateway", "Salarpuria Cambridge"]
    var BrigadeGateway = ["Aster", "Bolivia"]
    var SalarpuriaCambridge = ["Block-1", "Block-2", "Block-3", "Block-4", "Block-5"]
    var Aster = ["A1001", "A1002", "A1003"]
    var Bolivia = ["B1001", "B1002", "B1003"]
    var Block1 = ["101", "102", "103", "104", "105"]
    var Block2 = ["201", "202", "203", "204", "205"]
    var Block3 = ["301", "302", "303", "304", "305"]
    var Block4 = ["401", "402", "403", "404", "405"]
    var Block5 = ["501", "502", "503", "504", "505"]
    
    //placeHolder instance
    var placeHolder = NSMutableAttributedString()
    
    var cityString = String()
    var societyString = String()
    var apartmentString = String()
    var flatString = String()
    var selectedSegmentValue = String()
    var newProfileImage: UIImage!
    
    //Firebase Database Reference
    var usersFlatDetailsRef : DatabaseReference?
    var usersPrivilegeDetailsRef : DatabaseReference?
    
    //Firebase Database Reference
    var usersPersonalDetailsRef : DatabaseReference?
    var usersUIDRef : DatabaseReference?
    var UsersDataRef : DatabaseReference?
    var usersMobileNoRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To get Selected Segment text
        if segment_ResidentType.selectedSegmentIndex == 0 {
            selectedSegmentValue = NAString().owner()
        }
        else {
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
        lbl_Description.font = NAFont().descriptionFont()
        
        txtCity.font = NAFont().textFieldFont()
        txtSociety.font = NAFont().textFieldFont()
        txtApartment.font = NAFont().textFieldFont()
        txtFlat.font = NAFont().textFieldFont()
        
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
        
        //Set Textfield bottom border line
        txtCity.underlined()
        txtFlat.underlined()
        txtSociety.underlined()
        txtApartment.underlined()
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        
        //Hiding Navigation bar Back Button
        self.navigationItem.hidesBackButton = true
        
        //set Title in Navigation Bar
        self.navigationItem.title = NAString().My_flat_Details_title()
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
        //Calling Function to store UserFlatDetails & Privileges
        storeUsersDetailsInFirebase()
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
        let searchVC = self.storyboard!.instantiateViewController(withIdentifier: "searchVC") as! SearchTableViewController
        let nav : UINavigationController = UINavigationController(rootViewController: searchVC)
        
        if textField == txtCity {
            searchVC.title = NAString().your_city()
            txtCity.resignFirstResponder()
        } else if textField == txtSociety {
            searchVC.title = NAString().your_society()
            txtSociety.resignFirstResponder()
        } else if textField == txtApartment {
            searchVC.title = NAString().your_apartment()
            txtApartment.resignFirstResponder()
        } else if textField == txtFlat {
            searchVC.title = NAString().your_flat()
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

extension myFlatDetailsViewController {
    
    //Save User Personal Details
    func storeUsersDetailsInFirebase() {
        
        //Flat Details Firebase DB Reference
        usersFlatDetailsRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(usersUID!).child(Constants.FIREBASE_CHILD_FLATDETAILS)
        
        //Privileges Details Firebase DB Reference
        usersPrivilegeDetailsRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(usersUID!).child(Constants.FIREBASE_CHILD_PRIVILEGES)
        
        //Personal Details Firebase DB Reference
        usersPersonalDetailsRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(usersUID!).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        
        //Storing Data Under UsersData
        UsersDataRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(txtCity.text!).child(txtSociety.text!).child(txtApartment.text!).child(txtFlat.text!)
        
        //Storing Data into User Flat Details
        let usersFlatData = [
            UserFlatListFBKeys.apartmentName.key : self.txtApartment.text! as String?,
            UserFlatListFBKeys.city.key : self.txtCity.text! as String?,
            UserFlatListFBKeys.flatNumber.key : self.txtFlat.text! as String?,
            UserFlatListFBKeys.societyName.key : self.txtSociety.text! as String?,
            UserFlatListFBKeys.tenantType.key : self.selectedSegmentValue
        ]
        
        //Storing Data into User Privileges
        //TODO: Hardcoded values for UserPrivileges for storing data in Firebase undr Users/Private/UID/Privileges
        let userPrivilegesData = [
            UserPrivilegesListFBKeys.admin.key : "true",
            UserPrivilegesListFBKeys.grantAccess.key : "true",
            UserPrivilegesListFBKeys.verified.key : "false"
        ]
        
        //Maping UsersUID with admin
        UsersDataRef?.child(Constants.FIREBASE_CHILD_ADMIN).setValue(usersUID!)
        
        //Adding usersFlatDetails data under Users/Private/UID
        self.usersFlatDetailsRef?.setValue(usersFlatData)
        
        //Adding usersPrivilegesDetails data under Users/Private/UID
        self.usersPrivilegeDetailsRef?.setValue(userPrivilegesData)
        
        //Storing Data into User Personal Details
        //Storing users data along with their profile photo
        var usersImageRef: StorageReference?
        usersImageRef = Storage.storage().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
        
        //Compressing profile image and assigning its content type.
        guard let image = newProfileImage else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
        
        let metaDataContentType = StorageMetadata()
        metaDataContentType.contentType = NAString().imageContentType()
        
        //Uploading Visitor image url along with Visitor UID
        let uploadImageRef = usersImageRef?.child(usersUID!)
        
        let uploadTask = uploadImageRef?.putData(imageData, metadata: metaDataContentType, completion: { (metadata, error) in
            
            uploadImageRef?.downloadURL(completion: { (url, urlError) in
                
                if urlError == nil {
                    
                    //Using singleton Class Reference to get data from UserDetails.
                    let values = Singleton.shared.UserDetails
                    let val = values.first
                    
                    //defining node with type of data in it.
                    let usersPersonalData = [
                        UserPersonalListFBKeys.email.key : val?.email,
                        UserPersonalListFBKeys.fullName.key : val?.fullName,
                        UserPersonalListFBKeys.profilePhoto.key : url?.absoluteString,
                        UserPersonalListFBKeys.phoneNumber.key : val?.phoneNumber
                    ]
                    
                    //Adding users data under  Users/Private/UID & mapping UID
                    self.usersPersonalDetailsRef?.setValue(usersPersonalData)
                    
                    //Storing UID under Users/Private/UID
                    self.usersUIDRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(usersUID!)
                    self.usersUIDRef?.child(NAUser.NAUserStruct.uid).setValue(usersUID)
                    
                    //Mapping Mobile Number with UID
                    self.usersMobileNoRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_ALL)
                    self.usersMobileNoRef?.child((val?.phoneNumber)!).setValue(usersUID)
                    
                    //Generating & Mapping TokenID under Users/Private/UID
                    let tokenID = Messaging.messaging().fcmToken
                    self.usersUIDRef?.child(NAUser.NAUserStruct.tokenId).setValue(tokenID)
                    
                    //Navigate to Namma Apartment Home Screen After Storing all users data.
                    let dest = NAViewPresenter().mainScreenVC()
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
