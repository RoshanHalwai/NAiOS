//
//  CabAndPackageArrivalCardListViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 14/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CabAndPackageArrivalCardListViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection_View: UICollectionView!
    
    var navTitle = String()
    
    //A boolean variable to indicate if previous screen was Expecting Arrival.
    var fromExpectingArrivalVC = false
    
    //Assigning Strings according to title
    var vendorCabNameString: String?
    var vendorCabImage: UIImage?
    
    //Database References
    var userDataRef : DatabaseReference?
    var cabsPublicRef : DatabaseReference?
    var packagePublicRef : DatabaseReference?
    
    var myExpectedCabList = [NAExpectingArrival]()
    var myExpectedPackageList = [NAExpectingArrival]()
    
    /*  Created custom back button for navigating back to My DigiGate VC Based on Screen Coming From.
     Formatting & setting navigation bar. */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeLblTitle()
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.title = ""
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToDigiGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        //info Button Action
        infoButton()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 150)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collection_View!.collectionViewLayout = layout
    }
    
    //For navigating back to My Digi Gate VC
    @objc func goBackToDigiGate() {
        if fromExpectingArrivalVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-4]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //Changing label titles in based on Navigation title
    func changeLblTitle() {
        if navTitle == NAString().cab_arrival() {
            vendorCabNameString = NAString().cab_no()
            vendorCabImage = #imageLiteral(resourceName: "ExpectingCabs")
            checkAndRetrieveCabArrivals()
        } else if navTitle == NAString().package_arrival() {
            vendorCabNameString = NAString().vendor()
            vendorCabImage = #imageLiteral(resourceName: "ExpectingPackage")
            checkAndRetrievePackageArrivals()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if navTitle == NAString().cab_arrival() {
            return myExpectedCabList.count
        } else {
            return myExpectedPackageList.count
        }
    }
    
    /*  Loading Expected Package & Cab Data.
     Getting users Flat Details Form Singaltone class. */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! CabAndPackageArrivalCardListCollectionViewCell
        
        if navTitle == NAString().cab_arrival() {
            let myCabList : NAExpectingArrival
            myCabList = myExpectedCabList[indexPath.row]
            
            var dateTimeString : String
            dateTimeString = myCabList.getdateAndTimeOfArrival()
            let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t ")
            let dateString: String = arrayOfDateTime[0]
            let timeString: String = arrayOfDateTime[1]
            
            cell.lbl_CabNo_Detail.text = myCabList.getreference()
            cell.lbl_Status_Detail.text = myCabList.getstatus()
            cell.lbl_InTime_Detail.text = timeString
            cell.lbl_Date_Detail.text = dateString
            
            if(myCabList.getInviterUID() == userUID) {
                cell.lbl_Inviter_Detail.text = GlobalUserData.shared.personalDetails_Items.first?.fullName
            } else {
                let inviterNameRef = Constants.FIREBASE_USERS_PRIVATE.child(myCabList.getInviterUID())
                
                inviterNameRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
                    let usersData = userDataSnapshot.value as? [String: AnyObject]
                    let userPersonalDataMap = usersData?["personalDetails"] as? [String: AnyObject]
                    let fullName = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
                    cell.lbl_Inviter_Detail.text = fullName
                })
            }
            
            //Setting Label Invitor text based on Firebase Approved Type
            if  myCabList.getapprovalType() == Constants.FIREBASE_CHILD_POST_APPROVED {
                cell.lbl_Inviter_Type.text = NAString().approver()
            } else if myCabList.getapprovalType() == Constants.FIREBASE_CHILD_GUARD_APPROVED {
                cell.lbl_Inviter_Type.text = NAString().approver()
                cell.lbl_Inviter_Detail.text = NAString().guard_Nmae()
            } else if myCabList.getapprovalType() == Constants.FIREBASE_CHILD_PRE_APPROVED {
                cell.lbl_Inviter_Type.text = NAString().inviter()
            }
            
        } else {
            let myPackageList : NAExpectingArrival
            myPackageList = myExpectedPackageList[indexPath.row]
            
            var dateTimeString : String
            dateTimeString = myPackageList.getdateAndTimeOfArrival()
            let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t ")
            let dateString: String = arrayOfDateTime[0]
            let timeString: String = arrayOfDateTime[1]
            
            cell.lbl_CabNo_Detail.text = myPackageList.getreference()
            cell.lbl_Status_Detail.text = myPackageList.getstatus()
            cell.lbl_InTime_Detail.text = timeString
            cell.lbl_Date_Detail.text = dateString
            
            if(myPackageList.getInviterUID() == userUID) {
                cell.lbl_Inviter_Detail.text = GlobalUserData.shared.personalDetails_Items.first?.fullName
            } else {
                let inviterNameRef = Constants.FIREBASE_USERS_PRIVATE.child(myPackageList.getInviterUID())
                
                inviterNameRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
                    let usersData = userDataSnapshot.value as? [String: AnyObject]
                    let userPersonalDataMap = usersData?["personalDetails"] as? [String: AnyObject]
                    let fullName = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
                    print(fullName as Any)
                    cell.lbl_Inviter_Detail.text = fullName
                })
            }
            
            //Setting Label Invitor text based on Firebase Approved Type
            if  myPackageList.getapprovalType() == Constants.FIREBASE_CHILD_POST_APPROVED {
                cell.lbl_Inviter_Type.text = NAString().approver()
            } else if myPackageList.getapprovalType() == Constants.FIREBASE_CHILD_GUARD_APPROVED {
                cell.lbl_Inviter_Type.text = NAString().approver()
                cell.lbl_Inviter_Detail.text = NAString().guard_Nmae()
            } else if myPackageList.getapprovalType() == Constants.FIREBASE_CHILD_PRE_APPROVED {
                cell.lbl_Inviter_Type.text = NAString().inviter()
            }
        }
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //assigning font & style to cell labels
        cell.lbl_CabNo_Type.font = NAFont().textFieldFont()
        cell.lbl_Date_Type.font = NAFont().textFieldFont()
        cell.lbl_InTime_Type.font = NAFont().textFieldFont()
        cell.lbl_Status_Type.font = NAFont().textFieldFont()
        cell.lbl_Inviter_Type.font = NAFont().textFieldFont()
        
        cell.lbl_CabNo_Detail.font = NAFont().headerFont()
        cell.lbl_Date_Detail.font = NAFont().headerFont()
        cell.lbl_InTime_Detail.font = NAFont().headerFont()
        cell.lbl_Status_Detail.font = NAFont().headerFont()
        cell.lbl_Inviter_Detail.font = NAFont().headerFont()
        
        //assigning title to cell Labels
        cell.lbl_Date_Type.text = NAString().date()
        cell.lbl_InTime_Type.text = NAString().pick_time()
        cell.lbl_Status_Type.text = NAString().Status()
        
        /*Setting round image*/
        cell.image_View.layer.cornerRadius = cell.image_View.frame.size.width/2
        cell.image_View.clipsToBounds = true
        
        //Assigning Strings to the label tile according to Navigation Title
        cell.lbl_CabNo_Type.text = vendorCabNameString
        
        //Assigning Images to the Image View according to Navigation Title
        cell.image_View.image = vendorCabImage
        return cell
    }
}

