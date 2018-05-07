//
//  PageViewController3.swift
//  namaAppartment
//
//  Created by Vikas Nayak on 30/04/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class splashSocietyServices: UIViewController
{
    @IBOutlet weak var imageView_SocietyServices: UIImageView!
    
    @IBOutlet weak var lblHeader_SocietyServices: UILabel!
    
    @IBOutlet weak var lblDesc_SocietyServices: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setting font for labes & style
        lblHeader_SocietyServices.font = NAFont().headerFont()
        lblDesc_SocietyServices.font = NAFont().splashdescriptionFont()
        
        lblHeader_SocietyServices.text = NAString().splash_ApartementServices_Title()
        lblDesc_SocietyServices.text = NAString().splash_SocietyServices_Description()
        
       self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    


}
