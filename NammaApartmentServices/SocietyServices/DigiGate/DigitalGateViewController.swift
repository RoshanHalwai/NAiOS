//
//  DigitalGateViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

//To Identify cell
private let reuseIdentifier = NAString().cellID()
class DigitalGateViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var DGimageList=["InviteVisitors","MyVisitorsList","MyDailyServices","NotifyDigitalGate","MySweetHome","Medical"]
    var DGNameList=["Invite Visitors","My Visitors List","My Daily Services","Notify Digi Gate","My Sweet Home","Emergency"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().digital_gate_title())
        self.navigationItem.title = ""
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DGimageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! DigitalGateCollectionViewCell
        
        cell.cellTitle.text = DGNameList[indexPath.row]
        cell.cellImage.image = UIImage(named: DGimageList[indexPath.row])
        
        //Label formatting & Setting
        cell.cellTitle.font = NAFont().textFieldFont()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let lv = NAViewPresenter().inviteVisitorVC()
            self.navigationController?.pushViewController(lv, animated: true)
            
        case 1:
            let lv1 = NAViewPresenter().myVisitorsListVC()
            self.navigationController?.pushViewController(lv1, animated: true)
            
        case 2:
            let lv2 = NAViewPresenter().myDailyServicesVC()
            self.navigationController?.pushViewController(lv2, animated: true)
            
        case 3:
            let lv3 = NAViewPresenter().notifyDigiGateVC()
            self.navigationController?.pushViewController(lv3, animated: true)
            
            
        case 4:
            let lv4 = NAViewPresenter().mySweetHomeVC()
            lv4.navTitle = NAString().my_sweet_home()
            self.navigationController?.pushViewController(lv4, animated: true)
            
            
        case 5:
            let lv5 = NAViewPresenter().emergencyVC()
            self.navigationController?.pushViewController(lv5, animated: true)
            
        default:
            break
        }
    }
}