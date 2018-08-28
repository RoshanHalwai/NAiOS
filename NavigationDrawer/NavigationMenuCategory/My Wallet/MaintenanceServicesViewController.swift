//
//  MaintenanceServicesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/23/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MaintenanceServicesViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_Rupees: UILabel!
    @IBOutlet weak var lbl_TotalAmount: UILabel!
    
    @IBOutlet weak var btn_payNow: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        
        //Setting label fonts
        lbl_TotalAmount.font = NAFont().headerFont()
        lbl_Description.font = NAFont().lato_Regular_16()
        lbl_Rupees.font = NAFont().headerFont()
        
        btn_payNow.backgroundColor = NAColor().buttonBackGroundColor()
        btn_payNow.titleLabel?.font = NAFont().lato_Bold_16()
        
        //Creating Shadow Effect for View
        NAShadowEffect().shadowEffectForView(view: cardView)
    }
}
