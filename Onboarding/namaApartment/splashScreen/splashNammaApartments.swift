//
//  PageViewController1.swift
//  namaAppartment
//
//  Created by Vikas Nayak on 30/04/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class splashNammaApartments: UIViewController {
    @IBOutlet weak var imageView_NammaApartments: UIImageView!
    @IBOutlet weak var lbl_HeaderNammaApartments: UILabel!
    @IBOutlet weak var lbl_DescNammaApartments: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide navigationbar
        self.navigationController?.isNavigationBarHidden = true
        
        //label formatting & setting
        lbl_HeaderNammaApartments.font = NAFont().headerFont()
        lbl_DescNammaApartments.font = NAFont().splashdescriptionFont()
        
        //text formatting & setting
        lbl_HeaderNammaApartments.text = NAString().splash_NammaHeader_Title().uppercased()
        lbl_DescNammaApartments.text = NAString().splash_NammaApartements_Description()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
