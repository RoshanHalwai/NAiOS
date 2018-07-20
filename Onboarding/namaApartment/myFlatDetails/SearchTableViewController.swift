//
//  SearchTableViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 04/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var gettingArray = [String]()
    var filteredArray = [String]()
    var searchController = UISearchController()
    var tableViewResultController = UITableViewController()
    
    //to get previous View Controller
    var myFlatDetailsVC: myFlatDetailsViewController!
    //to set navigation title
    var navTitle: String = "City"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: tableViewResultController)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        tableViewResultController.tableView.delegate = self
        tableViewResultController.tableView.dataSource = self
        tableViewResultController.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //created custom back button for goto My Visitors Lists screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToMyFlatDetails))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        if title == NAString().your_city() {
            gettingArray = myFlatDetailsVC.cities
        } else if title == NAString().your_society() {
            gettingArray = myFlatDetailsVC.societies
        } else if title == NAString().your_apartment() && myFlatDetailsVC.societyString == myFlatDetailsVC.societies[0] {
            gettingArray = myFlatDetailsVC.BrigadeGateway
        } else if title == NAString().your_apartment() && myFlatDetailsVC.societyString == myFlatDetailsVC.societies[1] {
            gettingArray = myFlatDetailsVC.SalarpuriaCambridge
        }
        else if title == NAString().your_flat() {
            if myFlatDetailsVC.apartmentString == myFlatDetailsVC.BrigadeGateway[0] {
                gettingArray = myFlatDetailsVC.Aster
            } else if myFlatDetailsVC.apartmentString == myFlatDetailsVC.BrigadeGateway[1] {
                gettingArray = myFlatDetailsVC.Bolivia
            } else if myFlatDetailsVC.apartmentString == myFlatDetailsVC.SalarpuriaCambridge[0] {
                gettingArray = myFlatDetailsVC.Block1
            }  else if myFlatDetailsVC.apartmentString == myFlatDetailsVC.SalarpuriaCambridge[1] {
                gettingArray = myFlatDetailsVC.Block2
            }  else if myFlatDetailsVC.apartmentString == myFlatDetailsVC.SalarpuriaCambridge[2] {
                gettingArray = myFlatDetailsVC.Block3
            }  else if myFlatDetailsVC.apartmentString == myFlatDetailsVC.SalarpuriaCambridge[3] {
                gettingArray = myFlatDetailsVC.Block4
            }  else if myFlatDetailsVC.apartmentString == myFlatDetailsVC.SalarpuriaCambridge[4] {
                gettingArray = myFlatDetailsVC.Block5
            }
        }
    }
    
    //created custome back button to go back to My Visitors List
    @objc func goBackToMyFlatDetails() {
        self.navigationController?.dismiss(animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredArray = gettingArray.filter({ (array:String) -> Bool in
            if array.contains(searchController.searchBar.text!) {
                return true
            } else {
                return false
            }
        })
        tableViewResultController.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewResultController.tableView {
            return filteredArray.count
        } else {
            return gettingArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == tableViewResultController.tableView {
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            cell.textLabel?.text = gettingArray[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //getting the index path of selected row
        let indexPath = tableView.indexPathForSelectedRow
        //getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell;()
        //getting the text of that cell
        let currentItem = currentCell.textLabel?.text
        
        if title == NAString().your_city() {
            myFlatDetailsVC.cityString = currentItem!
        } else if title == NAString().your_society() {
            myFlatDetailsVC.societyString = currentItem!
        } else if title == NAString().your_apartment() {
            myFlatDetailsVC.apartmentString = currentItem!
        } else if title == NAString().your_flat() {
            myFlatDetailsVC.flatString = currentItem!
        }
        self.navigationController?.dismiss(animated: true)
    }
}
