//
//  DigitalGateViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

//To Identifier cell
private let reuseIdentifier = "Cell"

class DigitalGateViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lbl_Title: UILabel!
    var DGimageList=["InviteVisitors","MyVisitorsList","MyDailyServices","NotifyDigitalGate","sweetHome","Medical"]
    var DGNameList=["Invite Visitors","My Visitors List","My Daily Services","Notify Digi Gate","My Sweet Home","Emergency"]
    
    //array for navigation
   var VCNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To navigate from Digi gate to its Sub-screens
        VCNames = ["inviteVisitorVC","myVisitorListVC","","notifyDigiGateVC","",""]
        
        //hide navigation bar
         self.navigationController?.isNavigationBarHidden = true
        
        //Label Formatting & setting
        lbl_Title.text = NAString().digital_gate()
        lbl_Title.font = NAFont().headerFont()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

    @IBAction func BackToMainScreen(_ sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let name = VCNames[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
