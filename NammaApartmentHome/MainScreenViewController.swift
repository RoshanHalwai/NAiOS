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
import FirebaseMessaging

class MainScreenViewController: NANavigationViewController {
    
    @IBOutlet weak var segmentSelection: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideMenuConstrain : NSLayoutConstraint!
    
    @IBOutlet weak var opacity_View: UIView!
    var navigationMenuVC: NavigationMenuViewController!
    
    fileprivate var isSocietyServices = true
    
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
            societyServicesModel(cellTitle: NAString().event_management(),cellImage: #imageLiteral(resourceName: "event"))
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
        UIView.animate(withDuration: 0.3) {
            self.sideMenuConstrain.constant = 0
            self.view.layoutIfNeeded()
        }
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
        
        switch segmentSelection.selectedSegmentIndex {
        case 0:
            switch indexPath.row {
            case 0:
                let lv = NAViewPresenter().digiGateVC()
                self.navigationController?.pushViewController(lv, animated: true)
                
            case 1:
                let lv1 = NAViewPresenter().societyServiceVC()
                lv1.navTitle = NAString().plumber()
                getInProgressUID(VC: lv1, titleName: NAString().plumber().lowercased())
                
            case 2:
                let lv2 = NAViewPresenter().societyServiceVC()
                lv2.navTitle = NAString().carpenter()
                getInProgressUID(VC: lv2, titleName: NAString().carpenter().lowercased())
                
            case 3:
                let lv3 = NAViewPresenter().societyServiceVC()
                lv3.navTitle = NAString().electrician()
                getInProgressUID(VC: lv3, titleName: NAString().electrician().lowercased())
                
            case 4:
                let lv4 = NAViewPresenter().societyServiceVC()
                lv4.navTitle = NAString().garbage_management()
                getInProgressUID(VC: lv4, titleName: NAString().garbageManagement())
                
            case 5:
                let lv5 = NAViewPresenter().raiseAlarmVC()
                lv5.titleName = NAString().medical_emergency()
                self.navigationController?.pushViewController(lv5, animated: true)
                
            case 6:
                let lv6 = NAViewPresenter().addEventManagementVC()
                lv6.navTitle = NAString().event_management()
                getInProgressUID(VC: lv6, titleName: NAString().eventManagement())
            default:
                break
            }
            
        case 1 :
            switch indexPath.row {
            case 0:
                let lv = NAViewPresenter().apartmentServiceCookVC()
                lv.titleName = NAString().cook()
                self.navigationController?.pushViewController(lv, animated: true)
            case 1:
                let maidVC = NAViewPresenter().apartmentServiceCookVC()
                maidVC.titleName = NAString().maid()
                self.navigationController?.pushViewController(maidVC, animated: true)
            case 2:
                let carBikeVC = NAViewPresenter().apartmentServiceCookVC()
                carBikeVC.titleName = NAString().car_bike_cleaning()
                self.navigationController?.pushViewController(carBikeVC, animated: true)
            case 3:
                let childDayCareVC = NAViewPresenter().apartmentServiceCookVC()
                childDayCareVC.titleName = NAString().child_day_care()
                self.navigationController?.pushViewController(childDayCareVC, animated: true)
            case 4:
                let dailyNewsPaperVC = NAViewPresenter().apartmentServiceCookVC()
                dailyNewsPaperVC.titleName = NAString().daily_newspaper()
                self.navigationController?.pushViewController(dailyNewsPaperVC, animated: true)
            case 5:
                let milkManVC = NAViewPresenter().apartmentServiceCookVC()
                milkManVC.titleName = NAString().milk_man()
                self.navigationController?.pushViewController(milkManVC, animated: true)
            case 6:
                let laundryVC = NAViewPresenter().apartmentServiceCookVC()
                laundryVC.titleName = NAString().laundry()
                self.navigationController?.pushViewController(laundryVC, animated: true)
            case 7:
                let driverVC = NAViewPresenter().apartmentServiceCookVC()
                driverVC.titleName = NAString().driver()
                self.navigationController?.pushViewController(driverVC, animated: true)
                
            default:
                break
            }
            
        default:
            break
        }
    }
    
