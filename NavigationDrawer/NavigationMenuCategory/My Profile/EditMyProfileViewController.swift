//
//  EditMyProfileViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 01/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditMyProfileViewController: NANavigationViewController, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
    @IBOutlet weak var search_TextField: UITextField!
    
    @IBOutlet weak var scroll_View: UIScrollView!
    
    var userName = String()
    var userEmail = String()
    
    var navTitle = String()
    
    /* - Creating Text Field Action for Name for first letter to be Capital.
     - Assigning Delegates for text fields and Tableview & Removing Separator lines for tableview cells.
     - Creating Round Image using Corner Radius and Giving Scroll view EdgeInset Values.
     - Implemented Tap Gesture to Upload Image & resign PopUp Screen. */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDataRef = Database.database().reference().child(Constants.FIREBASE_USER)
            .child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID)
        
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            let usersData = userDataSnapshot.value as? [String: AnyObject]
            
            //Creating instance of UserPersonalDetails
            let userPersonalDataMap = usersData?["personalDetails"] as? [String: AnyObject]
        
            self.txt_Name.text = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
            self.txt_EmailId.text = userPersonalDataMap?[UserPersonalListFBKeys.email.key] as? String
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
    
        //TODO: Need to get Flat members Details.
        txt_Flat_Admin.text = "You are the Administrator"
        
        self.profile_Image.layer.cornerRadius = self.profile_Image.frame.size.width/2
        profile_Image.clipsToBounds = true
        
        scroll_View.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        
        profile_Image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.profile_Image.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        opacity_View.addGestureRecognizer(tap)
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
            pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        })
        let actionGallery = UIAlertAction(title:NAString().gallery(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
            lbl_Picture_Validation.isHidden = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func update_Action_Btn(_ sender: UIButton) { }
    
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
    //TODO: Need to get Flat members Count After Firebase Retrieval.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //TODO: Need to Load Table View data of Flat Members from Firebase.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! EditMyProfileTableViewCell
        return cell
    }
}

