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
    var HandedThingsList = [NammaApartmentVisitor1]()
    var HandedHistory : DatabaseReference?
    //set title from previous page
    var titleName =  String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
        HandedHistory = Database.database().reference()
            .child(Constants.FIREBASE_CHILD_VISITORS)
            .child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS).child("-LHY6LjWGck8nf1D8Bvy")
        HandedHistory?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                self.HandedThingsList.removeAll()
                let visitorData = snapshot.value as? [String: AnyObject]
                let dateAndTimeOfVisit = visitorData?[VisitorListFBKeys1.dateAndTimeOfVisit.key] as? String
                let fullName = visitorData?[VisitorListFBKeys1.fullName.key] as? String
                let inviterUID = visitorData?[VisitorListFBKeys1.inviterUID.key] as? String
                let mobileNumber = visitorData?[VisitorListFBKeys1.mobileNumber.key] as? String
                let profilePhoto = visitorData?[VisitorListFBKeys1.profilePhoto.key] as? String
                let status = visitorData?[VisitorListFBKeys1.status.key] as? String
                let uid = visitorData?[VisitorListFBKeys1.uid.key] as? String
                let Things = visitorData?[VisitorListFBKeys1.handedThings.key] as? String
                //    creating userAccount model & set earlier created let variables in userObject in the below parameter
                let user = NammaApartmentVisitor1(dateAndTimeOfVisit: dateAndTimeOfVisit , fullName: fullName , inviterUID: inviterUID , mobileNumber: mobileNumber , profilePhoto: profilePhoto , status:
                    status, uid: uid, Things: Things!)
                self.relaod()
                self.HandedThingsList.append(user)
                
            }
        })
        //created custom back button
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToHandedThingsGuestVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
 
    func relaod()
    {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    //to navigate back to handed things My guest VC
    @objc func goBackToHandedThingsGuestVC() {
        let dv = NAViewPresenter().handedThingsToMyGuestVC()
        dv.titleName = NAString().myVisitorViewTitle().capitalized
        self.navigationController?.pushViewController(dv, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HandedThingsList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HandedThingsGuestHistoryCollectionViewCell
        let rowofIndex = indexPath.row
        let SavedValues = HandedThingsList[rowofIndex]
        let VisitedByName =  Singleton_PersonalDetails.shared.personalDetails_Items
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
