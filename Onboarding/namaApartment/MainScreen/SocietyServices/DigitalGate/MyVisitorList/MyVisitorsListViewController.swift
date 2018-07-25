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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyVisitorsListCollectionViewCell
        cell.visitors_Image.image = imageList[indexPath.row]
        cell.lbl_Visitors.text = visitorsType[indexPath.row]
        cell.lbl_Visitors.font = NAFont().splashdescriptionFont()
        
        NAShadowEffect().shadowEffect(Cell: cell)
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
