//
//  PrivacyPolicyViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 18/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_PolicyDetail: UILabel!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        lbl_PolicyDetail.text = NAString().privacy_policy_Detail()
        lbl_PolicyDetail.font = NAFont().textFieldFont()
    }
}
