//
//  SocietyTableViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/2/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SocietyTableViewController: NANavigationViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navTitle: UILabel!
    
    //to get previous View Controller
    var societyServiceVC: SocietyServicesViewController!
    var searchActive : Bool = false
    
    var titleString : String?
    var navigationTitle = String()
    var filteredArray = [String]()
    
    var plumberProblemsList = [NAString().dripping_faucets(), NAString().dslow_draining_sink(), NAString().clogged_bath_or_shower_drain(), NAString().clogged_toilet(), NAString().running_toilet(), NAString().faulty_water_heater(), NAString().low_water_pressure(), NAString().jammed_garbage_disposal(), NAString().leaky_pipes(), NAString().sewer_system_backup(), NAString().others()]
    var carpenterProblemsList = [NAString().carpentry_finish_appears_uneven(), NAString().split_in_the_wood(), NAString().weak_joints(), NAString().dents_in_wood(), NAString().glue_stuck(), NAString().wood_flooring(), NAString().damage_burns(), NAString().sofa_door(), NAString().window_frame(), NAString().others()]
    var electricianProblemsList = [NAString().frequent_electrical_surge(), NAString().sags_and_dips_in_power(), NAString().light_switches_not_working_properly(), NAString().circuit_breaker_tripping_frequently(), NAString().circuit_overload(), NAString().lights_too_bright_or_dim(), NAString().electrical_shocks(), NAString().high_electrical_bill(), NAString().light_bulbs_burning_out_too_often(), NAString().recessed_light_goes_out_and_comes_back_on(), NAString().others()]
    var scrapCollectionTypeList = [NAString().paper_Scrap(), NAString().metal_Waste(), NAString().plastic(), NAString().bottles(), NAString().clothes(), NAString().utensils(), NAString().electronic_Waste(), NAString().mix_Waste(), NAString().others()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle?.text = navigationTitle
        
        //Hiding Navigation Bar
        navigationController?.isNavigationBarHidden = true
        
        searchBar.delegate = self
        
        //Hiding NavigationBar RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        goBackToSocietyServicePlumberVC()
    }
    
    //Navigating back to Society Service Plumber screen on click of back button.
    @objc func goBackToSocietyServicePlumberVC() {
        self.navigationController?.dismiss(animated: true)
    }
    
    //Calling Searchbar Delegate Function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if NAString().plumber() == titleString {
            filteredArray = plumberProblemsList.filter({ (text) -> Bool in
                let string: NSString = text as NSString
                let range = string.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        } else if (NAString().carpenter() == titleString) {
            filteredArray = carpenterProblemsList.filter({ (text) -> Bool in
                let string: NSString = text as NSString
                let range = string.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        } else if (NAString().electrician() == titleString) {
            filteredArray = electricianProblemsList.filter({ (text) -> Bool in
                let string: NSString = text as NSString
                let range = string.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        } else {
            filteredArray = scrapCollectionTypeList.filter({ (text) -> Bool in
                let string: NSString = text as NSString
                let range = string.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        }
        if(filteredArray.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView?.reloadData()
    }
    
    // MARK: TableView Delegate & DataSource Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredArray.count
        } else if (NAString().plumber() == titleString) {
            return plumberProblemsList.count
        } else if (NAString().carpenter() == titleString) {
            return carpenterProblemsList.count
        } else if (NAString().electrician() == titleString) {
            return electricianProblemsList.count
        } else {
            return scrapCollectionTypeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath)
        if(searchActive) {
            filteredArray = filteredArray.sorted()
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else if (NAString().plumber() == titleString) {
            cell.textLabel?.text = plumberProblemsList[indexPath.row]
        } else if (NAString().carpenter() == titleString) {
            cell.textLabel?.text = carpenterProblemsList[indexPath.row]
        } else if (NAString().electrician() == titleString) {
            cell.textLabel?.text = electricianProblemsList[indexPath.row]
        } else {
            cell.textLabel?.text = scrapCollectionTypeList[indexPath.row]
        }
        
        //Label formatting & setting
        cell.textLabel?.font = NAFont().textFieldFont()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* - Getting the index path of selected row.
         - Getting the current cell from the index path.
         - Getting the text of that cell. */
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell;()
        let currentItem = currentCell.textLabel?.text
        societyServiceVC.selectedProblem = currentItem!
        tableView.deselectRow(at: indexPath!, animated: true)
        self.navigationController?.dismiss(animated: true)
    }
}
