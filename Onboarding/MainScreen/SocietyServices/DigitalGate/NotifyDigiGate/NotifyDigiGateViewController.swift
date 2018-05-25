//
//  NotifyDigiGateViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class NotifyDigiGateViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    var ImageList = [#imageLiteral(resourceName: "ExpectingCabs256"),#imageLiteral(resourceName: "ExpectingPackage256"),#imageLiteral(resourceName: "ExpectiingVisitor256"),#imageLiteral(resourceName: "HandedThings256"),#imageLiteral(resourceName: "HandedDailyServices256")]
    var ExpectingList = ["Expecting Cab Arrival","Expecting Package Arrival","Expecting Visitor","Handed Things To My Guest","Handed Things To My Daily Services"]
    
    //array for navigation
   // var VCNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().notifyDigiGateHeader())
        self.navigationItem.title = ""
        navigationItem.rightBarButtonItem = nil
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return ImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NotifyDigiGateCollectionViewCell
        
        cell.cellImage.image = ImageList[indexPath.row]
        cell.cellLabel.text = ExpectingList[indexPath.row]
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        //assign font & size to the labels in cell
        cell.cellLabel.font = NAFont().headerFont()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
//        let name = VCNames[indexPath.row]
//        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
//        self.navigationController?.pushViewController(viewController!, animated: true)
        
        if indexPath.row == 0
        {
            let lv = NAViewPresenter().expectingCabArrivalVC()
            self.navigationController?.pushViewController(lv, animated: true)
        }
        
        if indexPath.row == 1
        {
            let lv1 = NAViewPresenter().expectingPackageArrivalVC()
            
            self.navigationController?.pushViewController(lv1, animated: true)
        }
        
        if indexPath.row == 2
        {
            let lv2 = NAViewPresenter().inviteVisitorVC()
            
            self.navigationController?.pushViewController(lv2, animated: true)
        }
        
        if indexPath.row == 3
        {
            let lv3 = NAViewPresenter().handedThingsToMyGuestVC()
            self.navigationController?.pushViewController(lv3, animated: true)
            lv3.titleName = NAString().handed_things_to_my_guest().capitalized
        }
        
        if indexPath.row == 4
        {
            let lv4 = NAViewPresenter().handedThingsToMyGuestVC()
            self.navigationController?.pushViewController(lv4, animated: true)
            lv4.titleName = NAString().handed_things_to_my_daily_services().capitalized
        }
}
}
