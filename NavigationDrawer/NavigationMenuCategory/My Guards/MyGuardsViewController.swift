//
//  MyGuardsViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyGuardsViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
    }
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO : Feature Added Firebase Cooks List
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyGuardsCollectionViewCell
        
        //TODO: Feature Added Firebase Data
        cell.lbl_MyGuardName.text = "Sourav"
        cell.lbl_MyGuardGateNo.text = "5"
        cell.lbl_MyGuardStatus.text = "AVAILABLE"
        
        //assigning font & style to cell labels
        cell.lbl_MyGuardName.font = NAFont().headerFont()
        cell.lbl_MyGuardGateNo.font = NAFont().headerFont()
        cell.lbl_MyGuardStatus.font = NAFont().headerFont()
        cell.lbl_GuardName.font = NAFont().textFieldFont()
        cell.lbl_GuardGateNo.font = NAFont().textFieldFont()
        cell.lbl_GuardStatus.font = NAFont().textFieldFont()
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //setting image round
        cell.myGuardImage.layer.cornerRadius = cell.myGuardImage.frame.size.width/2
        cell.myGuardImage.clipsToBounds = true
        
        return cell
    }
}
