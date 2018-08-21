//
//  ContactUsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 18/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ContactUsViewController: NANavigationViewController {

    @IBOutlet weak var lbl_AddressDetail: UILabel!
    @IBOutlet weak var content_View: UIView!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
    
        lbl_AddressDetail.text = NAString().address_Detail()
        
        lbl_AddressDetail.font = NAFont().layoutFeatureErrorFont()
        
        //cardUIView
        content_View?.layer.cornerRadius = 3
        content_View?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        content_View?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        content_View?.layer.shadowRadius = 1.7
        content_View?.layer.shadowOpacity = 0.45
    }
}
