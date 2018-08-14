//
//  SettingsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SettingsViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection_View: UICollectionView!
    
    var settingsArray = [NAString().general_settings(), NAString().notification_settings()]
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
        
        super.ConfigureNavBarTitle(title: navTitle)
        
        collection_View.delegate = self
        collection_View.dataSource = self
        collection_View.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! SettingsCollectionViewCell
        cell.label_View.text = settingsArray[indexPath.row]
        
        //Label formatting & setting
        cell.label_View.font = NAFont().textFieldFont()
        NAShadowEffect().shadowEffect(Cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let dv = NAViewPresenter().generalSettingsVC()
            dv.navTitle = NAString().general_settings()
            self.navigationController?.pushViewController(dv, animated: true)
        case 1:
            let dv1 = NAViewPresenter().notificationSettingsVC()
            dv1.navTitle = NAString().notification_settings()
            self.navigationController?.pushViewController(dv1, animated: true)
        default:
            break
        }
    }
    
}
