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
    

    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationController?.isNavigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnLetsGetStarted(_ sender: Any)
    {
        let lv : signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupViewController
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    
}
