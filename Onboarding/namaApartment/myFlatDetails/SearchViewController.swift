//
//  SearchViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 25/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var navTitle: UILabel!
    
    var gettingArray = [String]()
    var filteredArray = [String]()
    var tableViewResultController = UITableViewController()
    
    //to get previous View Controller
    var myFlatDetailsVC: myFlatDetailsViewController!
    var searchActive : Bool = false
    var navigationTitle = String()
    
    var clientList = [String]()
    var textFieldText = String()
    
    //Database References
    var usersUIDRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle?.text = navigationTitle
        
        //Hiding Navigation Bar
        navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
        
        usersUIDRef = Database.database().reference().child(Constants.FIREBASE_CHILD_CLIENTS).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
        
        if navigationTitle == NAString().your_city() {
            usersUIDRef = usersUIDRef?.child(Constants.FIREBASE_CHILD_CITIES)
        } else if navigationTitle == NAString().your_society() {
            usersUIDRef = usersUIDRef?.child(Constants.FIREBASE_CHILD_SOCIETIES)
                .child(textFieldText)
        } else if navigationTitle == NAString().your_apartment() {
            usersUIDRef = usersUIDRef?.child(Constants.FIREBASE_CHILD_APARTMENTS)
                .child(textFieldText)
        } else {
            usersUIDRef = usersUIDRef?.child(Constants.FIREBASE_CHILD_FLATS)
                .child(textFieldText)
        }
        updateItemInList(userClientRef: usersUIDRef!)
    }
    
    @IBAction func btn_Back_Action(_ sender: UIButton) {
        goBackToMyFlatDetails()
    }
    
    //Navigating back to My Flat details screen on click of back button.
    @objc func goBackToMyFlatDetails() {
        self.navigationController?.dismiss(animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = gettingArray.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filteredArray.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.table_View.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredArray.count
        } else {
            return gettingArray.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID()) as! SearchTableViewCell
        if(searchActive) {
            cell.textLabel?.text = filteredArray[indexPath.row]
        } else {
            cell.textLabel?.text = gettingArray[indexPath.row]
        }
        cell.textLabel?.font = NAFont().textFieldFont()
        return cell
    }
    
    //Getting Data on Selecting Particular data of cell from the Index path.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell;()
        let currentItem = currentCell.textLabel?.text
        
        if navigationTitle == NAString().your_city() {
            myFlatDetailsVC.cityString = currentItem!
        } else if navigationTitle == NAString().your_society() {
            myFlatDetailsVC.societyString = currentItem!
        } else if navigationTitle == NAString().your_apartment() {
            myFlatDetailsVC.apartmentString = currentItem!
        } else if navigationTitle == NAString().your_flat() {
            myFlatDetailsVC.flatString = currentItem!
        }
        self.navigationController?.dismiss(animated: true)
    }
    
}

extension SearchViewController {
    func updateItemInList(userClientRef : DatabaseReference) {
        self.clientList.removeAll()
        userClientRef.observeSingleEvent(of: .value) { (snapshot) in
            let keys = snapshot.value as? NSDictionary
            for key in (keys?.allKeys)! {
                self.clientList.append(key as! String)
            }
            self.gettingArray = self.clientList
            self.table_View.reloadData()
        }
    }
}
