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
    
    @IBOutlet weak var lblHeader_ApartmentServices: UILabel!
    
    @IBOutlet weak var lblDesc_ApartmentServices: UILabel!
    
    
    @IBOutlet weak var btnLetsGetStarted: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting font for labes & style
        lblHeader_ApartmentServices.font = NAFont().headerFont()
        lblDesc_ApartmentServices.font = NAFont().splashdescriptionFont()
        
        //color & font for button
        btnLetsGetStarted.backgroundColor = NAColor().buttonBgColor()
        btnLetsGetStarted.setTitleColor(NAColor().buttonFontColor(), for: .normal)

        
self.navigationController?.isNavigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnLetsGetStarted(_ sender: Any)
    {
//        let lv : signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupViewController
//
//        self.navigationController?.setNavigationBarHidden(false, animated: true);
//        self.navigationController?.pushViewController(lv, animated: true)
        
        
        let lv : loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginViewController
        
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navigationController?.pushViewController(lv, animated: true)
        
    }
    
    
}
