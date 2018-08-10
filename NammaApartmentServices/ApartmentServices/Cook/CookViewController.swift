//
//  CookViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class CookViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var titleName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().cookViewTitle())
    }
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! CookCollectionViewCell
        
        //TODO: Feature Added Firebase Data
        cell.lbl_MyCookName.text = "Srilatha"
        cell.lbl_MyCookRating.text = "5"
        cell.lbl_MyCookTimeSlot.text = "8:30 PM"
        cell.lbl_MyCookFlat.text = "5"
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //setting image round
        cell.myCookImage.layer.cornerRadius = cell.myCookImage.frame.size.width/2
        cell.myCookImage.clipsToBounds = true
        
        return cell
    }
}
