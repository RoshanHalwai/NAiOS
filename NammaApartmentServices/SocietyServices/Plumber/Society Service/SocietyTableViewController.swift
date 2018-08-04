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
    
    //to get previous View Controller
    var societyServiceVC: SocietyServicesViewController!
    var searchActive : Bool = false
    
    var titleString : String?
    var filteredArray = [String]()
    var delegate : SelectProblemDelegate?
    
    //TODO: Need to Add more Problems in future.
    var plumberProblemsList = ["Dripping faucets","Slow draining sink","Clogged bath or shower drain","Clogged toilet","Running toilet","Faulty water heater","Low water pressure","Jammed garbage disposal","Leaky pipes","Sewer system backup","Others"]
    var carpenterProblemsList = ["Carpentry finish appears uneven","Split in the wood","Weak joints","Dents in wood","Glue stuck","Others"]
    var electricianProblemsList = ["Frequent Electrical Surge","Sags and Dips in Power","Light Switches not working properly","Circuit Overload","Circuit Breaker Tripping Frequently","Lights too Bright or Dim","Electrical Shocks","High Electrical Bill","Light Bulbs burning out too often","Recessed Light 'Goes Out' and comesback on","Others"]
    
    //To set navigation title
    var navTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)
        
        searchBar.delegate = self
        
        //Hiding NavigationBar RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
        
        //Create Navigationbar Back Button
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToSocietyServicePlumberVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating back to Society Service Plumber screen on click of back button.
    @objc func goBackToSocietyServicePlumberVC() {
        self.navigationController?.popViewController(animated: true)
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
        } else {
            filteredArray = electricianProblemsList.filter({ (text) -> Bool in
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
        } else {
            return electricianProblemsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath)
        if(searchActive) {
            filteredArray = filteredArray.sorted()
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else if (NAString().plumber() == titleString) {
            plumberProblemsList = plumberProblemsList.sorted()
            cell.textLabel?.text = plumberProblemsList[indexPath.row]
        } else if (NAString().carpenter() == titleString) {
            carpenterProblemsList = carpenterProblemsList.sorted()
            cell.textLabel?.text = carpenterProblemsList[indexPath.row]
        } else {
            electricianProblemsList = electricianProblemsList.sorted()
            cell.textLabel?.text = electricianProblemsList[indexPath.row]
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
        self.navigationController?.popViewController(animated: true)
    }
}
