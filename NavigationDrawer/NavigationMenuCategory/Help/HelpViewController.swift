//
//  HelpViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HelpViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection_View: UICollectionView!
    
    var helpArray = [NAString().frequently_asked_questions(), NAString().contact_us(), NAString().terms_and_conditions(), NAString().privacy_policy()]
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.ConfigureNavBarTitle(title: navTitle)
        collection_View.delegate = self
        collection_View.dataSource = self
        collection_View.reloadData()
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HelpCollectionViewCell
        cell.label_View.text = helpArray[indexPath.row]
        
        //Label formatting & setting
        cell.label_View.font = NAFont().textFieldFont()
        NAShadowEffect().shadowEffect(Cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let dv = NAViewPresenter().frequentlyAskedHelpVC()
            dv.navTitle = NAString().frequently_asked_questions().uppercased()
            self.navigationController?.pushViewController(dv, animated: true)
            
        case 1:
            let helpCategoryVC = NAViewPresenter().helpCategoryVC()
            helpCategoryVC.navTitle = NAString().contact_us().capitalized
            self.navigationController?.pushViewController(helpCategoryVC, animated: true)
            
        case 2:
            let termsAndConditionsVC = NAViewPresenter().helpCategoryVC()
            termsAndConditionsVC.navTitle = NAString().terms_and_conditions().capitalized
            self.navigationController?.pushViewController(termsAndConditionsVC, animated: true)
            
        case 3:
            let privacyPolicyVC = NAViewPresenter().helpCategoryVC()
            privacyPolicyVC.navTitle = NAString().privacy_policy().capitalized
            self.navigationController?.pushViewController(privacyPolicyVC, animated: true)
            
        default:
            break
        }
    }
}
