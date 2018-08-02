//
//  SocietyTableViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/2/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

protocol SelectProblemDelegate {
    func passingSelectString(name : String?)
}

class SocietyTableViewController: NANavigationViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navTitle: UILabel!
    
    //to get previous View Controller
    var societyServiceVC: SocietyServicesViewController!
    var searchActive : Bool = false
    
    var gettingArray = [String]()
    var filteredArray = [String]()
    var selectAnyString = String()
    var delegate : SelectProblemDelegate?
    
    //TODO: Need to Add more Languages in future.
    var selectAnyList = ["Dripping faucets","Slow draining sink","Clogged bath or shower drain","Clogged toilet","Running toilet","Faulty water heater","Low water pressure","Jammed garbage disposal","Leaky pipes","Sewer system backup"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting Society View Controller Title
        navTitle?.text = NAString().selectAnyProblem()
        
        //Hiding Navigation Bar
        navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
    }
    
    //Create Society ViewController Back button Action
    @IBAction func btn_Back_Action(_ sender: UIButton) {
        goBackToSocietyServicePlumberVC()
    }
    
    //Navigating back to Society Service Plumber screen on click of back button.
    @objc func goBackToSocietyServicePlumberVC() {
        self.navigationController?.dismiss(animated: true)
    }
    
    //Calling Searchbar Delegate Function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = selectAnyList.filter({ (text) -> Bool in
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
            return selectAnyList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath)
        if(searchActive) {
            filteredArray = filteredArray.sorted()
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            selectAnyList = selectAnyList.sorted()
            cell.textLabel?.text = selectAnyList[indexPath.row]
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
        delegate?.passingSelectString(name: currentItem)
        tableView.deselectRow(at: indexPath!, animated: true)
        self.navigationController?.dismiss(animated: true)
    }
}
