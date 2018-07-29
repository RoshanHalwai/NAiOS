//
//  HandedThingsHistoryViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 09/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HandedThingsGuestHistoryViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var HandedThingsList = [NammaApartmentVisitor_History]()
    var HandedHistory : DatabaseReference?
    var Vistitor_UID = [String]()
    var Vistitor_Main_UIDs = [String]()
    var HandedDataRef : DatabaseReference?
    var UserDataRef : DatabaseReference?
    var Visitor_Ref : DatabaseReference?
    //set title from previous page
    var titleName =  String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
        // TODO: need to change UID in Future
        UserDataRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
            .child(Constants.FIREBASE_CHILD_BANGALORE)
            .child(Constants.FIREBASE_CHILD_BRIGADE_GATEWAY)
            .child(Constants.FIREBASE_CHILD_ASTER)
            .child(Constants.FIREBASE_CHILD_FLATNO)
            .child(Constants.FLAT_Visitor).child(userUID)
        UserDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists(){
                for Datavaluees in ((snapshot.value as AnyObject).allKeys)!{
                    let SnapShotValues = snapshot.value as? NSDictionary
                    for UserID  in (SnapShotValues?.allKeys)! {
                        let userIDS = UserID as! String
                        // TODO: need to change UID in Future
                        self.Visitor_Ref =  Database.database().reference()
                            .child(Constants.FIREBASE_CHILD_VISITORS)
                            .child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS)
                            .child(userIDS)
                        self.Visitor_Ref?.observeSingleEvent(of: .value, with: {(snapshot) in
                            if snapshot.exists() {
                                self.HandedThingsList.removeAll()
                                let visitorData = snapshot.value as? [String: AnyObject]
                                let dateAndTimeOfVisit = visitorData?[VisitorListFBKeys_History.dateAndTimeOfVisit.key] as? String
                                let fullName = visitorData?[VisitorListFBKeys_History.fullName.key] as? String
                                let inviterUID = visitorData?[VisitorListFBKeys_History.inviterUID.key] as? String
                                let mobileNumber = visitorData?[VisitorListFBKeys_History.mobileNumber.key] as? String
                                let profilePhoto = visitorData?[VisitorListFBKeys_History.profilePhoto.key] as? String
                                let status = visitorData?[VisitorListFBKeys_History.status.key] as? String
                                let uid = visitorData?[VisitorListFBKeys_History.uid.key] as? String
                                let Things = visitorData?[VisitorListFBKeys_History.handedThings.key] as? String
                                //    creating userAccount model & set earlier created let variables in userObject in the below parameter
                                let user = NammaApartmentVisitor_History(dateAndTimeOfVisit: dateAndTimeOfVisit , fullName: fullName , inviterUID: inviterUID , mobileNumber: mobileNumber , profilePhoto: profilePhoto , status:
                                    status, uid: uid, Things: Things!)
                                self.CollectionReload()
                                self.HandedThingsList.append(user)
                                self.CollectionReload()
                            }
                        })
                    }
                }
            } else {
                //Hiding Activity Indicator & showing error image & message.
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorHandedThingsList())
            }
        })
    }
    
    //CollectionView Reload with Background Thread
    func CollectionReload()
    {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HandedThingsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HandedThingsGuestHistoryCollectionViewCell
        let rowofIndex = indexPath.row
        let SavedValues = HandedThingsList[rowofIndex]
        let VisitedByName =  GlobalUserData.shared.personalDetails_Items
        let UserDetails_Data = VisitedByName.first
        let VisitedBy = UserDetails_Data?.fullName
        cell.lbl_Visitor_Detail.text = SavedValues.getfullName()
        let dateTimeString = SavedValues.getdateAndTimeOfVisit()
        //Created array to spilt Date & time in separate variables
        let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t")
        let dateString: String = arrayOfDateTime[0]
        let timeString: String = arrayOfDateTime[1]
        cell.lbl_InTime_Detail.text = timeString
        cell.lbl_Date_Detail.text = dateString
        cell.lbl_Inviter_Detail.text = VisitedBy
        cell.lbl_Things_Detail.text = SavedValues.getThings()
        //This creates the shadows and modifies the cards a little bit
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
        
        //assigning font & style to cell labels
        cell.lbl_Visitor_Type.font = NAFont().textFieldFont()
        cell.lbl_Date_Type.font = NAFont().textFieldFont()
        cell.lbl_InTime_Type.font = NAFont().textFieldFont()
        cell.lbl_Inviter_Type.font = NAFont().textFieldFont()
        cell.lbl_Things_Type.font = NAFont().textFieldFont()
        cell.lbl_Visitor_Detail.font = NAFont().headerFont()
        cell.lbl_Date_Detail.font = NAFont().headerFont()
        cell.lbl_InTime_Detail.font = NAFont().headerFont()
        cell.lbl_Inviter_Detail.font = NAFont().headerFont()
        cell.lbl_Things_Detail.font = NAFont().headerFont()
        
        //setting image round
        cell.image_View.layer.cornerRadius = cell.image_View.frame.size.width/2
        cell.image_View.clipsToBounds = true
        return cell
    }
}
