//
//  HandedThingsToGuestViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 10/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsToGuestViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //Handed Things to my guest array for displaying card view data
    var cardImageList = [#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen")]
    var MyVisitorName = ["Vikas Nayak","Chaitanya","Vinod Kumar","Avinash"]
    var MyVisitorDate = ["May 1 2018","May 2 2018","May 3 2018","Apr 30 2017"]
    var MyVisitorType = ["Guest","Guest","Guest","Guest"]
    var MyVisitorTime = ["12:14","14:09","09:12","05:50"]
    var InvitorName = ["Vinod Kumar","Rohit Mishra","Yuvaraj","Akash Patel"]
    
     //set title from previous page
    var titleName =  String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return cardImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HandedThingsToGuestCollectionViewCell
        
            cell.lbl_VisiterName.text = InvitorName[indexPath.row]
            cell.lbl_GuestDate.text = MyVisitorDate[indexPath.row]
            cell.lbl_GuestTime.text = MyVisitorTime[indexPath.row]
            cell.lbl_GuestInvitedBy.text = MyVisitorName[indexPath.row]
            cell.lbl_GuestType.text = MyVisitorType[indexPath.row]
            cell.cellImage
                .image = cardImageList[indexPath.row]
       
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
        
        //Lables Formatting & setting
        cell.lbl_Visiter.font = NAFont().headerFont()
        cell.lbl_Type.font = NAFont().headerFont()
        cell.lbl_Date.font = NAFont().headerFont()
        cell.lbl_Time.font = NAFont().headerFont()
        cell.lbl_Invited.font = NAFont().headerFont()
        
        cell.lbl_VisiterName.font = NAFont().headerFont()
        cell.lbl_GuestType.font = NAFont().headerFont()
        cell.lbl_GuestDate.font = NAFont().headerFont()
        cell.lbl_GuestTime.font = NAFont().headerFont()
        cell.lbl_GuestInvitedBy.font = NAFont().headerFont()
        
        cell.lbl_ThingsGiven.font = NAFont().headerFont()
        cell.lbl_Description.font = NAFont().headerFont()
        
        //TextField Formatting & setting
        cell.txt_Description.font = NAFont().textFieldFont()
        
        //Creating black bottom line
        cell.txt_Description.underlined()
        
        //hidding description part on cell load
        cell.lbl_Description.isHidden = true
        cell.txt_Description.isHidden = true
        
        //image makes round
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.size.width/2
        cell.cellImage.clipsToBounds = true
        
        return cell
    }
}
