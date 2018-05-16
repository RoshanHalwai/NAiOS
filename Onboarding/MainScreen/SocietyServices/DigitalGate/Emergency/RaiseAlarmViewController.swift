//
//  RaiseAlarmViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 15/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class RaiseAlarmViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Header: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    var titleName =  String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide description label on view load
        self.lbl_Description.isHidden = true
        
        //Setting Title of the screen
       // super.ConfigureNavBarTitle(title: "Emergency")
        super.ConfigureNavBarTitle(title: titleName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    @IBAction func btnRaiseAlarm(_ sender: UIButton)
    {
        self.lbl_Description.isHidden = false
    }
}
