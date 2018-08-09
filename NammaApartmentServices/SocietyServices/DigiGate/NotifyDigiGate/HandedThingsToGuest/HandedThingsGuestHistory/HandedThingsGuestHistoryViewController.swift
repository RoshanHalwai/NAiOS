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
    var handedThingsList = [NammaApartmentVisitor]()
    
    //set title from previous page
    var titleName =  String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        let retrieveGuestList : RetrievingGuestList
        retrieveGuestList = RetrievingGuestList.init(pastGuestListRequired: false)
        
        //Retrieve guest of current userUID and their family members if any
        retrieveGuestList.getPreAndPostApprovedGuests { (guestDataList) in
            
            //Hiding Progress indicator after retrieving data.
            NAActivityIndicator.shared.hideActivityIndicator()
            
            if(guestDataList.count == 0) {
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
            } else {
                for guestData in guestDataList {
                    
                    //Append only those guest data who have been given things in the past.
                    if  !guestData.getHandedThings().isEmpty {
                        self.handedThingsList.append(guestData)
                    }
                }
                if(self.handedThingsList.count == 0) {
                    NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    //CollectionView Reload with Background Thread
    func CollectionReload()
    {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handedThingsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HandedThingsGuestHistoryCollectionViewCell
        //Created constant variable to store all the firebase data in it.
        let nammaApartmentVisitor : NammaApartmentVisitor
        nammaApartmentVisitor = handedThingsList[indexPath.row]
        //Created local variable to store Date & Time From Firebase
        var dateTimeString : String
        dateTimeString = nammaApartmentVisitor.getdateAndTimeOfVisit()
        //Create array to split Date & Time from firebase
        let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t")
        let dateString: String = arrayOfDateTime[0]
        let timeString: String = arrayOfDateTime[1]
        
        cell.lbl_InTime_Detail.text = timeString
        cell.lbl_Date_Detail.text = dateString
        cell.lbl_Visitor_Detail.text = nammaApartmentVisitor.getfullName()
        cell.lbl_Things_Detail.text = nammaApartmentVisitor.getHandedThings()
        
        //Calling function to get Profile Image from Firebase.
        if let urlString = nammaApartmentVisitor.getprofilePhoto() {
            NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.image_View)
        }
        
        if(nammaApartmentVisitor.getinviterUID() == userUID) {
            cell.lbl_Inviter_Detail.text = GlobalUserData.shared.personalDetails_Items.first?.fullName
        }
        
        //Creating shadow Effect for Collection View Cell.
        NAShadowEffect().shadowEffect(Cell: cell)
        
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
