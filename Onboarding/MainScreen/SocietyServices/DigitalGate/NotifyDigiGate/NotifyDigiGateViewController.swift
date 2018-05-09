//
//  NotifyDigiGateViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class NotifyDigiGateViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet weak var lbl_Header: UILabel!
    
    var ImageList = [#imageLiteral(resourceName: "ExpectingCabs256"),#imageLiteral(resourceName: "ExpectingPackage256"),#imageLiteral(resourceName: "ExpectiingVisitor256"),#imageLiteral(resourceName: "HandedThings256"),#imageLiteral(resourceName: "HandedDailyServices256")]
    var ExpectingList = ["Excpecting Cab Arrival","Expecting Package Arrival","Expecting Visitor","Handed things to my Guest","Handed things to my Daily Services"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
        //assigned font style & size
        lbl_Header.font = NAFont().headerFont()
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
    
    @IBAction func btnBackToDigiGate(_ sender: UIBarButtonItem)
    {
        let lv : DigitalGateViewController = self.storyboard?.instantiateViewController(withIdentifier: "digitalGateVC") as! DigitalGateViewController
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
}