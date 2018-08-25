//
//  LanguagesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/25/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class LanguagesViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navTitle: UILabel!
    
    //TODO: Need to Add more Languages in future.
    var languagesList = ["English","Hindi","Tamil","Kannada","Telugu"]
    
    //to get previous View Controller
    var settingVC: SettingViewController!
    var searchActive : Bool = false
    
    var navigationTitle = String()
    var filteredArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle?.text = navigationTitle
        
        //Hiding Navigation Bar
        navigationController?.isNavigationBarHidden = true
        
        //Setting SearchBar Delegate
        searchBar.delegate = self
        
        //Hiding NavigationBar RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        goBackToSettingsVC()
    }
    
    //Navigating back to Settings screen on click of back button.
    @objc func goBackToSettingsVC() {
        self.navigationController?.dismiss(animated: true)
    }
    
    //MARK : SearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = languagesList.filter({ (text) -> Bool in
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
            return languagesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath)
        if(searchActive) {
            filteredArray = filteredArray.sorted()
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            languagesList = languagesList.sorted()
            cell.textLabel?.text = languagesList[indexPath.row]
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
        settingVC.selectLanguage = currentItem!
        tableView.deselectRow(at: indexPath!, animated: true)
        self.navigationController?.dismiss(animated: true)
    }
}
