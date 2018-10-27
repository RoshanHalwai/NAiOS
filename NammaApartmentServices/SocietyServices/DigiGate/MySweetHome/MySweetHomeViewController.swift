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
import SDWebImage

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
    
    //A boolean variable to indicate if previous screen was Home Screen and My Sweet Home Screen.
    var fromHomeScreenVC = false
    var fromMySweetHomeScreenVC = false
    
    var NAFamilyMemberList = [NAUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        retrieveFlatMembersData()
        
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
        
        super.ConfigureNavBarTitle(title: NAString().my_sweet_home())
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToHomeScreenVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        //info Button Action
        infoButton()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 200)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    func retrieveFlatMembersData() {
        
        let retrieveUserList : RetrieveFamilyMemberList
        retrieveUserList = RetrieveFamilyMemberList.init()
        
        //Retrieve user friends and family members if they have added else we show FEATURE UNAVAILABLE
        retrieveUserList.getFriendsAndFamilyMembers(userUID: userUID) { (familyMembersDataList) in
            //Hide Progress indicator
            NAActivityIndicator.shared.hideActivityIndicator()
            
            if familyMembersDataList.count == 0 {
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorFamilyMembersList())
            } else {
                self.NAFamilyMemberList.removeAll()
                self.NAFamilyMemberList.append(contentsOf: familyMembersDataList)
            }
            self.collectionView.reloadData()
        }
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
        
        if GlobalUserData.shared.privileges_Items.first?.getAdmin() == true {
            let lv = NAViewPresenter().myFamilyMembers()
            lv.navTitle = NAString().btn_mySweet_home()
            self.navigationController?.pushViewController(lv, animated: true)
        } else {
            NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().add_Family_Members_Alert_Title(), Message: NAString().add_Family_Members_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default) { (action) in }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.NAFamilyMemberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! mySweetHomeCollectionViewCell
        
        let flatMember = self.NAFamilyMemberList[indexPath.row]
        
        cell.lbl_MySweetHomeName.text = flatMember.personalDetails.fullName
        
        cell.lbl_MySweetHomeGrantAccess.text = flatMember.privileges.getGrantAccess() ? "Yes" : "No"
        
        //Retrieving Image & Showing Activity Indicator on top of image with the help of 'SDWebImage Pod'
        cell.MySweeetHomeimg.sd_setShowActivityIndicatorView(true)
        cell.MySweeetHomeimg.sd_setIndicatorStyle(.gray)
        cell.MySweeetHomeimg.sd_setImage(with: URL(string: flatMember.personalDetails.profilePhoto!), completed: nil)
        
        /* - This creates the shadows and modifies the cards a little bit.
         - Creating round Image using Corner radius.
         - Setting fonts & strings for labels.
         - Calling edit button action & Delete particular cell from list. */
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        cell.MySweeetHomeimg.layer.cornerRadius = cell.MySweeetHomeimg.frame.size.width/2
        cell.MySweeetHomeimg.clipsToBounds = true
        
        cell.lbl_MySweetHomeName.font = NAFont().headerFont()
        cell.lbl_MySweetHomeGrantAccess.font = NAFont().headerFont()
        cell.lbl_Name.font = NAFont().headerFont()
        cell.lbl_GrantAccess.font = NAFont().headerFont()
        cell.lbl_Call.font = NAFont().cellButtonFont()
        cell.lbl_Message.font = NAFont().cellButtonFont()
        cell.lbl_Edit.font = NAFont().cellButtonFont()
        cell.lbl_Remove.font = NAFont().cellButtonFont()
        
        cell.lbl_Name.font = NAFont().textFieldFont()
        cell.lbl_GrantAccess.font = NAFont().textFieldFont()
        
        //assigning title to cell Labels
        cell.lbl_Name.text = NAString().name()
        cell.lbl_GrantAccess.text = NAString().access()
        cell.lbl_Call.text = NAString().call()
        cell.lbl_Message.text = NAString().message()
        cell.lbl_Edit.text = NAString().edit()
        cell.lbl_Remove.text = NAString().remove()
        
        cell.btn_Remove.addTarget(self,action:#selector(deleteData), for:.touchUpInside)
        
        cell.objEdit = {
            
            self.userPrivilegesRef =  Constants.FIREBASE_USERS_PRIVATE.child(flatMember.flatMembersUID()).child(Constants.FIREBASE_CHILD_PRIVILEGES).child(Constants.FIREBASE_CHILD_GRANTACCESS)
            
            if GlobalUserData.shared.privileges_Items.first?.getAdmin() == true {
                
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
            } else {
                NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().edit_Message_Alert_Title(), Message: NAString().edit_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default, OK: { (action) in})
            }
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
        
        userPrivilegesRef?.observe(.value) { (snapshot) in
            self.retrieveFlatMembersData()
        }
        
        opacity_View.isHidden = true
        PopUp_ParentView.isHidden = true
        popUp_View.isHidden = true
    }
}

extension MySweetHomeViewController {
    
    @objc func deleteData() {
        
        let alert = UIAlertController(title: NAString().delete_FamilyMembers_AlertTitle(), message: NAString().delete_FamilyMembers_AlertMessage(), preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title:NAString().ok(), style: .cancel) { (action) in }
        
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func reloadCollectionData() {
        collectionView.reloadData()
    }
}
