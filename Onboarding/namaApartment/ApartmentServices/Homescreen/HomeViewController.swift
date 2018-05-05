//
//  HomeViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 03/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    
    var imageList=["splashScreen","splashScreen"]
    var headerList = ["SOCIETY SERVICES","APARTMENT SERVICES"]
    
    var VCNames = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        lbl_Title.font = NAFont().viewTitleFont()
        
        //onclick story oard id names for segue
       VCNames = ["societyVC","appartmentVC"]
        
       self.navigationController?.isNavigationBarHidden = true
        //self.navigationItem.hidesBackButton = true
       self.navigationItem.title = "Namma Apartment"
        
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
            
            cell.cellImage.image = UIImage(named: imageList[indexPath.row])
            cell.cellLabel.text = headerList[indexPath.row]
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        let name = VCNames[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: name)
        self.navigationController?.pushViewController(viewController!, animated: true)


    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 305
        
    }
    

}
