//
//  SideMenuViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 19/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseAuth

class NavigationMenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var lbl_Apartment: UILabel!
    @IBOutlet weak var lbl_Flat: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var sideMenuArray = [NAString().my_profile(),NAString().myWallet(), NAString().my_family_members(),NAString().my_vehicles(),NAString().my_guards(), NAString().notice_board(), NAString().settings(), NAString().help(), NAString().rate_us(), NAString().logout()]
    var mainScreen: MainScreenViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setting & Formatting Label Fonts
        lbl_Apartment.font = NAFont().labelFont()
        lbl_Flat.font = NAFont().textFieldFont()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! NavigationMenuTableViewCell
        cell.image_View.image = UIImage(named: sideMenuArray[indexPath.row])
        cell.labelView.text = sideMenuArray[indexPath.row]
        
        //Label formatting & setting
        cell.labelView.font = NAFont().textFieldFont()
        return cell
    }
    
    //Getting Data on Selecting Particular data of cell from the Index path.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as! NavigationMenuTableViewCell
        let currentItem = currentCell.labelView.text
        if currentItem == NAString().my_profile() {
            let myProfileVC = NAViewPresenter().myProfileVC()
            myProfileVC.navTitle = NAString().My_Profile()
            self.navigationController?.pushViewController(myProfileVC, animated: true)
        } else if currentItem == NAString().myWallet() {
            let myWalletVC = NAViewPresenter().myWalletVC()
            myWalletVC.navTitle = NAString().myWallet()
            self.navigationController?.pushViewController(myWalletVC, animated: true)
        } else if currentItem == NAString().my_family_members() {
            let dv = NAViewPresenter().mySweetHomeVC()
            dv.navTitle = NAString().my_sweet_home()
            dv.fromHomeScreenVC = true
            self.navigationController?.pushViewController(dv, animated: true)
        } else if currentItem == NAString().my_vehicles() {
            let dv1 = NAViewPresenter().myVehiclesVC()
            dv1.navTitle = NAString().my_vehicles()
            self.navigationController?.pushViewController(dv1, animated: true)
        } else if currentItem == NAString().my_guards() {
            let dv2 = NAViewPresenter().myGuardsVC()
            dv2.navTitle = NAString().my_guards()
            self.navigationController?.pushViewController(dv2, animated: true)
        } else if currentItem == NAString().help() {
            let dv3 = NAViewPresenter().helpVC()
            dv3.navTitle = NAString().help()
            self.navigationController?.pushViewController(dv3, animated: true)
        } else if currentItem == NAString().settings() {
            let dv4 = NAViewPresenter().settingVC()
            dv4.navTitle = NAString().settings()
            self.navigationController?.pushViewController(dv4, animated: true)
        } else if currentItem == NAString().logout() {
            self.logoutAction()
        } else if currentItem == NAString().rate_us() {
            /** calling 'showReviewView' method with desired launch counts needed. **/
            if #available(iOS 10.3, *) {
                //TODO: Need to pass some functionality in future, when we upload our app in App Store.
                RateUs().showReviewView(afterMinimumLaunchCount: 0)
            }
        } else if currentItem == NAString().notice_board() {
            let noticeBoardVC = NAViewPresenter().noticeBoardVC()
            noticeBoardVC.navTitle = NAString().notice_board()
            self.navigationController?.pushViewController(noticeBoardVC, animated: true)
        }
        mainScreen.opacity_View.isHidden = true
        mainScreen.closeNavigationMenu()
        tableView.deselectRow(at: indexPath!, animated: true)
    }
    //To Logout the current user
    @objc func logoutAction() {
        //Logout Confirmation Alert
        NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().logout_Confirmation_Title(), Message: NAString().logout_Confirmation_Message(), CancelStyle: .default, OkStyle: .destructive, OK: { (action) in
            let preferences = UserDefaults.standard
            let userUID = NAString().userDefault_USERUID()
            let loggedIn = NAString().userDefault_Logged_In()
            preferences.removeObject(forKey: userUID)
            preferences.set(false, forKey: loggedIn)
            preferences.synchronize()
            if self.storyboard != nil {
                let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
                let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().loginNavigation())
                self.present(NavLogin, animated: true)
            }
        }, Cancel: { (action) in}, cancelActionTitle: NAString().no(), okActionTitle: NAString().yes())
    }
}
