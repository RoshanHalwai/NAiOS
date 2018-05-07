//
//  ApartmentViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 03/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ApartmentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    
    var imageList=["1.cook_Service_3","2.maid_Service","3.car-Cleaning","4.child_Day","5.newsPaper_Service","6.milk_Man_Service","7.laundry_Service","8.driving-filled-50","9.grocery_Service"]
    var headerList = ["Cook","Maid","Car / Bike Cleaning","Child Day Care","Daily Newspaper","Milk Man","Laundry","Driver","Groceries"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_Title.font = NAFont().viewTitleFont()
       
        self.navigationController?.isNavigationBarHidden = true
        
 
      self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ApartmentTableViewCell
        
        cell.cellImage.image = UIImage(named: imageList[indexPath.row])
        cell.cellLabel.text = headerList[indexPath.row]
        
        return cell
    }
    
    
    @IBAction func btnBackToHome(_ sender: Any)
    {
        let lv : HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        self.navigationController?.pushViewController(lv, animated: true)
        
    }
    
    
}
