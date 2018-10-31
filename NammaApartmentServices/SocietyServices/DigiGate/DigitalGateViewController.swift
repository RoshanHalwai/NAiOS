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
    
    var digiGateArray = [NAString().invite_Guests(), NAString().my_visitors_list(), NAString().my_Daily_Services(), NAString().notify_digital_gate(), NAString().my_sweet_home(), NAString().emergency()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = nil
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().digital_gate_title())
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        //set cell item size here
        layout.itemSize = CGSize(width: width/2, height: height/4)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 0
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 0
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return digiGateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! DigitalGateCollectionViewCell
        cell.cellTitle.text = digiGateArray[indexPath.row]
        cell.cellImage.image = UIImage(named: digiGateArray[indexPath.row])
        cell.cellTitle.font = NAFont().textFieldFont()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let lv = NAViewPresenter().inviteVisitorVC()
            self.navigationController?.pushViewController(lv, animated: true)
            break
            
        case 1:
            let lv1 = NAViewPresenter().myVisitorsListVC()
            self.navigationController?.pushViewController(lv1, animated: true)
            break
            
        case 2:
            let lv2 = NAViewPresenter().myDailyServicesVC()
            self.navigationController?.pushViewController(lv2, animated: true)
            break
            
        case 3:
            let lv3 = NAViewPresenter().notifyDigiGateVC()
            self.navigationController?.pushViewController(lv3, animated: true)
            break
            
        case 4:
            let lv4 = NAViewPresenter().mySweetHomeVC()
            self.navigationController?.pushViewController(lv4, animated: true)
            break
            
        case 5:
            let lv5 = NAViewPresenter().emergencyVC()
            self.navigationController?.pushViewController(lv5, animated: true)
            break
            
        default:
            break
        }
    }
}
