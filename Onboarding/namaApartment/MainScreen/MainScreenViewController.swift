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

class MainScreenViewController: NANavigationViewController
{
    @IBOutlet weak var segmentSelection: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
   
    fileprivate var isSocietyServices = true
    
    var currentIndex = 0
    
    //Declaring the varibles for structure.
    var apartmentData:[apartmentServicesModel] = []
    var societyData:[societyServicesModel] = []
    
    //for navigation purpose
    var VCNamesSociety = [String]()
    var VCNamesApartment = [String]()
    
    //Firebase Database References
    var usersPrivateRef: DatabaseReference?
    var userFlatRef : DatabaseReference?
    var userPersonalRef : DatabaseReference?
    var userPrivilegesRef : DatabaseReference?
    var isMobileValidRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MY UID IS :", userUID as Any)
       print("View will Appear")
//        //calling retreiving function
        self.retrieveUserData()
        
        //Formatting & Setting Segmented Controller.
        segmentSelection.layer.borderWidth = CGFloat(NAString().one())
        segmentSelection.layer.borderColor = UIColor.black.cgColor
        
        segmentSelection.selectedSegmentIndex = currentIndex
        
       //For navigation purpose.
        VCNamesSociety = [NAViewPresenter().digiGateVCID()]
        VCNamesApartment = [NAViewPresenter().homeVCID()]
        
       //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().splash_NammaHeader_Title())
        navigationItem.rightBarButtonItem = nil
        super.navigationItem.hidesBackButton = true
     
    //assigning values in struct
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
    }
    //For switching the tableview data in between society & apartment services.
    @IBAction func segmentChangeServices(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
//        print("View will Appear")
//        //calling retreiving function
//        self.retrieveUserData()
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
    
    //Retrieving User's Data from firebase
    func retrieveUserData() {
        
        //Checking Users UID in Firebase under Users ->Private
          usersPrivateRef = Database.database().reference().child(Constants.FIREBASE_USER).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(userUID!)
        
        //Checking userData inside Users/Private
        
          self.usersPrivateRef?.observeSingleEvent(of: .value, with: { snapshot in
            
            //If usersUID is Exists then retrievd all the data of user.
            if snapshot.exists() {
                
                    let userData = snapshot.value as? NSDictionary
                    print("UserData:",userData as Any)
                    
                    //Retrieving & Adding data in Flat Detail Class
                    let flatdetails_data = userData![Constants.FIREBASE_CHILD_FLATDETAILS] as? [String :Any]
                    
                    flatDetailsFB.append(FlatDetails.init(apartmentName: flatdetails_data![Constants.FIREBASE_CHILD_APARTMENT_NAME] as? String, city: (flatdetails_data![Constants.FIREBASE_CHILD_CITY] as! String), flatNumber: flatdetails_data![Constants.FIREBASE_CHILD_FLATNUMBER] as? String, societyName: flatdetails_data![Constants.FIREBASE_CHILD_SOCIETY_NAME] as? String, tenantType: flatdetails_data![Constants.FIREBASE_CHILD_TENANT_TYPE] as? String))
                    
                    Singleton_FlatDetails.shared.flatDetails_Items = flatDetailsFB
                    
                    //Retrieving & Adding Data in Personal Detail Class
                    let userPersonal_data = userData![Constants.FIREBASE_CHILD_PERSONALDETAILS] as? [String :Any]
                    
                    personalDetails.append(PersonalDetails.init(email: userPersonal_data![Constants.FIREBASE_CHILD_EMAIL] as? String, fullName:userPersonal_data![Constants.FIREBASE_CHILD_FULLNAME] as? String , phoneNumber:userPersonal_data![Constants.FIREBASE_CHILD_PHONENUMBER] as? String ))
                    
                    Singleton_PersonalDetails.shared.personalDetails_Items = personalDetails
                    
                    //Retriving & Adding data in Privileges
                    let privilage_data = userData![Constants.FIREBASE_CHILD_PRIVILEGES] as? [String : Any]
                    
                    userprivileges.append(UserPrivileges.init(admin: privilage_data![Constants.FIREBASE_CHILD_ADMIN]as? String, grantAccess: privilage_data![Constants.FIREBASE_CHILD_GRANTACCESS] as? String, verified: privilage_data![Constants.FIREBASE_CHILD_VERIFIED] as? String ))
                
                Singleton_privileges.shared.privileges_Items = userprivileges
                
                //Storing Visitor UID under UsersData -> UsersFlat
                let value =  Singleton_FlatDetails.shared.flatDetails_Items
                let val = value.first
                print(val?.apartmentName as Any)
                print(val?.city as Any)
                print(val?.societyName as Any)
                print(val?.flatNumber as Any)
                print(val?.tenantType as Any)
                
            }
          })
    }
}





