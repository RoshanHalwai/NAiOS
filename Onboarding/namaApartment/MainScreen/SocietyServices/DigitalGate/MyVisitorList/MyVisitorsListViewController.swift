//
//  MyVisitorsListViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 30/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyVisitorsListViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageList = [#imageLiteral(resourceName: "ExpectingVisitor"), #imageLiteral(resourceName: "ExpectingCabs"), #imageLiteral(resourceName: "ExpectingPackage")]
    var visitorsType = ["Guests", "Cab Arrivals", "Package Arrivals"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        super.ConfigureNavBarTitle(title: NAString().my_visitors_list())
        //created custom back button for goto digi gate screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToDigiGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //created custome back button to go back to digi gate
    @objc func goBackToDigiGate() {
        let dv = NAViewPresenter().digiGateVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyVisitorsListCollectionViewCell
        cell.visitors_Image.image = imageList[indexPath.row]
        cell.lbl_Visitors.text = visitorsType[indexPath.row]
        cell.lbl_Visitors.font = NAFont().splashdescriptionFont()
        
        //creating Shadow effect to Cards
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let lv = NAViewPresenter().myGuestListVC()
            self.navigationController?.pushViewController(lv, animated: true)
            lv.titleName = NAString().myVisitorViewTitle().capitalized
        case 1:
            let lv1 = NAViewPresenter().cabAndPackageArrivalListVC()
            lv1.navTitle = NAString().cab_arrival()
            self.navigationController?.pushViewController(lv1, animated: true)
        case 2:
            let lv2 = NAViewPresenter().cabAndPackageArrivalListVC()
            lv2.navTitle = NAString().package_arrival()
            self.navigationController?.pushViewController(lv2, animated: true)
        default:
            break
        }
    }
}
