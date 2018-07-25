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
            expectingCabArrival()
        } else if navTitle == NAString().package_arrival() {
            vendorCabNameString = NAString().vendor()
            vendorCabImage = #imageLiteral(resourceName: "ExpectingPackage")
            expectingPackageArrival()
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
        
        let personalValue = Singleton_PersonalDetails.shared.personalDetails_Items
        let userPersonalValues = personalValue.first
        
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
            cell.lbl_Inviter_Detail.text = userPersonalValues?.fullName
            
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
            cell.lbl_Inviter_Detail.text = userPersonalValues?.fullName
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
    
    func expectingCabArrival() {
        
        let flatValues = Singleton_FlatDetails.shared.flatDetails_Items
        let userFlatDetailValues = flatValues.first
        
        userDataRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child((userFlatDetailValues?.city)!).child((userFlatDetailValues?.societyName)!).child((userFlatDetailValues?.apartmentName)!).child((userFlatDetailValues?.flatNumber)!).child(Constants.FIREBASE_CHILD_CABS).child(userUID!)
        
        userDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                let cabsUID = snapshot.value as? NSDictionary
                for cabsUID in (cabsUID?.allKeys)! {
                    self.cabsPublicRef =  Database.database().reference().child(Constants.FIREBASE_CHILD_CABS).child(Constants.FIREBASE_USER_PUBLIC).child(cabsUID as! String)
                    
                    self.cabsPublicRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let cabData = snapshot.value as?[String: AnyObject]
                        let dateAndTimeOfArrival = cabData?[ExpectingArrivalListFBKeys.dateAndTimeOfArrival.key] as? String
                        let reference = cabData?[ExpectingArrivalListFBKeys.reference.key] as? String?
                        let status = cabData?[ExpectingArrivalListFBKeys.status.key] as? String?
                        let cabDetails = NAExpectingArrival(dateAndTimeOfArrival: dateAndTimeOfArrival!, reference: reference!, status: status!)
                        self.myExpectedCabList.append(cabDetails)
                        NAActivityIndicator.shared.hideActivityIndicator()
                        self.collection_View.reloadData()
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorCabArrivalList())
            }
        })
    }
    
    func expectingPackageArrival()  {
        
        let flatValues = Singleton_FlatDetails.shared.flatDetails_Items
        let userFlatDetailValues = flatValues.first
        
        userDataRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child((userFlatDetailValues?.city)!).child((userFlatDetailValues?.societyName)!).child((userFlatDetailValues?.apartmentName)!).child((userFlatDetailValues?.flatNumber)!).child(Constants.FIREBASE_CHILD_DELIVERIES).child(userUID!)
        
        userDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                let packageUID = snapshot.value as? NSDictionary
                for vendorUID in (packageUID?.allKeys)! {
                    self.packagePublicRef =  Database.database().reference().child(Constants.FIREBASE_CHILD_DELIVERIES).child(Constants.FIREBASE_USER_PUBLIC).child(vendorUID as! String)
                    
                    self.packagePublicRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let packageData = snapshot.value as?[String: AnyObject]
                        let dateAndTimeOfArrival = packageData?[ExpectingArrivalListFBKeys.dateAndTimeOfArrival.key] as? String
                        let reference = packageData?[ExpectingArrivalListFBKeys.reference.key] as? String?
                        let status = packageData?[ExpectingArrivalListFBKeys.status.key] as? String?
                        let packageDetails = NAExpectingArrival(dateAndTimeOfArrival: dateAndTimeOfArrival!, reference: reference!, status: status!)
                        self.myExpectedPackageList.append(packageDetails)
                        
                        NAActivityIndicator.shared.hideActivityIndicator()
                        self.collection_View.reloadData()
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorpackageArrivalList())
            }
        })
    }
}

