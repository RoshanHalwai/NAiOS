//
//  EmergencyViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 15/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class EmergencyViewController: NANavigationViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    var ImageList = [#imageLiteral(resourceName: "hospital"),#imageLiteral(resourceName: "flame"),#imageLiteral(resourceName: "alarm")]
    var EmergencyList = ["Medical Emergency","Raise Fire Alarm","Raise Theft Alarm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting Title of the screen
        super.ConfigureNavBarTitle(title: NAString().emergency())
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmergencyCollectionViewCell
        
        cell.cellImage.image = ImageList[indexPath.row]
        cell.cellLabel.text = EmergencyList[indexPath.row]
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //Label formatting & Setting
        cell.cellLabel.font = NAFont().textFieldFont()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let lv = NAViewPresenter().raiseAlarmVC()
            self.navigationController?.pushViewController(lv, animated: true)
            lv.titleName = NAString().medical_emergency_Title().capitalized
            
        case 1:
            let lv1 = NAViewPresenter().raiseAlarmVC()
            self.navigationController?.pushViewController(lv1, animated: true)
            lv1.titleName = NAString().raise_Fire_Alarm_Title().capitalized
            
        case 2:
            let lv2 = NAViewPresenter().raiseAlarmVC()
            self.navigationController?.pushViewController(lv2, animated: true)
            lv2.titleName = NAString().raise_Theft_Alarm_Title().capitalized
            
        default:
            break
        }
    }
}