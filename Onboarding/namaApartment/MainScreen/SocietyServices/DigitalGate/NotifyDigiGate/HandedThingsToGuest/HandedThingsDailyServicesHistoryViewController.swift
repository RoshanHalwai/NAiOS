//
//  HandedThingsDailyServicesHistoryViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 13/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsDailyServicesHistoryViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    //set title from previous page
    var titleName =  String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
        //created custom back button
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToHandedThingsDailyServiceVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    //to navigate back to handed things to My daily services VC
    @objc func goBackToHandedThingsDailyServiceVC() {
        let dv = NAViewPresenter().handedThingsToMyDailyServiceVC()
        dv.titleName = NAString().my_Daily_Services().capitalized
        self.navigationController?.pushViewController(dv, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HandedThingsDailyServicesHistoryCollectionViewCell
        
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
        cell.lbl_Name_Type.font = NAFont().textFieldFont()
        cell.lbl_Date_Type.font = NAFont().textFieldFont()
        cell.lbl_InTime_Type.font = NAFont().textFieldFont()
        cell.lbl_Type.font = NAFont().textFieldFont()
        cell.lbl_Things_Type.font = NAFont().textFieldFont()
        
        cell.lbl_Name_Detail.font = NAFont().headerFont()
        cell.lbl_Date_Detail.font = NAFont().headerFont()
        cell.lbl_InTime_Detail.font = NAFont().headerFont()
        cell.lbl_Type_Detail.font = NAFont().headerFont()
        cell.lbl_Things_Detail.font = NAFont().headerFont()
        
        //setting image round
        cell.image_View.layer.cornerRadius = cell.image_View.frame.size.width/2
        cell.image_View.clipsToBounds = true
        return cell
    }
}
