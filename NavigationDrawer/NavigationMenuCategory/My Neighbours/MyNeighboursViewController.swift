//
//  MyNeighboursViewController.swift
//  nammaApartment
//
//  Created by Srilatha on 10/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import SDWebImage

class MyNeighboursViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myExpectedNeighboursList = [NAExpectingNeighbours]()
    
    var apartmentName = String()
    var flatNumber = String()
    var navTitle = String()
    var neighboursUID = String()
    var userUID = String()
    
    
    //Created instance for calling retrieveUserData class function
    var loadingUserData = retrieveUserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: NAString().myNeighbours())
        self.navigationItem.rightBarButtonItem = nil
        
        let preferences = UserDefaults.standard
        let UserUID = NAString().userDefault_USERUID()
        if preferences.object(forKey: Constants.NOTIFICATION_SENDER_UID) != nil {
            neighboursUID = preferences.object(forKey: Constants.NOTIFICATION_SENDER_UID) as! String
        }
        userUID = preferences.object(forKey: UserUID) as! String
        preferences.synchronize()
        self.loadingUserData.retrieveUserDataFromFirebase(userId: userUID)
        
        //Show Progress indicator while we retrieve users
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Calling RetrievieMyNeighboursData In Firebase
        self.retrieviedMyNeighboursDataInFirebase()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 120)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
        
        //created custom back button for goto Home Screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToDigitGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to digi gate according to Screen coming from
    @objc func goBackToDigitGate() {
        let NavMain = self.storyboard?.instantiateViewController(withIdentifier: NAViewPresenter().mainNavigation())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = NavMain
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
    //MARK: CollectionView Delegate & DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myExpectedNeighboursList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! NeighboursCollectionViewCell
        
        let myNeighboursList : NAExpectingNeighbours
        myNeighboursList = myExpectedNeighboursList[indexPath.row]
        
        if myNeighboursList.uid == self.neighboursUID {
            cell.batchView.isHidden = false
        } else {
            cell.batchView.isHidden = true
        }
        
        cell.lbl_MyNeighbourName.text = myNeighboursList.getname()
        cell.lbl_MyNeighbourApartment.text = myNeighboursList.getapartment()
        cell.lbl_MyNeighbourFlat.text = myNeighboursList.getflat()
        
        cell.myNeighboursImage.sd_setShowActivityIndicatorView(true)
        cell.myNeighboursImage.sd_setIndicatorStyle(.gray)
        cell.myNeighboursImage.sd_setImage(with: URL(string: myNeighboursList.getprofilePhoto()!), completed: nil)
        
        //assigning font & style to cell labels
        cell.lbl_MyNeighbourName.font = NAFont().headerFont()
        cell.lbl_MyNeighbourApartment.font = NAFont().headerFont()
        cell.lbl_MyNeighbourFlat.font = NAFont().headerFont()
        
        cell.lbl_NeighbourName.font = NAFont().textFieldFont()
        cell.lbl_NeighbourApartment.font = NAFont().textFieldFont()
        cell.lbl_NeighbourFlat.font = NAFont().textFieldFont()
        
        //assigning title to cell Labels
        cell.lbl_NeighbourName.text = NAString().name()
        cell.lbl_NeighbourApartment.text = NAString().apartment_Name()
        cell.lbl_NeighbourFlat.text = NAString().flat_Name()
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let neighboursList = myExpectedNeighboursList[indexPath.row]
        
        if neighboursList.uid == self.neighboursUID {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! NeighboursCollectionViewCell
                cell.batchView.isHidden = true
                let preferences = UserDefaults.standard
                preferences.removeObject(forKey: Constants.NOTIFICATION_SENDER_UID)
        }
        let sendMessageVC = NAViewPresenter().sendMessageVC()
        sendMessageVC.neighbourUID = neighboursList.getneighbourUID()
        sendMessageVC.neighbourApartment = neighboursList.getapartment()
        sendMessageVC.neighbourFlat = neighboursList.getflat()
        self.navigationController?.pushViewController(sendMessageVC, animated: true)
    }
}

extension MyNeighboursViewController {
    
    func retrieviedMyNeighboursDataInFirebase() {
        
        let userDataRef = Constants.FIREBASE_USERS_PRIVATE
        //Adding observe event to each of user UID
        userDataRef?.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            
            if userDataSnapshot.exists() {
                let userDatasUID = userDataSnapshot.value as? NSDictionary
                
                var UIDArray = [String]()
                UIDArray = (userDatasUID?.allKeys)! as! [String]
                if !(self.neighboursUID.isEmpty) {
                    let index = UIDArray.index(of : self.neighboursUID)
                    UIDArray.rearrange(from: index!, to: 0)
                }
                var count = 0
                for userDataUID in UIDArray {
                    userDataRef?.child(userDataUID).observeSingleEvent(of: .value, with: { (snapshot) in
                        count = count + 1
                        let usersData = snapshot.value as? [String: AnyObject]
                        
                        //Creating instance of UserPrivileges Details
                        var userPrivilegesDataMap = usersData?["privileges"] as? [String: AnyObject]
                        let admin = userPrivilegesDataMap?[UserPrivilegesListFBKeys.admin.key] as! Bool
                        
                        //Creating instance of UserFlatDetails
                        var userFlatDataMap = usersData?["flatDetails"] as? [String: Any]
                        self.apartmentName = userFlatDataMap?[UserFlatListFBKeys.apartmentName.key] as! String
                        self.flatNumber = userFlatDataMap?[UserFlatListFBKeys.flatNumber.key] as! String
                        
                        //Creating instance of UserPersonalDetails
                        var userPersonalDataMap = usersData?["personalDetails"] as? [String: Any]
                        let name = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as! String
                        let profilePhoto = userPersonalDataMap?[UserPersonalListFBKeys.profilePhoto.key] as? String
                        
                        let neighboursDetails = NAExpectingNeighbours(name: name, profilePhoto: profilePhoto!, apartment: self.apartmentName, flat: self.flatNumber, uid: userDataUID)
                        
                        if admin == true && !(self.apartmentName == GlobalUserData.shared.flatDetails_Items.first?.apartmentName && self.flatNumber == GlobalUserData.shared.flatDetails_Items.first?.flatNumber) {
                            self.myExpectedNeighboursList.append(neighboursDetails)
                            
                            //Hiding Progress indicator after retrieving data.
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.collectionView.reloadData()
                        } else {
                            if count == UIDArray.count {
                                NAActivityIndicator.shared.hideActivityIndicator()
                                if self.myExpectedNeighboursList.count == 0 {
                                    NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().myNeighboursLayoutErrorMessage())
                                }
                            }
                        }
                    })
                }
            }
        })
    }
}
extension Array {
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
}
