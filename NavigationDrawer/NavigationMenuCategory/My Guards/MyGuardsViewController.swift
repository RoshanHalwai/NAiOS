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
    
    var myExpectedGuardsList = [NAExpectingGuard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Calling RetrievieMyGuardData In Firebase
        self.retrieviedMyGuardsDataInFirebase()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: height/5)
        
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
        
        let gateNumber : Int = myGuardsList.getgateNumber()
        let gateNoString = String(gateNumber)
        cell.lbl_MyGuardGateNo.text = gateNoString
        
        let queue = OperationQueue()
        
        queue.addOperation {
            if let urlString = myGuardsList.getprofilePhoto() {
                NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.myGuardImage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    cell.activityIndicator.isHidden = true
                    cell.activityIndicator.stopAnimating()
                }
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
        
        return cell
    }
}

extension MyGuardsViewController {
    
    func retrieviedMyGuardsDataInFirebase() {
        
        let societyServiceGuardRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_GUARD).child(Constants.FIREBASE_CHILD_PRIVATE).child(Constants.FIREBASE_CHILD_DATA)
        societyServiceGuardRef.observeSingleEvent(of: .value) { (societyServiceGuardSnapshot) in
            if let guardsUID = societyServiceGuardSnapshot.value as? [String: Any] {
                let guardsUIDKeys = Array(guardsUID.keys)
                for guardUID in guardsUIDKeys {
                    societyServiceGuardRef.child(guardUID).observeSingleEvent(of: .value, with: { (snapshot) in
                        let guardsData = snapshot.value as? [String: AnyObject]
                        let fullName : String = (guardsData?[GuardsListFBKeys.fullName.key])! as! String
                        let status : String = (guardsData?[GuardsListFBKeys.status.key])! as! String
                        let profilePhoto : String = (guardsData?[GuardsListFBKeys.profilePhoto.key])! as! String
                        let gateNo = (guardsData![GuardsListFBKeys.gateNumber.key])?.floatValue
                        let guardDetails = NAExpectingGuard(fullName: fullName, profilePhoto: profilePhoto, status: status, gateNumber: Int((gateNo)!))
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
