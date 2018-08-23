//
//  MyGuardsViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyGuardsViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var navTitle = String()
    
    //Database References
    var userDataRef : DatabaseReference?
    var isActivityIndicatorRunning = false
    
    var myExpectedGuardsList = [NAExpectingGuard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        
        //Calling RetrievieMyGuardData In Firebase
        self.retrieviedMyGuardsDataInFirebase()
    }
    
    //Create image Handle  Function
    @objc func imageHandle(notification: Notification) {
        DispatchQueue.main.async {
            self.isActivityIndicatorRunning = true
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO : Feature Added Firebase Cooks List
        return myExpectedGuardsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyGuardsCollectionViewCell
        
        let myGuardsList : NAExpectingGuard
        myGuardsList = myExpectedGuardsList[indexPath.row]
        
        cell.lbl_MyGuardName.text = myGuardsList.getfullName()
        cell.lbl_MyGuardStatus.text = myGuardsList.getstatus()
        
        //TODO: Feature Added Firebase Data
        cell.lbl_MyGuardGateNo.text = "5"
        
        let queue = OperationQueue()
        
        queue.addOperation {
            if let urlString = myGuardsList.getprofilePhoto() {
                NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.myGuardImage)
                //Here Adding Observer Value Using NotificationCenter
                NotificationCenter.default.addObserver(self, selector: #selector(self.imageHandle(notification:)), name: Notification.Name("CallBack"), object: nil)
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        
        //assigning font & style to cell labels
        cell.lbl_MyGuardName.font = NAFont().headerFont()
        cell.lbl_MyGuardGateNo.font = NAFont().headerFont()
        cell.lbl_MyGuardStatus.font = NAFont().headerFont()
        cell.lbl_GuardName.font = NAFont().textFieldFont()
        cell.lbl_GuardGateNo.font = NAFont().textFieldFont()
        cell.lbl_GuardStatus.font = NAFont().textFieldFont()
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        if isActivityIndicatorRunning == false {
            cell.activityIndicator.startAnimating()
        } else if (isActivityIndicatorRunning == true) {
            cell.activityIndicator.stopAnimating()
            cell.activityIndicator.isHidden = true
        }
        
        //setting image round
        cell.myGuardImage.layer.cornerRadius = cell.myGuardImage.frame.size.width/2
        cell.myGuardImage.clipsToBounds = true
        
        return cell
    }
}

extension MyGuardsViewController {
    
    func retrieviedMyGuardsDataInFirebase() {
        
        let societyServiceGuardRef = Database.database().reference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICE).child(Constants.FIREBASE_CHILD_GUARD).child(Constants.FIREBASE_USER_CHILD_PRIVATE).child(Constants.FIREBASE_CHILD_DATA)
        societyServiceGuardRef.observeSingleEvent(of: .value) { (societyServiceGuardSnapshot) in
            if societyServiceGuardSnapshot.exists() {
                if let guardsUID = societyServiceGuardSnapshot.value as? [String: Any] {
                    let guardsUIDKeys = Array(guardsUID.keys)
                    for guardUID in guardsUIDKeys {
                        societyServiceGuardRef.child(guardUID).observeSingleEvent(of: .value, with: { (snapshot) in
                            let guardsData = snapshot.value as? [String: AnyObject]
                            let fullName : String = (guardsData?[GuardsListFBKeys.fullName.key])! as! String
                            let status : String = (guardsData?[GuardsListFBKeys.status.key])! as! String
                            let profilePhoto : String = (guardsData?[GuardsListFBKeys.profilePhoto.key])! as! String
                            let guardDetails = NAExpectingGuard(fullName: fullName, profilePhoto: profilePhoto, status: status)
                            self.myExpectedGuardsList.append(guardDetails)
                            
                            //Hiding Progress indicator after retrieving data.
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.collectionView.reloadData()
                        })
                    }
                }
            }
        }
    }
}
