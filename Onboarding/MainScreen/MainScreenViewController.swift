//
//  MainScreenViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController
{
    @IBOutlet weak var segmentSelection: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    fileprivate var isSocietyServices = true
    
    //for navigation purpose
    var VCNamesSociety = [String]()
    var VCNamesApartment = [String]()
    
    //implementing society & apartment struct in the view
    var societyData : [societyServicesModel] = []
    var apartmentData : [apartmentServicesModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_Title.text = NAString().splash_NammaHeader_Title()
        
        //for navigation
        VCNamesSociety = ["digitalGateVC"]
        VCNamesApartment = ["homeVC"]
        
        //hide navigation bar
         self.navigationController?.isNavigationBarHidden = true
        
        //color & font size
//       let font = UIFont.systemFont(ofSize: 14)
//        segmentSelection.setTitleTextAttributes([NSAttributedStringKey.font: font],for: .normal)
        
    //assigning values in struct
        
        societyData = [
            societyServicesModel(cellTitle: "Digi Gate",cellImage:  #imageLiteral(resourceName: "Digital_Gate_2")),
            societyServicesModel(cellTitle: "Plumber",cellImage:  #imageLiteral(resourceName: "plumbing (2)")),
            societyServicesModel(cellTitle: "Carpenter",cellImage:  #imageLiteral(resourceName: "Carpenter Service")),
            societyServicesModel(cellTitle: "Electrician",cellImage: #imageLiteral(resourceName: "switchBoard") ),
            societyServicesModel(cellTitle: "Garbage Management",cellImage:  #imageLiteral(resourceName: "garbage-bin (2)")),
            societyServicesModel(cellTitle: "Event Management",cellImage: #imageLiteral(resourceName: "event")),
            societyServicesModel(cellTitle: "Medical Emergency",cellImage:  #imageLiteral(resourceName: "Medical_Emergency_1")),
            societyServicesModel(cellTitle: "Water Services",cellImage: #imageLiteral(resourceName: "water") )
        ]

        apartmentData = [
            apartmentServicesModel(cellTitle: "Cook", cellImage: #imageLiteral(resourceName: "cook_Service")),
            apartmentServicesModel(cellTitle: "Maid",cellImage: #imageLiteral(resourceName: "maidServices") ),
            apartmentServicesModel(cellTitle: "Car / Bike Cleaning",cellImage:  #imageLiteral(resourceName: "carCleaning")),
            apartmentServicesModel(cellTitle: "Child Day Care",cellImage:  #imageLiteral(resourceName: "Child_care_Services_2")),
            apartmentServicesModel(cellTitle: "Daily Newspaper",cellImage:  #imageLiteral(resourceName: "newspaper")),
            apartmentServicesModel(cellTitle: "Milk Man",cellImage:  #imageLiteral(resourceName: "milk")),
            apartmentServicesModel(cellTitle: "Laundry",cellImage:  #imageLiteral(resourceName: "laundry_Service")),
            apartmentServicesModel(cellTitle: "Driver",cellImage:  #imageLiteral(resourceName: "driving-test")),
            apartmentServicesModel(cellTitle: "Groceries", cellImage: #imageLiteral(resourceName: "groceries"))
            
        ]
    }
    
    
    @IBAction func segmentChangeServices(_ sender: UISegmentedControl)
    {
        isSocietyServices = sender.selectedSegmentIndex == 0 ? true : false
        self.tableView.reloadData()
        
    }
    
}

    extension MainScreenViewController : UITableViewDelegate,UITableViewDataSource
    {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return isSocietyServices ? societyData.count : apartmentData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainScreenTableViewCell
            
            if isSocietyServices {
                cell.NSModel = societyData[indexPath.row]
            } else {
                cell.NAModel = apartmentData[indexPath.row]
            }
        
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            let name = isSocietyServices ? VCNamesSociety[indexPath.row]: VCNamesApartment[indexPath.row]
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: name)
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        
        
    }



