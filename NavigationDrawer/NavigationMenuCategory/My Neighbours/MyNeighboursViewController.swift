//
//  MyNeighboursViewController.swift
//  nammaApartment
//
//  Created by Srilatha on 10/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyNeighboursViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myExpectedNeighboursList = [NAExpectingNeighbours]()
    
    var apartmentName = String()
    var flatNumber = String()
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Progress indicator while we retrieve users
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
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
        
        //Here Adding Observer Value Using NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.imageHandle(notification:)), name: Notification.Name("CallBack"), object: nil)
    }
    
    //Create image Handle  Function
    @objc func imageHandle(notification: Notification) {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates(nil, completion: nil)
            self.collectionView.reloadData()
        }
    }
    
    //MARK: CollectionView Delegate & DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myExpectedNeighboursList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! NeighboursCollectionViewCell
        
        let myNeighboursList : NAExpectingNeighbours
        myNeighboursList = myExpectedNeighboursList[indexPath.row]
        
        cell.lbl_MyNeighbourName.text = myNeighboursList.getname()
        cell.lbl_MyNeighbourApartment.text = myNeighboursList.getapartment()
        cell.lbl_MyNeighbourFlat.text = myNeighboursList.getflat()
        
        let queue = OperationQueue()
        
        queue.addOperation {
            if let urlString = myNeighboursList.getprofilePhoto() {
                NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.myNeighboursImage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    cell.activityIndicator.isHidden = true
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        
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
}

extension MyNeighboursViewController {
    
    func retrieviedMyNeighboursDataInFirebase() {
        
        let userDataRef = Constants.FIREBASE_USERS_PRIVATE
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            
            if userDataSnapshot.exists() {
                let userDatasUID = userDataSnapshot.value as? NSDictionary
                
                for userDataUID in (userDatasUID?.allKeys)! {
                    userDataRef.child(userDataUID as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                        let usersData = snapshot.value as? [String: AnyObject]
                        
                        //Creating instance of UserPrivileges Details
                        var userPrivilegesDataMap = usersData?["privileges"] as? [String: AnyObject]
                        let admin = userPrivilegesDataMap?[UserPrivilegesListFBKeys.admin.key]
                        
                        //Creating instance of UserFlatDetails
                        var userFlatDataMap = usersData?["flatDetails"] as? [String: Any]
                        self.apartmentName = userFlatDataMap?[UserFlatListFBKeys.apartmentName.key] as! String
                        self.flatNumber = userFlatDataMap?[UserFlatListFBKeys.flatNumber.key] as! String
                        
                        //Creating instance of UserPersonalDetails
                        var userPersonalDataMap = usersData?["personalDetails"] as? [String: Any]
                        let name = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as! String
                        let profilePhoto = userPersonalDataMap?[UserPersonalListFBKeys.profilePhoto.key] as? String
                        
                        let neighboursDetails = NAExpectingNeighbours(name: name, profilePhoto: profilePhoto!, apartment: self.apartmentName, flat: self.flatNumber)
                        
                        if GlobalUserData.shared.privileges_Items.first?.getAdmin() == true && !(self.apartmentName == GlobalUserData.shared.flatDetails_Items.first?.apartmentName && self.flatNumber == GlobalUserData.shared.flatDetails_Items.first?.flatNumber) {
                            self.myExpectedNeighboursList.append(neighboursDetails)
                            
                            //Hiding Progress indicator after retrieving data.
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.collectionView.reloadData()
                        }
                    })
                }
            }
        })
    }
}
