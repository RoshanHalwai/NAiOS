//
//  CabAndPackageArrivalCardListViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 14/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class CabAndPackageArrivalCardListViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection_View: UICollectionView!
    
    var navTitle = String()
    
    //Assigning Strings according to title
    var vendorCabNameString: String?
    var vendorCabImage: UIImage?
    
    //Creating  Object with Boolean Value false to know from where the screen is coming from.
    var fromExpectingArrivalVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* * Formatting & setting navigation bar
           * Calling Change Label title Function
           * Created custom back button for navigating back to Digi Gate VC. */
        
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.title = ""
        
        changeLblTitle()
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToDigiGateVC))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    /* * To navigate back to Digi Gate VC
       * Changing label titles in based on Navigation title. */
    
    @objc func goBackToDigiGateVC() {
        if fromExpectingArrivalVC {
        let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-4]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func changeLblTitle() {
        if navTitle == NAString().cab_arrival() {
            vendorCabNameString = NAString().cab_no()
            vendorCabImage = #imageLiteral(resourceName: "ExpectingCabs")
        } else if navTitle == NAString().package_arrival() {
            vendorCabNameString = NAString().vendor()
            vendorCabImage = #imageLiteral(resourceName: "ExpectingPackage")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    /* * This creates the shadows and modifies the cards a little bit
       * Assigning font & style to cell labels
       * Setting image round
       * Assigning Strings to the label tile according to Navigation Title
       * Assigning Images to the Image View according to Navigation Title. */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! CabAndPackageArrivalCardListCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
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
        
        cell.image_View.layer.cornerRadius = cell.image_View.frame.size.width/2
        cell.image_View.clipsToBounds = true
        
        cell.lbl_CabNo_Type.text = vendorCabNameString
        
        cell.image_View.image = vendorCabImage
        return cell
    }
}
