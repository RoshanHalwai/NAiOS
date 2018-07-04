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
    
    var currentIndex = 0
    
    //Declaring the varibles for structure.
    var apartmentData:[apartmentServicesModel] = []
    var societyData:[societyServicesModel] = []
    
    //for navigation purpose
    var VCNamesSociety = [String]()
    var VCNamesApartment = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Formatting & Setting Segmented Controller.
        segmentSelection.layer.borderWidth = CGFloat(NAString().one())
        segmentSelection.layer.borderColor = UIColor.black.cgColor
        
        segmentSelection.selectedSegmentIndex = currentIndex
        
       //For navigation purpose.
        VCNamesSociety = [NAViewPresenter().digiGateVCID()]
        VCNamesApartment = [NAViewPresenter().homeVCID()]
        
       //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().splash_NammaHeader_Title())
        navigationItem.rightBarButtonItem = nil
        super.navigationItem.hidesBackButton = true
     
    //assigning values in struct
        societyData = [
            societyServicesModel(cellTitle: NAString().digital_gate(),cellImage:  #imageLiteral(resourceName: "Digital_Gate_2")),
            societyServicesModel(cellTitle: NAString().plumber(),cellImage:  #imageLiteral(resourceName: "plumbing (2)")),
            societyServicesModel(cellTitle: NAString().carpenter(),cellImage:  #imageLiteral(resourceName: "Carpenter Service")),
            societyServicesModel(cellTitle: NAString().electrician(),cellImage: #imageLiteral(resourceName: "switchBoard") ),
            societyServicesModel(cellTitle: NAString().garbage_management(),cellImage:  #imageLiteral(resourceName: "garbage-bin (2)")),
            societyServicesModel(cellTitle: NAString().medical_emergency(),cellImage:  #imageLiteral(resourceName: "Medical_Emergency_1")),
            societyServicesModel(cellTitle: NAString().event_management(),cellImage: #imageLiteral(resourceName: "event")),
            societyServicesModel(cellTitle: NAString().water_services(),cellImage: #imageLiteral(resourceName: "New waterTank") )
        ]
        apartmentData = [
            apartmentServicesModel(cellTitle: NAString().cook(), cellImage: #imageLiteral(resourceName: "cook_Service")),
            apartmentServicesModel(cellTitle: NAString().maid(),cellImage: #imageLiteral(resourceName: "maidServices") ),
            apartmentServicesModel(cellTitle: NAString().car_bike_cleaning(),cellImage:  #imageLiteral(resourceName: "carCleaning")),
            apartmentServicesModel(cellTitle: NAString().child_day_care(),cellImage:  #imageLiteral(resourceName: "Child_care_Services_2")),
            apartmentServicesModel(cellTitle: NAString().daily_newspaper(),cellImage:  #imageLiteral(resourceName: "newspaper")),
            apartmentServicesModel(cellTitle: NAString().milk_man(),cellImage:  #imageLiteral(resourceName: "milk")),
            apartmentServicesModel(cellTitle: NAString().laundry(),cellImage:  #imageLiteral(resourceName: "laundry_Service")),
            apartmentServicesModel(cellTitle: NAString().driver(),cellImage:  #imageLiteral(resourceName: "Newdriver")),
            apartmentServicesModel(cellTitle: NAString().groceries(), cellImage: #imageLiteral(resourceName: "groceries"))
        ]
    }
    //For switching the tableview data in between society & apartment services.
    @IBAction func segmentChangeServices(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}
extension MainScreenViewController : UITableViewDelegate,UITableViewDataSource {
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //Modifying tableview data according to segment selection.
            var value = 0
            switch segmentSelection.selectedSegmentIndex {
            case 0:
                value = societyData.count
                break
            case 1:
                value = apartmentData.count
                break
            default:
                break
            }
         return value
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! MainScreenTableViewCell
            //Selection Process.
            switch segmentSelection.selectedSegmentIndex {
            case 0:
                cell.cellTitle.text = societyData[indexPath.row].cellTitle
                cell.cellImage.image = societyData[indexPath.row].cellImage
                break
            case 1:
               cell.cellTitle.text = apartmentData[indexPath.row].cellTitle
               cell.cellImage.image = apartmentData[indexPath.row].cellImage
                break
            default:
                break
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //For Navigation Purpose.
          let destVC = currentIndex == 0 ? VCNamesSociety[0]: VCNamesApartment[0]
          let viewController = storyboard?.instantiateViewController(withIdentifier: destVC)
          self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }



