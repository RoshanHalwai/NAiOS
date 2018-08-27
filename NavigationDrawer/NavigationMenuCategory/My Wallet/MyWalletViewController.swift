//
//  MyWalletViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/23/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyWalletViewController: NANavigationViewController {
    
    @IBOutlet weak var nammaApartment_CardView: UIView!
    @IBOutlet weak var payFor_CardView: UIView!
    @IBOutlet weak var myAccount_CardView: UIView!
    
    @IBOutlet weak var lbl_nammaApartment: UILabel!
    @IBOutlet weak var lbl_payFor: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_myTransactions: UILabel!
    
    @IBOutlet weak var img_indianRupee: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btn_SocietyServices: UIButton!
    @IBOutlet weak var btn_ApartmentServices: UIButton!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting label fonts
        lbl_nammaApartment.font = NAFont().headerFont()
        lbl_payFor.font = NAFont().headerFont()
        lbl_description.font = NAFont().lato_Regular_16()
        lbl_myTransactions.font = NAFont().lato_Regular_20()
        btn_ApartmentServices.titleLabel?.font = NAFont().lato_Regular_16()
        btn_SocietyServices.titleLabel?.font = NAFont().lato_Regular_16()
        
        
        lbl_nammaApartment.text = NAString().nammaApartments_E_Payment()
        lbl_description.text = NAString().wallet_Description()
        lbl_payFor.text = NAString().make_payment_For()
        
        //Setting View Shadow Effect
        NAShadowEffect().shadowEffectForView(view: myAccount_CardView)
        NAShadowEffect().shadowEffectForView(view: payFor_CardView)
        NAShadowEffect().shadowEffectForView(view: nammaApartment_CardView)
        
        //Setting Button Shadow Effect
        NAShadowEffect().shadowEffectForButton(button:btn_ApartmentServices)
        NAShadowEffect().shadowEffectForButton(button:btn_SocietyServices)
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
    }
    
    @IBAction func maintenanceServicesButtonAction() {
        let lv = NAViewPresenter().maintenanceServicesVC()
        lv.navTitle = NAString().SocietyServices()
        self.navigationController?.pushViewController(lv, animated: true)
    }
}
