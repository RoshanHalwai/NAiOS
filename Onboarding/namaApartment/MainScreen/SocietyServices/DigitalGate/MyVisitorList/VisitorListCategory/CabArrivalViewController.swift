//
//  CabArrivalViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 30/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class CabArrivalViewController: NANavigationViewController {
    
    var navTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
         NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorCabArrivalList())
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().cab_arrival())
        //created custom back button for goto My Visitors Lists screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToMyVisitorsList))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    //created custome back button to go back to My Visitors List
    @objc func goBackToMyVisitorsList() {
        let dv = NAViewPresenter().myVisitorsListVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
}
