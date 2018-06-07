//
//  MainScreenViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MainScreenViewController: NANavigationViewController
{
    @IBOutlet weak var segmentSelection: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
   
    fileprivate var isSocietyServices = true
    
    var pageViewController = UIPageViewController()
    
    var currentIndex = 0
    
    //pageview
    lazy var viewControllerList : [UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = sb.instantiateViewController(withIdentifier: "mainScreenVC")
        return[VC1]
    }()
    
    var customView = UIView()
    
    //for navigation purpose
    var VCNamesSociety = [String]()
    var VCNamesApartment = [String]()
    
    //implementing society & apartment struct in the view
    var societyData = [
        societyServicesModel(cellTitle: "Digi Gate",cellImage:  #imageLiteral(resourceName: "Digital_Gate_2")),
        societyServicesModel(cellTitle: "Plumber",cellImage:  #imageLiteral(resourceName: "plumbing (2)")),
        societyServicesModel(cellTitle: "Carpenter",cellImage:  #imageLiteral(resourceName: "Carpenter Service")),
        societyServicesModel(cellTitle: "Electrician",cellImage: #imageLiteral(resourceName: "switchBoard") ),
        societyServicesModel(cellTitle: "Garbage Management",cellImage:  #imageLiteral(resourceName: "garbage-bin (2)")),
        societyServicesModel(cellTitle: "Medical Emergency",cellImage:  #imageLiteral(resourceName: "Medical_Emergency_1")),
        societyServicesModel(cellTitle: "Event Management",cellImage: #imageLiteral(resourceName: "event")),
        societyServicesModel(cellTitle: "Water Services",cellImage: #imageLiteral(resourceName: "New waterTank") )
    ]
    var apartmentData = [
    apartmentServicesModel(cellTitle: "Cook", cellImage: #imageLiteral(resourceName: "cook_Service")),
    apartmentServicesModel(cellTitle: "Maid",cellImage: #imageLiteral(resourceName: "maidServices") ),
    apartmentServicesModel(cellTitle: "Car / Bike Cleaning",cellImage:  #imageLiteral(resourceName: "carCleaning")),
    apartmentServicesModel(cellTitle: "Child Day Care",cellImage:  #imageLiteral(resourceName: "Child_care_Services_2")),
    apartmentServicesModel(cellTitle: "Daily NewsPaper",cellImage:  #imageLiteral(resourceName: "newspaper")),
    apartmentServicesModel(cellTitle: "Milk Man",cellImage:  #imageLiteral(resourceName: "milk")),
    apartmentServicesModel(cellTitle: "Laundry",cellImage:  #imageLiteral(resourceName: "laundry_Service")),
    apartmentServicesModel(cellTitle: "Driver",cellImage:  #imageLiteral(resourceName: "Newdriver")),
    apartmentServicesModel(cellTitle: "Groceries", cellImage: #imageLiteral(resourceName: "groceries"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentSelection.selectedSegmentIndex = currentIndex
        //for navigation
        VCNamesSociety = ["digiGateVC"]
        VCNamesApartment = ["homeVC"]
        
       //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().splash_NammaHeader_Title())
        navigationItem.rightBarButtonItem = nil
        super.navigationItem.hidesBackButton = true
     
    //assigning values in struct
        societyData = [
            societyServicesModel(cellTitle: "Digi Gate",cellImage:  #imageLiteral(resourceName: "Digital_Gate_2")),
            societyServicesModel(cellTitle: "Plumber",cellImage:  #imageLiteral(resourceName: "plumbing (2)")),
            societyServicesModel(cellTitle: "Carpenter",cellImage:  #imageLiteral(resourceName: "Carpenter Service")),
            societyServicesModel(cellTitle: "Electrician",cellImage: #imageLiteral(resourceName: "switchBoard") ),
            societyServicesModel(cellTitle: "Garbage Management",cellImage:  #imageLiteral(resourceName: "garbage-bin (2)")),
            societyServicesModel(cellTitle: "Medical Emergency",cellImage:  #imageLiteral(resourceName: "Medical_Emergency_1")),
            societyServicesModel(cellTitle: "Event Management",cellImage: #imageLiteral(resourceName: "event")),
            societyServicesModel(cellTitle: "Water Services",cellImage: #imageLiteral(resourceName: "New waterTank") )
        ]
        
        apartmentData = [
            apartmentServicesModel(cellTitle: "Cook", cellImage: #imageLiteral(resourceName: "cook_Service")),
            apartmentServicesModel(cellTitle: "Maid",cellImage: #imageLiteral(resourceName: "maidServices") ),
            apartmentServicesModel(cellTitle: "Car / Bike Cleaning",cellImage:  #imageLiteral(resourceName: "carCleaning")),
            apartmentServicesModel(cellTitle: "Child Day Care",cellImage:  #imageLiteral(resourceName: "Child_care_Services_2")),
            apartmentServicesModel(cellTitle: "Daily NewsPaper",cellImage:  #imageLiteral(resourceName: "newspaper")),
            apartmentServicesModel(cellTitle: "Milk Man",cellImage:  #imageLiteral(resourceName: "milk")),
            apartmentServicesModel(cellTitle: "Laundry",cellImage:  #imageLiteral(resourceName: "laundry_Service")),
            apartmentServicesModel(cellTitle: "Driver",cellImage:  #imageLiteral(resourceName: "Newdriver")),
            apartmentServicesModel(cellTitle: "Groceries", cellImage: #imageLiteral(resourceName: "groceries"))
        ]
    }
    
    //page view controller left & right swipe
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if currentIndex <= 0 {
            currentIndex = currentIndex + 1
        }
        return self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex <= 1 {
            currentIndex = currentIndex - 1
        }
        return self
    }
   
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return self
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
            
            if isSocietyServices == true {
                cell.NSModel = societyData[indexPath.row]
                isSocietyServices = false
            } else {
                cell.NAModel = apartmentData[indexPath.row]
                isSocietyServices = true
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            let name = currentIndex == 0 ? VCNamesSociety[0]: VCNamesApartment[0]
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: name)
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }



