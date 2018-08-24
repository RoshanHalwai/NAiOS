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
    @IBOutlet weak var lbl_myAccount: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_myTransactions: UILabel!
    
    @IBOutlet weak var img_indianRupee: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btn_MaintenanceServices: UIButton!
    @IBOutlet weak var btn_ApartmentServices: UIButton!
    @IBOutlet weak var btn_PartiesandGetTogether: UIButton!
    @IBOutlet weak var btn_FestivalCelebrations: UIButton!
    @IBOutlet weak var btn_FundraisingandDonations: UIButton!
    @IBOutlet weak var btn_OtherSocietyServices: UIButton!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting label fonts
        lbl_nammaApartment.font = NAFont().headerFont()
        lbl_payFor.font = NAFont().headerFont()
        lbl_myAccount.font = NAFont().headerFont()
        lbl_description.font = NAFont().headerFont()
        lbl_myTransactions.font = NAFont().headerFont()
        
        //Setting View Shadow Effect
        NAShadowEffect().shadowEffectForView(view: myAccount_CardView)
        NAShadowEffect().shadowEffectForView(view: payFor_CardView)
        NAShadowEffect().shadowEffectForView(view: nammaApartment_CardView)
        
        //Setting Button Shadow Effect
        NAShadowEffect().shadowEffectForButton(button:btn_ApartmentServices)
        NAShadowEffect().shadowEffectForButton(button:btn_MaintenanceServices)
        NAShadowEffect().shadowEffectForButton(button:btn_PartiesandGetTogether)
        NAShadowEffect().shadowEffectForButton(button:btn_FestivalCelebrations)
        NAShadowEffect().shadowEffectForButton(button:btn_FundraisingandDonations)
        NAShadowEffect().shadowEffectForButton(button:btn_OtherSocietyServices)
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
    }
    
    @IBAction func maintenanceServicesButtonAction() {
        let lv = NAViewPresenter().maintenanceServicesVC()
        lv.navTitle = NAString().maintenanceServices()
        self.navigationController?.pushViewController(lv, animated: true)
    }
}
