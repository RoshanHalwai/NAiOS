//
//  MyVehiclesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyVehiclesViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btn_AddVehicle: UIButton!
    
    var navTitle = String()
    
    //TODO: Feature Added Firebase Data
    var vehiclesImagesArray = ["motorCycle.png","car.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        
        //Button Formatting & settings
        btn_AddVehicle.setTitle(NAString().addMyVehicles().capitalized, for: .normal)
        btn_AddVehicle.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_AddVehicle.backgroundColor = NAColor().buttonBgColor()
        btn_AddVehicle.titleLabel?.font = NAFont().buttonFont()
    }
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehiclesImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyVehiclesCollectionViewCell
        
        //TODO: Feature Added Firebase Data
        cell.lbl_MyVehicleNumber.text = "Sourav"
        cell.lbl_MyVehicleOwner.text = "5"
        cell.lbl_MyVehicleAddedNo.text = "AVAILABLE"
        
        //TODO: Feature Added Firebase Data
        cell.myVehicleImage.image = UIImage(named: vehiclesImagesArray[indexPath.row])
        
        //assigning font & style to cell labels
        cell.lbl_MyVehicleNumber.font = NAFont().headerFont()
        cell.lbl_MyVehicleOwner.font = NAFont().headerFont()
        cell.lbl_MyVehicleAddedNo.font = NAFont().headerFont()
        cell.lbl_VehicleNumber.font = NAFont().textFieldFont()
        cell.lbl_VehicleOwner.font = NAFont().textFieldFont()
        cell.lbl_VehicleAddedNo.font = NAFont().textFieldFont()
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //setting image round
        cell.myVehicleImage.layer.cornerRadius = cell.myVehicleImage.frame.size.width/2
        cell.myVehicleImage.clipsToBounds = true
        
        return cell
    }
    
    //Create Add Vehicle Button Action
    @IBAction func addVehicleButtonAction() {
        let dv = NAViewPresenter().addMyVehiclesVC()
        dv.navTitle = NAString().addMyVehicles()
        self.navigationController?.pushViewController(dv, animated: true)
    }
}
