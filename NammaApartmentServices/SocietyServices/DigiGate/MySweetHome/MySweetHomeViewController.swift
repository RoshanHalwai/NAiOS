//
//  MySweetHomeViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 18/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class MySweetHomeViewController: NANavigationViewController , UICollectionViewDelegate , UICollectionViewDataSource, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var opacity_View: UIView!
    @IBOutlet weak var PopUp_ParentView: UIView!
    @IBOutlet weak var popUp_View: UIView!
    @IBOutlet weak var access_Segment: UISegmentedControl!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var lbl_Grant_Access: UILabel!
    @IBOutlet weak var btn_AddmyFamilyMember: UIButton!
    @IBOutlet weak var btn_ChangeAccess: UIButton!
    
    
    var userPrivilegesRef : DatabaseReference?
    
    var mysweethomeImages = [#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen")]
    var MySweetHomeName =  ["Preeti","Vikas"]
    var MySweetHomeRelation = ["Sister","Brother"]
    var MySweetHomeGrantAccess = ["Yes","No"]
    
    //A boolean variable to indicate if previous screen was Home Screen and My Sweet Home Screen.
    var fromHomeScreenVC = false
    var fromMySweetHomeScreenVC = false
    
    var navTitle = String()
    
    var NAFamilyMemberList = [NAUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        let retrieveUserList : RetrieveFamilyMemberList
        retrieveUserList = RetrieveFamilyMemberList.init()
        
        //Retrieve user friends and family members if they have added else we show FEATURE UNAVAILABLE
        retrieveUserList.getFriendsAndFamilyMembers(userUID: userUID) { (familyMembersDataList) in
            //Hide Progress indicator
            NAActivityIndicator.shared.hideActivityIndicator()
            
            if familyMembersDataList.count == 0 {
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorFamilyMembersList())
            } else {
                self.NAFamilyMemberList.append(contentsOf: familyMembersDataList)
            }
            self.collectionView.reloadData()
        }
        
        /* - Corner Radius for popUp View.
         - Formmating & setting in Buttons and Navigation bar.
         - Create My Sweet Home Back Button.
         - For navigating back to My Digi Gate VC. */
        
        popUp_View.layer.cornerRadius = 5
        
        PopUp_ParentView.isHidden = true
        opacity_View.isHidden = true
        popUp_View.isHidden = true
        
        lbl_Grant_Access.font = NAFont().headerFont()
        btn_Cancel.titleLabel?.font = NAFont().popUpButtonFont()
        btn_ChangeAccess.titleLabel?.font = NAFont().popUpButtonFont()
        
        self.btn_AddmyFamilyMember.setTitle(NAString().btn_mySweet_home().capitalized, for: .normal)
        self.btn_AddmyFamilyMember.backgroundColor = NAColor().buttonBgColor()
        self.btn_AddmyFamilyMember.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_AddmyFamilyMember.titleLabel?.font = NAFont().buttonFont()
        
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.title = ""
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToHomeScreenVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to Home Screen according to Screen coming from
    @objc func goBackToHomeScreenVC() {
        if fromHomeScreenVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-NAString().count_two()]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else if fromMySweetHomeScreenVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-NAString().count_four()]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnAddFamilyMember(_ sender: UIButton) {
        let lv = NAViewPresenter().myFamilyMembers()
        lv.navTitle = NAString().addFamilyMemberTitle()
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.NAFamilyMemberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! mySweetHomeCollectionViewCell
        
        let flatMember = self.NAFamilyMemberList[indexPath.row]
        
        cell.lbl_MySweetHomeName.text = flatMember.personalDetails.fullName
        
        //TODO Remove this data, we need to decide if a user is a friend or family member
        cell.lbl_MySweetHomeRelation.text = "Family Member"
        cell.lbl_MySweetHomeGrantAccess.text = flatMember.privileges.getGrantAccess() ? "Yes" : "No"
        
        if let urlString = flatMember.personalDetails.profilePhoto {
            NAFirebase().downloadImageFromServerURL(urlString: urlString, imageView: cell.MySweeetHomeimg)
        }
        
        /* - This creates the shadows and modifies the cards a little bit.
         - Creating round Image using Corner radius.
         - Setting fonts & strings for labels.
         - Calling edit button action & Delete particular cell from list. */
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.MySweeetHomeimg.layer.cornerRadius = cell.MySweeetHomeimg.frame.size.width/2
        cell.MySweeetHomeimg.clipsToBounds = true
        
        cell.lbl_MySweetHomeName.font = NAFont().headerFont()
        cell.lbl_MySweetHomeRelation.font = NAFont().headerFont()
        cell.lbl_MySweetHomeGrantAccess.font = NAFont().headerFont()
        cell.lbl_Name.font = NAFont().headerFont()
        cell.lbl_Relation.font = NAFont().headerFont()
        cell.lbl_GrantAccess.font = NAFont().headerFont()
        cell.lbl_Call.font = NAFont().headerFont()
        cell.lbl_Message.font = NAFont().headerFont()
        cell.lbl_Edit.font = NAFont().headerFont()
        cell.lbl_Remove.font = NAFont().headerFont()
        
        cell.lbl_Name.font = NAFont().textFieldFont()
        cell.lbl_Relation.font = NAFont().textFieldFont()
        cell.lbl_GrantAccess.font = NAFont().textFieldFont()
        
        cell.lbl_Name.text = NAString().name()
        cell.lbl_Relation.text = NAString().relation()
        cell.lbl_GrantAccess.text = NAString().access()
        cell.lbl_Call.text = NAString().call()
        cell.lbl_Message.text = NAString().message()
        cell.lbl_Edit.text = NAString().edit()
        cell.lbl_Remove.text = NAString().remove()
        
        cell.btn_Remove.addTarget(self,action:#selector(deleteData), for:.touchUpInside)
        
        cell.objEdit = {
            
            self.userPrivilegesRef =  Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(flatMember.flatMembersUID()).child(Constants.FIREBASE_CHILD_PRIVILEGES).child(Constants.FIREBASE_CHILD_GRANTACCESS)
            
            //Showing Segment Index Based on the Firebase data
            if flatMember.privileges.getGrantAccess() == true {
                self.access_Segment.selectedSegmentIndex = 0
            } else {
                self.access_Segment.selectedSegmentIndex = 1
            }
            self.btn_ChangeAccess.addTarget(self, action: #selector(self.Change_Button), for: .touchUpInside)
            self.opacity_View.isHidden = false
            self.PopUp_ParentView.isHidden = false
            self.popUp_View.isHidden = false
        }
        
        cell.objCall = {
            UIApplication.shared.open(NSURL(string: "tel://\(flatMember.personalDetails.getphoneNumber())")! as URL, options: [:], completionHandler: nil)
        }
        
        cell.objMessage = {
            MFMessageComposeViewController.canSendText()
            let messageSheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            messageSheet.recipients = [flatMember.personalDetails.getphoneNumber()]
            messageSheet.body = ""
            self.present(messageSheet, animated: true, completion: nil)
        }
        return cell
    }
    
    //Message UI default function to dismiss UI after calling MessageUI.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Cancel_Action(_ sender: UIButton) {
        opacity_View.isHidden = true
        PopUp_ParentView.isHidden = true
        popUp_View.isHidden = true
    }
    
    @objc func Change_Button() {
        var newGrantAccessValue: Bool?
        
        //Changing Grant Access of particular flat member.
        if self.access_Segment.selectedSegmentIndex == 0 {
            newGrantAccessValue = NAString().gettrue()
        } else {
            newGrantAccessValue = NAString().getfalse()
        }
        self.userPrivilegesRef?.setValue(newGrantAccessValue)
        
        opacity_View.isHidden = true
        PopUp_ParentView.isHidden = true
        popUp_View.isHidden = true
    }
}

extension MySweetHomeViewController {
    
    @objc func deleteData() {
        
        let alert = UIAlertController(title: NAString().warning(), message: NAString().delete_FamilyMembers_AlertMessage(), preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title:NAString().ok(), style: .cancel) { (action) in }
        
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func reloadCollectionData() {
        collectionView.reloadData()
    }
}
