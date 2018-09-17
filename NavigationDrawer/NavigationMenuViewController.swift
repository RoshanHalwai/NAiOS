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
    
    var sideMenuArray = [NAString().My_Profile(), NAString().my_family_members(),NAString().my_vehicles(),NAString().my_guards(), NAString().payments(),NAString().donateFood(), NAString().notice_board(), NAString().settings(), NAString().help(), NAString().rate_us()]
    
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
        
        switch indexPath.row {
            
        case 0 :
            let myProfileVC = NAViewPresenter().myProfileVC()
            myProfileVC.navTitle = NAString().My_Profile()
            self.navigationController?.pushViewController(myProfileVC, animated: true)
        case 1 :
            let dv = NAViewPresenter().mySweetHomeVC()
            dv.navTitle = NAString().my_sweet_home()
            dv.fromHomeScreenVC = true
            self.navigationController?.pushViewController(dv, animated: true)
        case 2 :
            let dv1 = NAViewPresenter().myVehiclesVC()
            dv1.navTitle = NAString().my_vehicles()
            self.navigationController?.pushViewController(dv1, animated: true)
        case 3 :
            let dv2 = NAViewPresenter().myGuardsVC()
            dv2.navTitle = NAString().my_guards()
            self.navigationController?.pushViewController(dv2, animated: true)
        case 4 :
            let myWalletVC = NAViewPresenter().myWalletVC()
            myWalletVC.navTitle = NAString().payments()
            self.navigationController?.pushViewController(myWalletVC, animated: true)
        case 5 :
            let myFoodVC = NAViewPresenter().myFoodVC()
            myFoodVC.navTitle = NAString().donateFood()
            self.navigationController?.pushViewController(myFoodVC, animated: true)
        case 6 :
            let noticeBoardVC = NAViewPresenter().noticeBoardVC()
            self.navigationController?.pushViewController(noticeBoardVC, animated: true)
        case 7 :
            let dv4 = NAViewPresenter().settingVC()
            dv4.navTitle = NAString().settings()
            self.navigationController?.pushViewController(dv4, animated: true)
        case 8 :
            let dv3 = NAViewPresenter().helpVC()
            dv3.navTitle = NAString().help()
            self.navigationController?.pushViewController(dv3, animated: true)
        case 9 :
            /** calling 'showReviewView' method with desired launch counts needed. **/
            if #available(iOS 10.3, *) {
                //TODO: Need to pass some functionality in future, when we upload our app in App Store.
                RateUs().showReviewView(afterMinimumLaunchCount: 0)
            }
        default:
            break
        }
        mainScreen.opacity_View.isHidden = true
        mainScreen.closeNavigationMenu()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
