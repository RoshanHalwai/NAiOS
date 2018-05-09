//
//  SocietyViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 03/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SocietyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbl_Title: UILabel!
    
    var imageList=["1.security-lock-50","2.wrench-filled-50","Newcarpenter","4.switch-filled-50","5.garbage-truck-filled-50","6.event-management-filled-50","7.ambulance-filled-50","8.water-hose-filled-50"]
    var headerList = ["Security Gate","Plumber","Carpenter","Electrician","Garbage Management","Event Management","Medical Emergency","Water Services"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_Title.font = NAFont().viewTitleFont()
         self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SocietyTableViewCell
        
        cell.cellImage.image = UIImage(named: imageList[indexPath.row])
        cell.cellLabel.text = headerList[indexPath.row]
        
        return cell
    }
    
    
    @IBAction func btnBackToHome(_ sender: Any)
    {
        let lv : HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
      
         self.navigationController?.pushViewController(lv, animated: true)
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
        
    }

}
