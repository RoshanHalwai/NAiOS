//
//  SocietyHistoryViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/3/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SocietyHistoryViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //set title from previous page
    var titleName =  String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        
        navigationItem.rightBarButtonItem = nil
    }
    
    //MARK : CollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! SocietyHistoryCollectionViewCell
        
        //assigning font & style to cell labels
        cell.lbl_Name.font = NAFont().headerFont()
        cell.lbl_Number.font = NAFont().headerFont()
        cell.lbl_Problem.font = NAFont().headerFont()
        cell.lbl_SlotTime.font = NAFont().headerFont()
        cell.lbl_ServiceName.font = NAFont().textFieldFont()
        cell.lbl_ServiceNumber.font = NAFont().textFieldFont()
        cell.lbl_ServiceProblem.font = NAFont().textFieldFont()
        cell.lbl_ServiceSlotTime.font = NAFont().textFieldFont()
        
        //cardUIView
        cell.cardView?.layer.cornerRadius = 3
        cell.cardView?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cell.cardView?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cell.cardView?.layer.shadowRadius = 1.7
        cell.cardView?.layer.shadowOpacity = 0.45
        
        return cell
    }
}
