//
//  EditMyProfileFlatMembersListViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 08/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class EditMyProfileFlatMembersListViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navTitle: UILabel!
    
    var searchActive : Bool = false
    var myProfileVC : EditMyProfileViewController!
    
    var navigationTitle = String()
    var gettingArray = [String]()
    var filteredArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle?.text = navigationTitle
        
        gettingArray = myProfileVC.flatMembersNameList
        
        //Hiding Navigation Bar
        navigationController?.isNavigationBarHidden = true
        
        //Setting SearchBar Delegate
        searchBar.delegate = self
        
        //Hiding NavigationBar RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        goBackToMyProfileVC()
    }
    
    @objc func goBackToMyProfileVC() {
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
            gettingArray = gettingArray.sorted()
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
        myProfileVC.updatedAdminUID = myProfileVC.allFlatMembersUID[(indexPath?.row)!]
        myProfileVC.selectedMember = currentItem!
        tableView.deselectRow(at: indexPath!, animated: true)
        self.navigationController?.dismiss(animated: true)
    }
}
