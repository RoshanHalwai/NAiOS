//
//  EditMyProfileViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 01/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class EditMyProfileViewController: NANavigationViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profile_Image: UIImageView!
    @IBOutlet weak var cardView_Image: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_EmailID: UILabel!
    @IBOutlet weak var lbl_Flat_Admin: UILabel!
    @IBOutlet weak var lbl_EIntercom: UILabel!
    @IBOutlet weak var lbl_EIntercomNumber: UILabel!
    @IBOutlet weak var lbl_EIntercomSerialNo: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_EmailId: UITextField!
    @IBOutlet weak var txt_Flat_Admin: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var gatePass_btn: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var updateUserRef : DatabaseReference?
    var familyMemberNameRef : DatabaseReference?
    
    var navTitle = String()
    var selectedMember = String()
    var flatMembersNameList = [String]()
    var allFlatMembersUID = [String]()
    
    var existedName : String?
    var existedEmail : String?
    var existedFlatAdmin : String?
    var adminUID : String?
    var updatedAdminUID : String?
    let imagePickerController = UIImagePickerController()
    
    /* - Creating Text Field Action for Name for first letter to be Capital.
     - Assigning Delegates for text fields and Tableview & Removing Separator lines for tableview cells.
     - Creating Round Image using Corner Radius and Giving Scroll view EdgeInset Values.
     - Implemented Tap Gesture to Upload Image & resign PopUp Screen. */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parentView.layoutIfNeeded()
        self.parentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + 40)
        NAShadowEffect().shadowEffectForView(view: cardView)
        
        //Button Formatting & settings
        gatePass_btn.setTitle(NAString().myGatePass(), for: .normal)
        gatePass_btn.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        gatePass_btn.backgroundColor = NAColor().buttonBgColor()
        gatePass_btn.titleLabel?.font = NAFont().buttonFont()
        
        //Hiding Keyboard on click of FlatAdmin textFiled
        txt_Flat_Admin.inputView = UIView()
        txt_Flat_Admin.tintColor = UIColor.clear
        txt_Name.inputView = UIView()
        txt_EmailId.inputView = UIView()
        imagePickerController.delegate = self
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        scrollView.layoutIfNeeded()
        self.view.layoutIfNeeded()
        txt_Name.underlined()
        txt_EmailId.underlined()
        txt_Flat_Admin.underlined()
        
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        txt_Name.delegate = self
        txt_EmailId.delegate = self
        txt_Flat_Admin.delegate = self
        
        lbl_EIntercom.text = NAString().eIntercom()
        lbl_EIntercomSerialNo.text = NAString()._91()
        
        lbl_Name.font = NAFont().headerFont()
        lbl_Flat_Admin.font = NAFont().headerFont()
        lbl_EmailID.font = NAFont().headerFont()
        lbl_EIntercom.font = NAFont().headerFont()
        
        txt_Name.font = NAFont().textFieldFont()
        txt_EmailId.font = NAFont().textFieldFont()
        txt_Flat_Admin.font = NAFont().textFieldFont()
        lbl_EIntercomSerialNo.font = NAFont().layoutFeatureErrorFont()
        lbl_EIntercomNumber.font = NAFont().layoutFeatureErrorFont()
        
        self.profile_Image.layer.cornerRadius = self.profile_Image.frame.size.width/2
        self.profile_Image.layer.cornerRadius = self.profile_Image.frame.size.height/2
        profile_Image.clipsToBounds = true
        
        profile_Image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.profile_Image.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let userDataRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            let usersData = userDataSnapshot.value as? [String: AnyObject]
            
            //Creating instance of UserPersonalDetails
            let userPersonalDataMap = usersData?[Constants.FIREBASE_CHILD_PERSONALDETAILS] as? [String: AnyObject]
            let profilePhoto = userPersonalDataMap?[UserPersonalListFBKeys.profilePhoto.key] as? String
            
            let queue = OperationQueue()
            
            queue.addOperation {
                //Calling function to get Profile Image from Firebase.
                if let urlString = profilePhoto {
                    self.downloadImageFromServerURL(urlString: urlString,imageView: self.profile_Image)
                }
            }
            queue.waitUntilAllOperationsAreFinished()
        })
    }
    
    //Created Global function to get Profile image from firebase in Visitor List
    func downloadImageFromServerURL(urlString: String, imageView:UIImageView) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async(execute: { () -> Void in
                    imageView.image = image
                    self.activityIndicator.isHidden = true
                })
            }
        }).resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adminNameRef()
        let userDataRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            let usersData = userDataSnapshot.value as? [String: AnyObject]
            
            //Creating instance of UserPersonalDetails
            let userPersonalDataMap = usersData?[Constants.FIREBASE_CHILD_PERSONALDETAILS] as? [String: AnyObject]
            
            self.txt_Name.text = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
            self.txt_EmailId.text = userPersonalDataMap?[UserPersonalListFBKeys.email.key] as? String
            self.lbl_EIntercomNumber.text = userPersonalDataMap?[UserPersonalListFBKeys.phoneNumber.key] as? String
            self.existedName = self.txt_Name.text
            self.existedEmail = self.txt_EmailId.text
        })
    }
    
    @IBAction func myGatePassWayButtonAction() {
        let dv = NAViewPresenter().myGatePassVC()
        dv.navTitle = NAString().gatePass()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if self.view.frame.origin.y >= 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 100
    }
    
    //Getting Flat Admin Name
    func adminNameRef() {
        let userDataReference = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_ADMIN)
        userDataReference.observe(.value) { (snapshot) in
            self.adminUID = (snapshot.value as! String)
            
            let userRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
                .child(Constants.FIREBASE_CHILD_PRIVILEGES)
                .child(Constants.FIREBASE_CHILD_ADMIN)
            userRef.observeSingleEvent(of: .value, with: { (adminSnapshot) in
                let admin = adminSnapshot.value as? Bool
                if admin == true {
                    self.txt_Flat_Admin.text = NAString().you_are_the_Administrator()
                    self.existedFlatAdmin = self.txt_Flat_Admin.text
                } else {
                    let adminNameRef = Constants.FIREBASE_USERS_PRIVATE.child(self.adminUID!).child(Constants.FIREBASE_CHILD_PERSONALDETAILS).child(Constants.FIREBASE_CHILD_FULLNAME)
                    adminNameRef.observeSingleEvent(of: .value, with: { (nameSnapShot) in
                        self.txt_Flat_Admin.text = (nameSnapShot.value as! String)
                        self.existedFlatAdmin = self.txt_Flat_Admin.text
                    })
                }
            })
        }
    }
    
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
        let cancel = UIAlertAction(title: NAString().cancel(), style: .cancel, handler: { (alert: UIAlertAction!) -> Void in })
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        
        actionSheet.view.tintColor = UIColor.black
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.updateImageChange(image: image)
            profile_Image.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txt_Flat_Admin &&  GlobalUserData.shared.privileges_Items.first?.getAdmin() == true {
            let flatMembersReference = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_FLATMEMBERS)
            flatMembersReference.observeSingleEvent(of: .value) { (flatMembersUIDSnapshot) in
                if flatMembersUIDSnapshot.childrenCount == 1 {
                    self.txt_Flat_Admin.resignFirstResponder()
                    NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().change_Admin_Alert_Title(), Message: NAString().change_Admin_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default, OK: { (action) in })
                } else {
                    self.flatMembersNameList.removeAll()
                    let flatMembersUIDMap = flatMembersUIDSnapshot.value as? NSDictionary
                    for flatMemberUID in (flatMembersUIDMap?.allKeys)! {
                        if flatMemberUID as! String != userUID {
                            
                            //Getting all Flat Members names.
                            self.familyMemberNameRef = Constants.FIREBASE_USERS_PRIVATE.child(flatMemberUID as! String).child(Constants.FIREBASE_CHILD_PERSONALDETAILS).child(Constants.FIREBASE_CHILD_FULLNAME)
                            self.allFlatMembersUID.append(flatMemberUID as! String)
                            self.familyMemberNameRef?.observeSingleEvent(of: .value, with: { (nameSnapshot) in
                                self.flatMembersNameList.append(nameSnapshot.value as! String)
                                
                                let listVC = self.storyboard!.instantiateViewController(withIdentifier: "MyProfileListVC") as! EditMyProfileFlatMembersListViewController
                                let nav : UINavigationController = UINavigationController(rootViewController: listVC)
                                listVC.navigationTitle = NAString().flatMembers()
                                listVC.myProfileVC = self
                                self.navigationController?.present(nav, animated: true, completion: nil)
                            })
                        }
                    }
                }
            }
        } else if textField == self.txt_Name || textField == txt_EmailId {
            let vc = NAViewPresenter().myProfileDataVC()
            vc.name = self.txt_Name.text!
            vc.email = self.txt_EmailId.text!
            if textField == txt_Name {
                vc.navTitle = NAString().enter_your_data(name: NAString().profile_Name())
            } else if textField == txt_EmailId {
                vc.navTitle = NAString().enter_your_data(name: NAString().enter_email_Data())
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return true
    }
    
    //Calling Updated Image Function
    func updateImageChange(image: UIImage) {
        
        let updatedImageRef = Storage.storage().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_CHILD_PRIVATE).child(userUID)
        self.updateUserRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        
        //Compressing profile image and assigning its content type.
        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
        
        let metaDataContentType = StorageMetadata()
        metaDataContentType.contentType = NAString().imageContentType()
        
        //Uploading Visitor image url along with Visitor UID
        let uploadImageRef = updatedImageRef.child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        let uploadTask = uploadImageRef.putData(imageData, metadata: metaDataContentType, completion: { (metadata, error) in
            
            uploadImageRef.downloadURL(completion: { (url, urlError) in
                
                if urlError == nil {
                    self.updateUserRef?.child(Constants.FIREBASE_CHILD_PERSONALDETAILS_PROFILEIMAGE).setValue(url?.absoluteString)
                    //Setting the profilePhoto value in GlobalUser data after User Updated his Profile Photo
                    GlobalUserData.shared.personalDetails_Items.first?.setProfilePhoto(profilePhoto: (url?.absoluteString)!)
                    
                    //Using else statement & printing error,so the other developers can know what is going on.
                } else {
                    print(urlError as Any)
                }
            })
        })
        uploadTask.resume()
    }
}




