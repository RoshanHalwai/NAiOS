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

    //array for navigation
    var VCNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting Title of the screen
        super.ConfigureNavBarTitle(title: "Emergency")
        
       //To navigate from Digi gate to its Sub-screens
        VCNames = ["raiseEmergencyVC","raiseEmergencyVC","raiseEmergencyVC"]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return ImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmergencyCollectionViewCell
        
        cell.cellImage.image = ImageList[indexPath.row]
        cell.cellLabel.text = EmergencyList[indexPath.row]
        
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let name = VCNames[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
}
