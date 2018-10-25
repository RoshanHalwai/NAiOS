//
//  LanguagesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/25/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ContactUsListViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navTitle: UILabel!
    
    var societyServiceArray = [NAString().digi_gate(), NAString().plumber(), NAString().carpenter(), NAString().electrician(), NAString().garbage_Collection(), NAString().emergency(), NAString().event_management(), NAString().scrapCollection()]
    
    var apartmentServiceArray = [NAString().cook(), NAString().maid(), NAString().car_bike_cleaning(), NAString().child_day_care(), NAString().daily_newspaper(), NAString().milk_man(), NAString().laundry(), NAString().driver()]
    
    var miscellaneousArray = [NAString().My_Profile(),NAString().my_vehicles(),NAString().my_guards(),NAString().myNeighbours(),NAString().donateFood(),NAString().notice_board()]
    
    var searchActive : Bool = false
    
    var navigationTitle = String()
    var gettingArray = [String]()
    var filteredArray = [String]()
    var contactUsVC : ContactUsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle?.text = navigationTitle
        
        if contactUsVC.getServiceButton_Text == NAString().societyService() {
            gettingArray = societyServiceArray
        } else if contactUsVC.getServiceButton_Text == NAString().ApartmentServices() {
            gettingArray = apartmentServiceArray
        } else {
            gettingArray = miscellaneousArray
        }
        
        //Hiding Navigation Bar
        navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
        
        //Hiding NavigationBar RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        goBackToContactUsVC()
    }
    
    @objc func goBackToContactUsVC() {
        self.navigationController?.dismiss(animated: true)
    }
    
    //MARK : SearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = gettingArray.filter({ (text) -> Bool in
            let string: NSString = text as NSString
            let range = string.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
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
        } else {
            return gettingArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath)
        if(searchActive) {
            filteredArray = filteredArray.sorted()
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            cell.textLabel?.text = gettingArray[indexPath.row]
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
        contactUsVC.selectedItem = currentItem!
        tableView.deselectRow(at: indexPath!, animated: true)
        self.navigationController?.dismiss(animated: true)
    }
}