/* Creating Function to get Expecting Cab Arrival Data from Firebase.
 Getting users Flat Details Form Singleton class.
 Hiding Activity Indicator & showing error image & message. */

extension CabAndPackageArrivalCardListViewController {
    
    func expectingCabArrival(userUID : String) {
        
        userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_CABS).child(userUID)
        userDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                let cabsUID = snapshot.value as? NSDictionary
                
                var cabUIDArray = [String]()
                //Getting all Cab UID's in Empty Array
                cabUIDArray = cabsUID?.allKeys as! [String]
                //sorting UID's
                let sortedArray = cabUIDArray.sorted()
                //Reversing the Array order to make sure that Latest Request Data should be on the top in the List
                let reversedArray = sortedArray.reversed()
                for cabsUID in reversedArray {
                    self.cabsPublicRef = Constants.FIREBASE_CABS_PRIVATE.child(cabsUID)
                    self.cabsPublicRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.exists() {
                            
                            let cabData = snapshot.value as?[String: AnyObject]
                            let approvalType = cabData?[ExpectingArrivalListFBKeys.approvalType.key] as? String
                            let dateAndTimeOfArrival = cabData?[ExpectingArrivalListFBKeys.dateAndTimeOfArrival.key] as? String
                            let reference = cabData?[ExpectingArrivalListFBKeys.reference.key] as? String?
                            let inviterUID = cabData?[ExpectingArrivalListFBKeys.inviterUID.key] as? String?
                            let status = cabData?[ExpectingArrivalListFBKeys.status.key] as? String?
                            let cabDetails = NAExpectingArrival(approvalType: approvalType,dateAndTimeOfArrival: dateAndTimeOfArrival, reference: reference!, status: status!, inviterUID: inviterUID!)
                            self.myExpectedCabList.append(cabDetails)
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.collection_View.reloadData()
                        }
                    })
                }
            }
        })
    }
    
    //Retriving Expecting cab data for both family & friends
    func checkAndRetrieveCabArrivals() {
        var friend = [String]()
        friend = GlobalUserData.shared.getNammaApartmentUser().getFriends()
        let cabRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_CABS)
        cabRef.observeSingleEvent(of: .value, with: { (snapshotCab) in
            var isFlatMemberKeys = false
            if !(snapshotCab.exists()) {
                self.displayCabErrorMessage()
            } else {
                let userUIDRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_FAMILY_MEMBERS)
                userUIDRef.observe(.value, with: { (snapshot) in
                    if snapshot.exists() {
                        self.myExpectedCabList.removeAll()
                        self.expectingCabArrival(userUID: userUID)
                        
                        var familyMembers = [String]()
                        familyMembers = GlobalUserData.shared.getNammaApartmentUser().getFamilyMembers()
                        
                        for familyMembersUID in familyMembers {
                            self.expectingCabArrival(userUID: familyMembersUID)
                            if let flatMembersUID = snapshotCab.value as? [String: Any] {
                                let flatMembersUIDKeys = Array(flatMembersUID.keys)
                                for friendUID in friend {
                                    for flatMemberUIDKey in flatMembersUIDKeys {
                                        if flatMemberUIDKey == familyMembersUID || flatMemberUIDKey == userUID || flatMemberUIDKey == friendUID {
                                            isFlatMemberKeys = true
                                        } else if (isFlatMemberKeys == false){
                                            self.displayCabErrorMessage()
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        self.expectingCabArrival(userUID: userUID)
                        if let flatMembersUID = snapshotCab.value as? [String: Any] {
                            let flatMembersUIDKeys = Array(flatMembersUID.keys)
                            for flatMemberUIDKey in flatMembersUIDKeys {
                                if flatMemberUIDKey == userUID {
                                    isFlatMemberKeys = true
                                } else if (isFlatMemberKeys == false)  {
                                    self.displayCabErrorMessage()
                                }
                            }
                        }
                    }
                })
            }
        })
    }
    
    //Creating Function to get Expecting Package Arrival Data from Firebase.
    func expectingPackageArrival(userUID : String)  {
        
        userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DELIVERIES).child(userUID)
        userDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                let packageUID = snapshot.value as? NSDictionary
                
                var packageUIDArray = [String]()
                //Getting all Package UID's in Empty Array
                packageUIDArray = packageUID?.allKeys as! [String]
                //sorting UID's
                let sortedArray = packageUIDArray.sorted()
                //Reversing the Array order to make sure that Latest Request Data should be on the top in the List
                let reversedArray = sortedArray.reversed()
                for vendorUID in reversedArray {
                    self.packagePublicRef = Constants.FIREBASE_DELIVERIES_PRIVATE.child(vendorUID)
                    self.packagePublicRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.exists() {
                            
                            let packageData = snapshot.value as?[String: AnyObject]
                            let approvalType = packageData?[ExpectingArrivalListFBKeys.approvalType.key] as? String
                            let dateAndTimeOfArrival = packageData?[ExpectingArrivalListFBKeys.dateAndTimeOfArrival.key] as? String
                            let reference = packageData?[ExpectingArrivalListFBKeys.reference.key] as? String?
                            let inviterUID = packageData?[ExpectingArrivalListFBKeys.inviterUID.key] as? String?
                            let status = packageData?[ExpectingArrivalListFBKeys.status.key] as? String?
                            
                            let packageDetails = NAExpectingArrival(approvalType: approvalType,dateAndTimeOfArrival: dateAndTimeOfArrival!, reference: reference!, status: status!, inviterUID: inviterUID!)
                            self.myExpectedPackageList.append(packageDetails)
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.collection_View.reloadData()
                        }
                    })
                }
            }
        })
    }
    
    //Retriving Expecting Package data for both family & friends
    func checkAndRetrievePackageArrivals() {
        var friend = [String]()
        friend = GlobalUserData.shared.getNammaApartmentUser().getFriends()
        let cabRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DELIVERIES)
        cabRef.observeSingleEvent(of: .value, with: { (snapshotCab) in
            var isFlatMemberKeys = false
            if !(snapshotCab.exists()) {
                self.displayPackageErrorMessage()
            } else {
                let userUIDRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_FAMILY_MEMBERS)
                userUIDRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        self.expectingPackageArrival(userUID: userUID)
                        
                        var familyMembers = [String]()
                        familyMembers = GlobalUserData.shared.getNammaApartmentUser().getFamilyMembers()
                        
                        for familyMembersUID in familyMembers {
                            self.expectingPackageArrival(userUID: familyMembersUID)
                            if let flatMembersUID = snapshotCab.value as? [String: Any] {
                                let flatMembersUIDKeys = Array(flatMembersUID.keys)
                                for friendUID in friend {
                                    for flatMemberUIDKey in flatMembersUIDKeys {
                                        if flatMemberUIDKey == familyMembersUID || flatMemberUIDKey == userUID || flatMemberUIDKey == friendUID {
                                            isFlatMemberKeys = true
                                        } else if (isFlatMemberKeys == false){
                                            self.displayPackageErrorMessage()
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        self.expectingPackageArrival(userUID: userUID)
                        if let flatMembersUID = snapshotCab.value as? [String: Any] {
                            let flatMembersUIDKeys = Array(flatMembersUID.keys)
                            for flatMemberUIDKey in flatMembersUIDKeys {
                                if flatMemberUIDKey == userUID {
                                    isFlatMemberKeys = true
                                } else if (isFlatMemberKeys == false)  {
                                    self.displayPackageErrorMessage()
                                }
                            }
                        }
                    }
                })
            }
        })
    }
    
    func displayPackageErrorMessage() {
        NAActivityIndicator.shared.hideActivityIndicator()
        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorpackageArrivalList())
    }
    
    func displayCabErrorMessage() {
        NAActivityIndicator.shared.hideActivityIndicator()
        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorCabArrivalList())
    }
}

