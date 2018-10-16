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
        
        let updatedAdminUID = myProfileVC.allFlatMembersUID[(indexPath?.row)!]
        
        // Showing Confirmation Alert PopUp for changing Admin Access
        NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().change_Admin_Message_Alert_Title(), Message: NAString().change_Admin_Message_Alert_Message(name: currentItem!), CancelStyle: .default, OkStyle: .default, OK: { (action) in
            
            //After Changing Admin Access Previous Admin user Admin Access changed to false.
            let removedAdminRef =  Constants.FIREBASE_USERS_PRIVATE.child(self.myProfileVC.adminUID!).child(Constants.FIREBASE_CHILD_PRIVILEGES)
            removedAdminRef.child(Constants.FIREBASE_CHILD_ADMIN).setValue(NAString().getfalse())
            //Setting the admin Value in GlobalUser data after User Changed Admin Access
            GlobalUserData.shared.privileges_Items.first?.setAdmin(admin: NAString().getfalse())
            
            //After Changing Admin Access new Admin UID will get Replaced with previous UID
            let UpdatedUserDataAdminRef = GlobalUserData.shared.getUserDataReference()
            UpdatedUserDataAdminRef.child(Constants.FIREBASE_CHILD_ADMIN).setValue(updatedAdminUID)
            
            //After Changing Admin Access new Admin user Admin Access will be Chnaged to true
            let updatedUserAdminRef = Constants.FIREBASE_USERS_PRIVATE.child(updatedAdminUID).child(Constants.FIREBASE_CHILD_PRIVILEGES)
            updatedUserAdminRef.child(Constants.FIREBASE_CHILD_ADMIN).setValue(NAString().gettrue())
            
            //After Changing Admin Access new Admin user Grant Access will be Changes to true
            let updatedUserGrantAccessRef = Constants.FIREBASE_USERS_PRIVATE.child(updatedAdminUID).child(Constants.FIREBASE_CHILD_PRIVILEGES)
            updatedUserGrantAccessRef.child(Constants.FIREBASE_CHILD_GRANTACCESS).setValue(NAString().gettrue())
            
            //Showing Successfully Updated PopUp after Data Replaced in firebase.
            NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().update_Alert_Title(), Message: NAString().update_Successfull_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default) { (action) in
                
                //Making present user to logout from this App after Clicking ok in Alert PopUp.
                self.logoutAction()
            }
        }, Cancel: { (action) in}, cancelActionTitle: NAString().no(), okActionTitle: NAString().yes())
        tableView.deselectRow(at: indexPath!, animated: true)
    }
    
    //To Logout the current user
    func logoutAction() {
        let preferences = UserDefaults.standard
        let userUID = NAString().userDefault_USERUID()
        let loggedIn = NAString().userDefault_Logged_In()
        preferences.removeObject(forKey: userUID)
        preferences.set(false, forKey: loggedIn)
        preferences.synchronize()
        if self.storyboard != nil {
            let NavLogin = NAViewPresenter().loginVC()
            self.navigationController?.pushViewController(NavLogin, animated: true)
        }
    }
}
