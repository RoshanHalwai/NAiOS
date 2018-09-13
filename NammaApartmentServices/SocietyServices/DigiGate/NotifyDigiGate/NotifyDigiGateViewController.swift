//
//  NotifyDigiGateViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class NotifyDigiGateViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ImageList = [#imageLiteral(resourceName: "ExpectingCabs"),#imageLiteral(resourceName: "ExpectingPackage"),#imageLiteral(resourceName: "ExpectingVisitor"),#imageLiteral(resourceName: "HandedThings256"),#imageLiteral(resourceName: "HandedDailyServices256")]
    var ExpectingList = ["Expecting Cab Arrival","Expecting Package Arrival","Expecting Guest","Handed Things To My Guest","Handed Things To My Daily Services"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: NAString().notifyDigiGateHeader())
        self.navigationItem.title = ""
        navigationItem.rightBarButtonItem = nil
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = UIScreen.main.bounds.width

        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NotifyDigiGateCollectionViewCell
        cell.cellImage.image = ImageList[indexPath.row]
        cell.cellLabel.text = ExpectingList[indexPath.row]
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //Label formatting & setting
        cell.cellLabel.font = NAFont().textFieldFont()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let lv = NAViewPresenter().expectingCabArrivalVC()
            lv.navTitle = NAString().expecting_cab_arrival()
            lv.vendorCabNameString = NAString().cab_number()
            self.navigationController?.pushViewController(lv, animated: true)
            
        case 1:
            let lv1 = NAViewPresenter().expectingCabArrivalVC()
            lv1.navTitle = NAString().expecting_package_arrival()
            lv1.vendorCabNameString = NAString().package_vendor_name()
            self.navigationController?.pushViewController(lv1, animated: true)
            
        case 2:
            let lv2 = NAViewPresenter().inviteVisitorVC()
            self.navigationController?.pushViewController(lv2, animated: true)
            
        case 3:
            let lv3 = NAViewPresenter().handedThingsToMyGuestVC()
            self.navigationController?.pushViewController(lv3, animated: true)
            lv3.titleName = NAString().handed_Things().capitalized
            
        case 4:
            let lv4 = NAViewPresenter().handedThingsToMyDailyServiceVC()
            self.navigationController?.pushViewController(lv4, animated: true)
            lv4.titleName = NAString().handed_Things().capitalized
            
        default:
            break
        }
    }
}
