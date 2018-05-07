//
//  DigitalGateViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
class DigitalGateViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    
     var DGimageList=["InviteVisitors","MyVisitorsList","MyDailyServices","NotifyDigitalGate","sweetHome","Medical"]
    
    var DGNameList=["Invite Visitors","My Visitors List","My Daily Services","Notify Digi Gate","My Sweet Home","Emergency"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hide navigation bar
         self.navigationController?.isNavigationBarHidden = true
        
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
       
        return cell
    }

    
    @IBAction func BackToMainScreen(_ sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       
        let lv : InviteVisitorViewController = self.storyboard?.instantiateViewController(withIdentifier: "inviteVisitorVC") as! InviteVisitorViewController
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    

}
