//
//  MainScreenViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import HCSStarRatingView

class MainScreenViewController: NANavigationViewController {
    
    @IBOutlet weak var segmentSelection: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideMenuConstrain : NSLayoutConstraint!
    
    @IBOutlet weak var opacity_View: UIView!
    var navigationMenuVC: NavigationMenuViewController!
    
    fileprivate var isSocietyServices = true
    var rateUsView: RateUsView!
    
    var NavigationMenuOpen = false
    
    var currentIndex = 0
    
    //Declaring the varibles for structure.
    var apartmentData:[apartmentServicesModel] = []
    var societyData:[societyServicesModel] = []
    
    var VCNamesSociety = [String]()
    var VCNamesApartment = [String]()
    
    var usersPrivateRef: DatabaseReference?
    
    /* - Created Menu Button on NavigationBar and Calling function for retreiving User Data on view load.
     - Formatting & Setting Segmented Controller and Calling Segment function.
     - Performing Navigation according to given Id, Setting & fromatting Navigation Bar.
     - assigning values in struct. */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opacity_View.isHidden = true
        tableView.alwaysBounceVertical = false
        navigationMenuVC.mainScreen = self
        
        let menuButton = UIButton(type: .system)
        menuButton.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        menuButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        menuButton.addTarget(self, action: #selector(NavigationMenuVC), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        /* Retrieve current Users UID*/
        self.retreiveUserUID()
        
        self.retrieveUserData()
        
        segmentSelection.layer.borderWidth = CGFloat(NAString().one())
        segmentSelection.layer.borderColor = UIColor.black.cgColor
        let normalTextAttributes: [NSObject : AnyObject] = [
            NSAttributedStringKey.foregroundColor as NSObject: UIColor.white,
            NSAttributedStringKey.font as NSObject: NAFont().descriptionFont()]
        self.segmentSelection?.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentSelection.selectedSegmentIndex = currentIndex
        self.segmentControlSelection()
        
        VCNamesSociety = [NAViewPresenter().digiGateVCID()]
        VCNamesApartment = [NAViewPresenter().homeVCID()]
        
        super.ConfigureNavBarTitle(title: NAString().splash_NammaHeader_Title())
        
        navigationItem.rightBarButtonItem = nil
        super.navigationItem.hidesBackButton = true
        
        societyData = [
            societyServicesModel(cellTitle: NAString().digital_gate(),cellImage:  #imageLiteral(resourceName: "Digital_Gate_2")),
            societyServicesModel(cellTitle: NAString().plumber(),cellImage:  #imageLiteral(resourceName: "plumbing (2)")),
            societyServicesModel(cellTitle: NAString().carpenter(),cellImage:  #imageLiteral(resourceName: "Carpenter Service")),
            societyServicesModel(cellTitle: NAString().electrician(),cellImage: #imageLiteral(resourceName: "switchBoard") ),
            societyServicesModel(cellTitle: NAString().garbage_management(),cellImage:  #imageLiteral(resourceName: "garbage-bin (2)")),
            societyServicesModel(cellTitle: NAString().medical_emergency(),cellImage:  #imageLiteral(resourceName: "Medical_Emergency_1")),
            societyServicesModel(cellTitle: NAString().event_management(),cellImage: #imageLiteral(resourceName: "event")),
            societyServicesModel(cellTitle: NAString().water_services(),cellImage: #imageLiteral(resourceName: "New waterTank") )
        ]
        apartmentData = [
            apartmentServicesModel(cellTitle: NAString().cook(), cellImage: #imageLiteral(resourceName: "cook_Service")),
            apartmentServicesModel(cellTitle: NAString().maid(),cellImage: #imageLiteral(resourceName: "maidServices") ),
            apartmentServicesModel(cellTitle: NAString().car_bike_cleaning(),cellImage:  #imageLiteral(resourceName: "carCleaning")),
            apartmentServicesModel(cellTitle: NAString().child_day_care(),cellImage:  #imageLiteral(resourceName: "Child_care_Services_2")),
            apartmentServicesModel(cellTitle: NAString().daily_newspaper(),cellImage:  #imageLiteral(resourceName: "newspaper")),
            apartmentServicesModel(cellTitle: NAString().milk_man(),cellImage:  #imageLiteral(resourceName: "milk")),
            apartmentServicesModel(cellTitle: NAString().laundry(),cellImage:  #imageLiteral(resourceName: "laundry_Service")),
            apartmentServicesModel(cellTitle: NAString().driver(),cellImage:  #imageLiteral(resourceName: "Newdriver")),
            apartmentServicesModel(cellTitle: NAString().groceries(), cellImage: #imageLiteral(resourceName: "groceries"))
        ]
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        opacity_View.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.opacity_View.addGestureRecognizer(tapGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let embeddedVC = segue.destination as? NavigationMenuViewController {
            navigationMenuVC = embeddedVC
        }
        
    }
    
    /* - For switching the tableview data in between society & apartment services.
     - Modifying SegmentControl text according to segment selection. */
    
    //To Logout the current user
    @objc func logout() {
        try! Auth.auth().signOut()
        if self.storyboard != nil {
            //print("Now string is Empty",Constants.userUIDPer)
            let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
            let NavLogin = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().loginNavigation())
            self.present(NavLogin, animated: true)
        }
    }
    
    /* - For switching the tableview data in between society & apartment services.
     - Modifying SegmentControl text according to segment selection. */
    
    @IBAction func segmentChangeServices(_ sender: UISegmentedControl) {
        self.segmentControlSelection()
        self.tableView.alwaysBounceVertical = false
        self.tableView.reloadData()
    }
    
    //For showing and closing Navigation menu
    @objc func NavigationMenuVC() {
        if self.NavigationMenuOpen {
            closeNavigationMenu()
            opacity_View.isHidden = true
        } else {
            showNavigationMenu()
        }
    }
    
    @objc func handleTap() {
        if self.NavigationMenuOpen {
            closeNavigationMenu()
            opacity_View.isHidden = true
        } else if rateUsView.isHidden == false {
            hidingRateUsView()
        }
    }
    
    func closeNavigationMenu() {
        self.NavigationMenuOpen = false
        UIView.animate(withDuration: 0.3) {
            self.sideMenuConstrain.constant = -260
            self.view.layoutIfNeeded()
        }
    }
    
    func showNavigationMenu() {
        self.NavigationMenuOpen = true
        opacity_View.isHidden = false
        if rateUsView != nil {
            rateUsView.isHidden = true
        }
        UIView.animate(withDuration: 0.3) {
            self.sideMenuConstrain.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    //Function to show Rate Us View.
    func showingRateUsView() {
        rateUsView = RateUsView(frame: CGRect(x: 0, y: 0, width: 230, height: 304))
        rateUsView.center.x = self.view.bounds.width/2
        rateUsView.center.y = self.view.bounds.height/2
        rateUsView.btn_Rate_Now.titleLabel?.font = NAFont().buttonFont()
        rateUsView.btn_Remind_me_Later.titleLabel?.font = NAFont().buttonFont()
        rateUsView.btn_Rate_Now.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        rateUsView.btn_Remind_me_Later.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        rateUsView.btn_Rate_Now.backgroundColor = NAColor().buttonBgColor()
        rateUsView.btn_Rate_Now.backgroundColor = NAColor().buttonBgColor()
        rateUsView.layer.cornerRadius = 10
        rateUsView.layer.masksToBounds = true
        
        //Customized Code for Star rating
        let starRatingView: HCSStarRatingView = HCSStarRatingView()
        starRatingView.maximumValue = 5
        starRatingView.minimumValue = 0
        starRatingView.value = 1
        starRatingView.tintColor = UIColor.yellow
        starRatingView.allowsHalfStars = false
        starRatingView.emptyStarImage = UIImage(named: "EmptyStar")?.withRenderingMode(.alwaysTemplate)
        starRatingView.filledStarImage = UIImage(named: "FullStar")?.withRenderingMode(.alwaysTemplate)
        starRatingView.center = self.view.center
        rateUsView.view.addSubview(starRatingView)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(rateUsView)
    }
    
    func hidingRateUsView() {
        opacity_View.isHidden = true
        rateUsView.isHidden = true
    }
    
    func segmentControlSelection() {
        self.segmentSelection?.tintColor = UIColor.black
        self.segmentSelection?.backgroundColor = UIColor.black
        let selectedAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.segmentSelection?.setTitleTextAttributes(selectedAttributes, for: .selected)
        let selectedTextAttributes: [NSObject : AnyObject] = [
            NSAttributedStringKey.foregroundColor as NSObject: UIColor.white,
            NSAttributedStringKey.font as NSObject: NAFont().descriptionFont()]
        self.segmentSelection?.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        let normalAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray]
        self.segmentSelection?.setTitleTextAttributes(normalAttributes, for: .normal)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                showNavigationMenu()
            case UISwipeGestureRecognizerDirection.left:
                closeNavigationMenu()
                opacity_View.isHidden = true
                if rateUsView != nil {
                    rateUsView.isHidden = true
                }
            default:
                break
            }
        }
    }
}

extension MainScreenViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Modifying tableview data according to segment selection.
        var value = 0
        switch segmentSelection.selectedSegmentIndex {
        case 0:
            value = societyData.count
            break
        case 1:
            value = apartmentData.count
            break
        default:
            break
        }
        return value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! MainScreenTableViewCell
        //Selection Process.
        switch segmentSelection.selectedSegmentIndex {
        case 0:
            cell.cellTitle.text = societyData[indexPath.row].cellTitle
            cell.cellImage.image = societyData[indexPath.row].cellImage
            break
        case 1:
            cell.cellTitle.text = apartmentData[indexPath.row].cellTitle
            cell.cellImage.image = apartmentData[indexPath.row].cellImage
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //For Navigation Purpose.
        let destVC = currentIndex == 0 ? VCNamesSociety[0]: VCNamesApartment[0]
        let viewController = storyboard?.instantiateViewController(withIdentifier: destVC)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}

extension MainScreenViewController {
    
    func retreiveUserUID() {
        let preferences = UserDefaults.standard
        let currentLevelKey = "USERUID"
        if preferences.object(forKey: currentLevelKey) == nil {
            preferences.set(Auth.auth().currentUser?.uid, forKey: currentLevelKey)
        }
        userUID = (preferences.object(forKey: currentLevelKey) as! String)
        preferences.synchronize()
    }
    
    //Retrieving User's Data from firebase
    func retrieveUserData() {
        
        //Checking Users UID in Firebase under Users ->Private
        usersPrivateRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID)
        
        //Checking userData inside Users/Private
        
        self.usersPrivateRef?.observeSingleEvent(of: .value, with: { snapshot in
            
            //If usersUID is Exists then retrievd all the data of user.
            if snapshot.exists() {
                
                let userData = snapshot.value as? NSDictionary
                print("UserData:",userData as Any)
                
                //Retrieving & Adding data in Flat Detail Class
                let flatdetails_data = userData![Constants.FIREBASE_CHILD_FLATDETAILS] as? [String :Any]
                
                flatDetailsFB.append(FlatDetails.init(
                    apartmentName: flatdetails_data![Constants.FIREBASE_CHILD_APARTMENT_NAME] as? String,
                    city: (flatdetails_data![Constants.FIREBASE_CHILD_CITY] as! String),
                    flatNumber: flatdetails_data![Constants.FIREBASE_CHILD_FLATNUMBER] as? String,
                    societyName: flatdetails_data![Constants.FIREBASE_CHILD_SOCIETY_NAME] as? String,
                    tenantType: flatdetails_data![Constants.FIREBASE_CHILD_TENANT_TYPE] as? String))
                
                GlobalUserData.shared.flatDetails_Items = flatDetailsFB
                
                //Retrieving & Adding Data in Personal Detail Class
                let userPersonal_data = userData![Constants.FIREBASE_CHILD_PERSONALDETAILS] as? [String :Any]
                
                personalDetails.append(PersonalDetails.init(email: userPersonal_data![Constants.FIREBASE_CHILD_EMAIL] as? String, fullName:userPersonal_data![Constants.FIREBASE_CHILD_FULLNAME] as? String , phoneNumber:userPersonal_data![Constants.FIREBASE_CHILD_PHONENUMBER] as? String ))
                
                GlobalUserData.shared.personalDetails_Items = personalDetails
                
                //Retriving & Adding data in Privileges
                let privilage_data = userData![Constants.FIREBASE_CHILD_PRIVILEGES] as? [String : Any]
                
                userprivileges.append(UserPrivileges.init(admin: privilage_data![Constants.FIREBASE_CHILD_ADMIN]as? String, grantAccess: privilage_data![Constants.FIREBASE_CHILD_GRANTACCESS] as? String, verified: privilage_data![Constants.FIREBASE_CHILD_VERIFIED] as? String ))
                
                GlobalUserData.shared.privileges_Items = userprivileges
            }
        })
    }
}