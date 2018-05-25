//
//  DigitalGateViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

//To Identify cell
private let reuseIdentifier = "Cell"
class DigitalGateViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
  
    var DGimageList=["InviteVisitors","MyVisitorsList","MyDailyServices","NotifyDigitalGate","sweetHome","Medical"]
    var DGNameList=["Invite Visitors","My Visitors List","My Daily Services","Notify Digi Gate","My Sweet Home","Emergency"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //created backbuttom custom to go to digi gate screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToDigiGate))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationItem.hidesBackButton = true
        
        //To navigate from Digi gate to its Sub-screens
        VCNames = ["inviteVisitorVC","myVisitorListVC","myDailyServicesVC","notifyDigiGateVC","mySweetHomeVC","emergencyVC"]
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().digital_gate_title())
        self.navigationItem.title = ""
    }
    
    //created custome back button to go back to digi gate
    @objc func goBackToDigiGate()
    {
        let vcName = UIStoryboard(name: "Main", bundle: nil)
        let destVC = vcName.instantiateViewController(withIdentifier: "mainScreenVC")
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        return DGimageList.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DigitalGateCollectionViewCell
        
        cell.cellTitle.text = DGNameList[indexPath.row]
        cell.cellImage.image = UIImage(named: DGimageList[indexPath.row])
        
        //Label formatting & Setting
        cell.cellTitle.font = NAFont().headerFont()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let name = VCNames[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
