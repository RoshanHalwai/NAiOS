//
//  MyVehiclesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyVehiclesViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btn_AddVehicle: UIButton!
    
    var navTitle = String()
    var expectedVehicleString = String()
    var fromHomeScreenVC = false
    
    //Database References
    var userDataRef : DatabaseReference?
    var vehiclesPublicRef : DatabaseReference?
    
    var myExpectedVehicleList = [NAExpectingVehicle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Button Formatting & settings
        btn_AddVehicle.setTitle(NAString().addMyVehicles().capitalized, for: .normal)
        btn_AddVehicle.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_AddVehicle.backgroundColor = NAColor().buttonBgColor()
        btn_AddVehicle.titleLabel?.font = NAFont().buttonFont()
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToHomeScreenVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: height/6)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    //Navigating Back to Home Screen according to Screen coming from
    @objc func goBackToHomeScreenVC() {
        if fromHomeScreenVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-NAString().count_four()]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myExpectedVehicleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyVehiclesCollectionViewCell
        
        let myVehicleList : NAExpectingVehicle
        myVehicleList = myExpectedVehicleList[indexPath.row]
        
        cell.lbl_MyVehicleNumber.text = myVehicleList.getvehicleNumber()
        cell.lbl_MyVehicleOwner.text = myVehicleList.getownerName()
        cell.lbl_MyVehicleAddedOn.text = myVehicleList.getaddedDate()
        
        if  myVehicleList.getvehicleType() == NAString().car() {
            cell.myVehicleImage.image = #imageLiteral(resourceName: "car")
        } else {
            cell.myVehicleImage.image = #imageLiteral(resourceName: "motorCycle")
        }
        
        //assigning font & style to cell labels
        cell.lbl_MyVehicleAddedOn.font = NAFont().headerFont()
        cell.lbl_MyVehicleOwner.font = NAFont().headerFont()
        cell.lbl_MyVehicleNumber.font = NAFont().headerFont()
        cell.lbl_VehicleNumber.font = NAFont().textFieldFont()
        cell.lbl_VehicleOwner.font = NAFont().textFieldFont()
        cell.lbl_VehicleAddedOn.font = NAFont().textFieldFont()
        
        //setting image round
        cell.myVehicleImage.layer.cornerRadius = cell.myVehicleImage.frame.size.width/2
        cell.myVehicleImage.clipsToBounds = true
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        return cell
    }
    
    //Create Add Vehicle Button Action
    @IBAction func addVehicleButtonAction() {
        let dv = NAViewPresenter().addMyVehiclesVC()
        dv.navTitle = NAString().addMyVehicles()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieviedVehicleDataInFirebase()
    }
}

extension MyVehiclesViewController {
    
    func retrieviedVehicleDataInFirebase() {
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_VEHICLES)
        userDataRef?.keepSynced(true)
        userDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                self.myExpectedVehicleList.removeAll()
                let vehiclesUID = snapshot.value as? NSDictionary
                for vehiclesUID in (vehiclesUID?.allKeys)! {
                    self.vehiclesPublicRef = Constants.FIREBASE_VEHICLES_PRIVATE.child(vehiclesUID as! String)
                    self.vehiclesPublicRef?.keepSynced(true)
                    self.vehiclesPublicRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.exists() {
                            let vehicleData = snapshot.value as?[String: AnyObject]
                            let vehicleType = (vehicleData?[VehicleListFBKeys.vehicleType.key] as? String)!
                            let addedDate = vehicleData?[VehicleListFBKeys.addedDate.key] as? String
                            let ownerName = GlobalUserData.shared.personalDetails_Items.first?.getfullName()
                            let vehicleNumber = vehicleData?[VehicleListFBKeys.vehicleNumber.key] as? String
                            let vehicleDetails = NAExpectingVehicle(addedDate: addedDate,ownerName: ownerName, vehicleNumber: vehicleNumber!,vehicleType: vehicleType)
                            
                            self.myExpectedVehicleList.append(vehicleDetails)
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.collectionView.reloadData()
                        }
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().add_your_vehicle_message())
            }
        })
    }
}
