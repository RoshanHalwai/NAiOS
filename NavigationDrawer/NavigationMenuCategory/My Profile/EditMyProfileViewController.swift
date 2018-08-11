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

class EditMyProfileViewController: NANavigationViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profile_Image: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_EmailID: UILabel!
    @IBOutlet weak var lbl_Flat_Admin: UILabel!
    
    @IBOutlet weak var lbl_Picture_Validation: UILabel!
    @IBOutlet weak var lbl_Name_Validation: UILabel!
    @IBOutlet weak var lbl_Email_Validation: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_EmailId: UITextField!
    @IBOutlet weak var txt_Flat_Admin: UITextField!
    
    @IBOutlet weak var update_btn: UIButton!
    
    @IBOutlet weak var opacity_View: UIView!
    @IBOutlet weak var list_View: UIView!
    @IBOutlet weak var table_View: UITableView!
    
    @IBOutlet weak var list_View_Height_Constraint: NSLayoutConstraint!
    
    var updateUserRef : DatabaseReference?
    var familyMemberNameRef : DatabaseReference?
    
    var navTitle = String()
    var flatMembersNameList = [String]()
    var allFlatMembersUID = [String]()
    
    var existedName : String?
    var existedEmail : String?
    var existedFlatAdmin : String?
    var adminUID : String?
    var updatedAdminUID : String?
    var isImageChanged: Bool = false
    let imagePickerController = UIImagePickerController()
    
    /* - Creating Text Field Action for Name for first letter to be Capital.
     - Assigning Delegates for text fields and Tableview & Removing Separator lines for tableview cells.
     - Creating Round Image using Corner Radius and Giving Scroll view EdgeInset Values.
     - Implemented Tap Gesture to Upload Image & resign PopUp Screen. */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding Keyboard on click of FlatAdmin textFiled
        txt_Flat_Admin.inputView = UIView()
        imagePickerController.delegate = self
        
        let userDataRef = Database.database().reference().child(Constants.FIREBASE_USER)
            .child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID)
        userDataRef.keepSynced(true)
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            let usersData = userDataSnapshot.value as? [String: AnyObject]
            
            //Creating instance of UserPersonalDetails
            let userPersonalDataMap = usersData?["personalDetails"] as? [String: AnyObject]
            
            self.txt_Name.text = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
            self.txt_EmailId.text = userPersonalDataMap?[UserPersonalListFBKeys.email.key] as? String
            self.existedName = self.txt_Name.text
            self.existedEmail = self.txt_EmailId.text
            let profilePhoto = userPersonalDataMap?[UserPersonalListFBKeys.profilePhoto.key] as? String
            
            //Calling function to get Profile Image from Firebase.
            if let urlString = profilePhoto {
                NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: self.profile_Image)
            }
        })
        txt_Name.underlined()
        txt_EmailId.underlined()
        txt_Flat_Admin.underlined()
        
        super.ConfigureNavBarTitle(title: navTitle)
        
        txt_Name.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        opacity_View.isHidden = true
        list_View.isHidden = true
        
        txt_Name.delegate = self
        txt_EmailId.delegate = self
        txt_Flat_Admin.delegate = self
        table_View.delegate = self
        table_View.dataSource = self
        self.table_View.separatorStyle = .none
        
        lbl_Picture_Validation.isHidden = true
        lbl_Name_Validation.isHidden = true
        lbl_Email_Validation.isHidden = true
        
        lbl_Name.font = NAFont().headerFont()
        lbl_Flat_Admin.font = NAFont().headerFont()
        lbl_EmailID.font = NAFont().headerFont()
        
        txt_Name.font = NAFont().textFieldFont()
        txt_EmailId.font = NAFont().textFieldFont()
        txt_Flat_Admin.font = NAFont().textFieldFont()
        
        update_btn.titleLabel?.font = NAFont().buttonFont()
        
        let userDataReference = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_ADMIN)
        userDataReference.observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
            self.adminUID = (snapshot.value as! String)
            
            if GlobalUserData.shared.privileges_Items.first?.getAdmin() == true {
                self.txt_Flat_Admin.text = NAString().you_are_the_Administrator()
                self.existedFlatAdmin = self.txt_Flat_Admin.text
            } else {
                let adminNameRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(self.adminUID!).child(Constants.FIREBASE_CHILD_PERSONALDETAILS).child(Constants.FIREBASE_CHILD_FULLNAME)
                adminNameRef.observeSingleEvent(of: .value, with: { (nameSnapShot) in
                    self.txt_Flat_Admin.text = (nameSnapShot.value as! String)
                    self.existedFlatAdmin = self.txt_Flat_Admin.text
                })
            }
        }
        
        self.profile_Image.layer.cornerRadius = self.profile_Image.frame.size.width/2
        profile_Image.clipsToBounds = true
        
        profile_Image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.profile_Image.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        opacity_View.addGestureRecognizer(tap)
        
        
        //Implemented to get data content size to change height based on data
        self.table_View.addObserver(self, forKeyPath: NAString().tableView_Content_size(), options: NSKeyValueObservingOptions.new, context: nil)
    }
    //For Resizing TableView based on content
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        table_View.layer.removeAllAnimations()
        list_View_Height_Constraint.constant = table_View.contentSize.height + 37
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //On click of Flat Admin textField only Admin Can see the List of flat members.
        if textField == txt_Flat_Admin &&  GlobalUserData.shared.privileges_Items.first?.getAdmin() == true {
            txt_Flat_Admin.resignFirstResponder()
            let flatMembersReference = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_FLATMEMBERS)
            flatMembersReference.observeSingleEvent(of: .value) { (flatMembersUIDSnapshot) in
                if flatMembersUIDSnapshot.childrenCount == 1 {
                    NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().change_Admin_Alert_Title(), Message: NAString().change_Admin_Alert_Message(), OkStyle: .default, OK: { (action) in })
                } else {
                    let flatMembersUIDMap = flatMembersUIDSnapshot.value as? NSDictionary
                    
                    for flatMemberUID in (flatMembersUIDMap?.allKeys)! {
                        if flatMemberUID as! String != userUID {
                            
                            //Getting all Flat Members names.
                            self.familyMemberNameRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(flatMemberUID as! String).child(Constants.FIREBASE_CHILD_PERSONALDETAILS).child(Constants.FIREBASE_CHILD_FULLNAME)
                            print(flatMemberUID)
                            self.allFlatMembersUID.append(flatMemberUID as! String)
                            
                            self.familyMemberNameRef?.observeSingleEvent(of: .value, with: { (nameSnapshot) in
                                self.flatMembersNameList.append(nameSnapshot.value as! String)
                                self.list_View.isHidden = false
                                self.opacity_View.isHidden = false
                                self.table_View.reloadData()
                            })
                        }
                    }
                }
            }
        }
    }
    
    //Create name textfield first letter capital function
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    //tap Gesture method
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        list_View.isHidden = true
        opacity_View.isHidden = true
        self.view.endEditing(true)
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
            profile_Image.image = image
            isImageChanged = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func update_Action_Btn(_ sender: UIButton) {
        
        //Updating if and only if atleast one item is Changed.
        if existedName != txt_Name.text || existedEmail != txt_EmailId.text || isImageChanged == true {
            updateProfileChanges()
        } else if existedFlatAdmin != txt_Flat_Admin.text && GlobalUserData.shared.privileges_Items.first?.getAdmin() == true {
            
            //Showing Confirmation Alert PopUp for changing Admin Access
            NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().change_Admin_Message_Alert_Title(), Message: NAString().change_Admin_Message_Alert_Message(name: txt_Flat_Admin.text!), CancelStyle: .default, OkStyle: .default, OK: { (action) in
                
                //After Changing Admin Access Previous Admin user Admin Access changed to false.
                let removedAdminRef =  Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(self.adminUID!).child(Constants.FIREBASE_CHILD_PRIVILEGES)
                removedAdminRef.child(Constants.FIREBASE_CHILD_ADMIN).setValue(NAString().getfalse())
                
                //After Changing Admin Access new Admin UID will get Replaced with previous UID
                let UpdatedUserDataAdminRef = GlobalUserData.shared.getUserDataReference()
                UpdatedUserDataAdminRef.child(Constants.FIREBASE_CHILD_ADMIN).setValue(self.updatedAdminUID)
                
                //After Changing Admin Access new Admin user Admin Access will be Chnaged to true
                let updatedUserAdminRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(self.updatedAdminUID!).child(Constants.FIREBASE_CHILD_PRIVILEGES)
                updatedUserAdminRef.child(Constants.FIREBASE_CHILD_ADMIN).setValue(NAString().gettrue())
                
                //After Changing Admin Access new Admin user Grant Access will be Changes to true
                let updatedUserGrantAccessRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(self.updatedAdminUID!).child(Constants.FIREBASE_CHILD_PRIVILEGES)
                updatedUserGrantAccessRef.child(Constants.FIREBASE_CHILD_GRANTACCESS).setValue(NAString().gettrue())
                
                //Showing Successfully Updated PopUp after Data Replaced in firebase.
                NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().update_Alert_Title(), Message: NAString().update_Successfull_Alert_Message(), OkStyle: .default) { (action) in
                    
                    //Making present user to logout from this App after Clicking ok in Alert PopUp.
                    self.logoutAction()
                }
            }, Cancel: { (action) in}, cancelActionTitle: NAString().no(), okActionTitle: NAString().yes())
        } else {
            
            //If no Changes are made then Showing "No Changes Made" Alert PopUp.
            NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().update_Alert_Title(), Message: NAString().update_Failure_Alert_Message(), OkStyle: .default) { (action) in}
        }
    }
    
    //Email Validation Function
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flatMembersNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! EditMyProfileTableViewCell
        
        cell.lbl_Family_Members_List.text = flatMembersNameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as! EditMyProfileTableViewCell
        let currentItem = currentCell.lbl_Family_Members_List.text
        updatedAdminUID = allFlatMembersUID[(indexPath?.row)!]
        
        txt_Flat_Admin.text = currentItem
        
        list_View.isHidden = true
        tableView.deselectRow(at: indexPath!, animated: true)
        opacity_View.isHidden = true
    }
    
    //To Logout the current user
    func logoutAction() {
        let preferences = UserDefaults.standard
        let currentLevelKey = "USERUID"
        preferences.removeObject(forKey: currentLevelKey)
        if self.storyboard != nil {
            let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
            let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().loginNavigation())
            self.present(NavLogin, animated: true)
        }
    }
}

