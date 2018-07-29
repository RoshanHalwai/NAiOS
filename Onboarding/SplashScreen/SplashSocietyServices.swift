//
//  PageViewController3.swift
//  namaAppartment
//
//  Created by Vikas Nayak on 30/04/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SplashSocietyServices: UIViewController {
    @IBOutlet weak var imageView_SocietyServices: UIImageView!
    @IBOutlet weak var lbl_HeaderSocietyServices: UILabel!
    @IBOutlet weak var lbl_DescSocietyServices: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //label formatting & setting
        lbl_HeaderSocietyServices.font = NAFont().headerFont()
        lbl_DescSocietyServices.font = NAFont().splashdescriptionFont()
        
        lbl_HeaderSocietyServices.text = NAString().splash_SocietyServices_Title().uppercased()
        lbl_DescSocietyServices.text = NAString().splash_SocietyServices_Description()
        
        //hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
}
