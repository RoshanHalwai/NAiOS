//
//  MyVisitorListViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyVisitorListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
    
{
    @IBOutlet weak var lbl_Header: UILabel!
    
    //array for displaying card view data
    var cardImageList = [#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen")]
    var MyVisitorName = ["Vikas Nayak","Chaitanya","Vinod Kumar","Avinash"]
    var MyVisitorDate = ["May 1 2018","May 2 2018","May 3 2018","Apr 30 2017"]
    var MyVisitorType = ["Guest","Guest","Guest","Guest"]
    var MyVisitorTime = ["12:14","14:09","09:12","05:50"]
    var InvitorName = ["Vinod Kumar","Rohit Mishra","Yuvaraj","Akash Patel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign font & style to header
        self.lbl_Header.font = NAFont().headerFont()
        
        
        //hide navigation bar
    self.navigationController?.isNavigationBarHidden = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyVistorListCollectionViewCell
        
        cell.lbl_InvitedName.text = InvitorName[indexPath.row]
        cell.lbl_MyVisitorDate.text = MyVisitorDate[indexPath.row]
        cell.lbl_MyVisitorTime.text = MyVisitorTime[indexPath.row]
        cell.lbl_MyVisitorName.text = MyVisitorName[indexPath.row]
        cell.lbl_MyVisitorType.text = MyVisitorType[indexPath.row]
        cell.myVisitorImage
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
        
        //assigning font & style to cell labels
        cell.lbl_InvitedName.font = NAFont().headerFont()
        cell.lbl_MyVisitorType.font = NAFont().headerFont()
        cell.lbl_MyVisitorName.font = NAFont().headerFont()
        cell.lbl_MyVisitorDate.font = NAFont().headerFont()
        cell.lbl_MyVisitorTime.font = NAFont().headerFont()
        
        //setting image round
        cell.myVisitorImage.layer.cornerRadius = cell.myVisitorImage.frame.size.width/2
        cell.myVisitorImage.clipsToBounds = true
    
        return cell
    }
    
    @IBAction func btnBackToDigiGate(_ sender: UIBarButtonItem)
    {
         _ = navigationController?.popViewController(animated: true)
    }
}