    //Checking the user Request whether it is in-Progress or Completed
    func getInProgressUID(VC : UIViewController, titleName: String) {
        let userDataReference = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
        
        userDataReference.observeSingleEvent(of: .value) { (serviceSnapshot) in
            if serviceSnapshot.exists() {
                userDataReference.child(titleName).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        var count = 0
                        let allUIDMap = snapshot.value as! NSDictionary
                        var allUIDArray = [String]()
                        for uid in allUIDMap.allKeys {
                            count = count + 1
                            allUIDArray.append(uid as! String)
                            
                            if count == allUIDMap.count {
                                //getting last UID from the Array
                                let lastUID = allUIDArray.last
                                let serviceNotificationRef = Database.database().reference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(Constants.FIREBASE_USER_CHILD_ALL).child(lastUID!)
                                
                                serviceNotificationRef.observeSingleEvent(of: .value, with: { (dataSnapshot) in
                                    let dataMap = dataSnapshot.value as! [String: AnyObject]
                                    
                                    let status: String = dataMap[NASocietyServicesFBKeys.status.key] as! String
                                    
                                    /* If the Status is in Progress we are Allowing user to awaiting response Screen else allowing user to Request one more service. */
                                    if status == NAString().in_Progress() {
                                        let awaitingResponseVC = NAViewPresenter().societyServiceDataVC()
                                        awaitingResponseVC.navTitle = NAString().societyService()
                                        awaitingResponseVC.notificationUID = lastUID!
                                        if titleName == NAString().eventManagement() {
                                            let lv = NAViewPresenter().showEventManagementVC()
                                            lv.getEventUID = lastUID!
                                            lv.navTitle = NAString().event_management()
                                            self.navigationController?.pushViewController(lv, animated: true)
                                        } else {
                                            self.navigationController?.pushViewController(awaitingResponseVC, animated: true)
                                        }
                                    } else {
                                        self.navigationController?.pushViewController(VC, animated: true)
                                    }
                                })
                            }
                        }
                    } else {
                        self.navigationController?.pushViewController(VC, animated: true)
                    }
                })
            } else {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
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
        
        //Created Token ID & Storing in Firebase
        let token = Messaging.messaging().fcmToken
        
        var usersTokenRef : DatabaseReference?
        usersTokenRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID)
        usersTokenRef?.child(NAUser.NAUserStruct.tokenId).setValue(token)
        
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
                let userFlatDetails = UserFlatDetails.init(
                    apartmentName: flatdetails_data![Constants.FIREBASE_CHILD_APARTMENT_NAME] as? String,
                    city: (flatdetails_data![Constants.FIREBASE_CHILD_CITY] as! String),
                    flatNumber: flatdetails_data![Constants.FIREBASE_CHILD_FLATNUMBER] as? String,
                    societyName: flatdetails_data![Constants.FIREBASE_CHILD_SOCIETY_NAME] as? String,
                    tenantType: flatdetails_data![Constants.FIREBASE_CHILD_TENANT_TYPE] as? String)
                
                flatDetailsFB.append(userFlatDetails)
                
                GlobalUserData.shared.flatDetails_Items = flatDetailsFB
                
                //Retrieving Navigation Data in Header
                let societyName = GlobalUserData.shared.flatDetails_Items.first?.getsocietyName()
                let apartmentName = GlobalUserData.shared.flatDetails_Items.first?.getapartmentName()
                let flatNumber = GlobalUserData.shared.flatDetails_Items.first?.getflatNumber()
                
                self.navigationMenuVC.lbl_Apartment.text = societyName
                self.navigationMenuVC.lbl_Flat.text = apartmentName! + "," + " " + flatNumber!
                
                //Retrieving & Adding Data in UserPersonalDetails class
                let userPersonal_data = userData![Constants.FIREBASE_CHILD_PERSONALDETAILS] as? [String :Any]
                let userPersonalDetails = UserPersonalDetails.init(email: userPersonal_data![Constants.FIREBASE_CHILD_EMAIL] as? String, fullName:userPersonal_data![Constants.FIREBASE_CHILD_FULLNAME] as? String , phoneNumber:userPersonal_data![Constants.FIREBASE_CHILD_PHONENUMBER] as? String, profilePhoto: userPersonal_data![Constants.FIREBASE_CHILD_PERSONALDETAILS_PROFILEIMAGE] as? String)
                personalDetails.append(userPersonalDetails)
                GlobalUserData.shared.personalDetails_Items = personalDetails
                
                //Retriving & Adding data in Privileges
                let privilage_data = userData![Constants.FIREBASE_CHILD_PRIVILEGES] as? [String : Any]
                let userPrivileges = UserPrivileges.init(admin: privilage_data![Constants.FIREBASE_CHILD_ADMIN]as? Bool, grantAccess: privilage_data![Constants.FIREBASE_CHILD_GRANTACCESS] as? Bool, verified: privilage_data![Constants.FIREBASE_CHILD_VERIFIED] as? Bool )
                userprivileges.append(userPrivileges)
                GlobalUserData.shared.privileges_Items = userprivileges
                
                //Retriving & Adding data in Family Members
                let familyMembers_data = userData![Constants.FIREBASE_CHILD_FAMILY_MEMBERS] as? NSDictionary
                var familyMembersUIDList = [String]()
                if (familyMembers_data != nil) {
                    for familyMemberUID in (familyMembers_data?.allKeys)! {
                        familyMembersUIDList.append(familyMemberUID as! String)
                    }
                }
                
                //Retriving & Adding data in Friends
                let friends_data = userData![Constants.FIREBASE_CHILD_FRIENDS] as? NSDictionary
                var friendsUIDList = [String]()
                if (friends_data != nil) {
                    for friendsUID in (friends_data?.allKeys)! {
                        friendsUIDList.append(friendsUID as! String)
                    }
                }
                
                let nammaApartmentUser = NAUser.init(uid: userUID, flatDetails: userFlatDetails, personalDetails: userPersonalDetails, privileges: userPrivileges, familyMembers: familyMembersUIDList, friends:friendsUIDList)
                GlobalUserData.shared.setNammaApartmentUser(nammaApartmentUser: nammaApartmentUser)
                
            }
        })
    }
}
