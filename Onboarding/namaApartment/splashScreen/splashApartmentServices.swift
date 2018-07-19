//
//  PageViewController2.swift
//  namaAppartment
//
//  Created by Vikas Nayak on 30/04/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class splashApartmentServices
: UIViewController {
    
    @IBOutlet weak var imageView_ApartmentServices: UIImageView!
    @IBOutlet weak var lbl_HeaderApartmentServices: UILabel!
    @IBOutlet weak var lbl_DescApartmentServices: UILabel!
    @IBOutlet weak var btnLetsGetStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //label formatting & setting
        lbl_HeaderApartmentServices.font = NAFont().headerFont()
        lbl_DescApartmentServices.font = NAFont().splashdescriptionFont()
        lbl_HeaderApartmentServices.text = NAString().splash_ApartementServices_Title().uppercased()
        lbl_DescApartmentServices.text = NAString().splash_ApartementServices_Description()
        
      //Button formatting & setting
        btnLetsGetStarted.setTitle(NAString().splash_ApartementServices_Button(), for: .normal)
        btnLetsGetStarted.backgroundColor = NAColor().buttonBgColor()
        btnLetsGetStarted.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btnLetsGetStarted.titleLabel?.font = NAFont().buttonFont()
        
        //hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btnLetsGetStarted(_ sender: Any)
    {
        let lv = NAViewPresenter().loginVC()
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
    }
}