extension EditMyProfileViewController {
    func updateProfileChanges() {
        self.updateUserRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID).child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
        if existedName != txt_Name.text {
            updateUserRef?.child(Constants.FIREBASE_CHILD_FULLNAME).setValue(txt_Name.text)
        }
        if existedEmail != txt_EmailId.text {
            updateUserRef?.child(Constants.FIREBASE_CHILD_EMAIL).setValue(txt_EmailId.text)
        }
        
        if isImageChanged == true {
            let updatedImageRef = Storage.storage().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID)
            
            //Compressing profile image and assigning its content type.
            guard let image = profile_Image.image else { return }
            guard let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
            
            let metaDataContentType = StorageMetadata()
            metaDataContentType.contentType = NAString().imageContentType()
            
            //Uploading Visitor image url along with Visitor UID
            let uploadImageRef = updatedImageRef.child(Constants.FIREBASE_CHILD_PERSONALDETAILS)
            let uploadTask = uploadImageRef.putData(imageData, metadata: metaDataContentType, completion: { (metadata, error) in
                
                uploadImageRef.downloadURL(completion: { (url, urlError) in
                    
                    if urlError == nil {
                        self.updateUserRef?.child(Constants.FIREBASE_CHILD_PERSONALDETAILS_PROFILEIMAGE).setValue(url?.absoluteString)
                        
                        //Using else statement & printing error,so the other developers can know what is going on.
                    } else {
                        print(urlError as Any)
                    }
                })
            })
            uploadTask.resume()
        }
        
        NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().update_Alert_Title(), Message: NAString().update_Successfull_Alert_Message(), OkStyle: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
    }
}


