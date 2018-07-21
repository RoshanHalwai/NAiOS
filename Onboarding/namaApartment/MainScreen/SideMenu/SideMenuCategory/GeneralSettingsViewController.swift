//
//  GeneralSettingsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class GeneralSettingsViewController: NANavigationViewController {
    
    @IBOutlet weak var choose_Language_Label: UILabel!
    
    @IBOutlet weak var location_Services_Label: UILabel!
    
    @IBOutlet weak var report_A_Bug_Label: UILabel!
    
    @IBOutlet weak var app_Version_Label: UILabel!
    
    @IBOutlet weak var report_Bug_TextField: UITextField!
    
    @IBOutlet weak var location_Services_Switch: UISwitch!
    
    var navTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.ConfigureNavBarTitle(title: navTitle)
        
        report_Bug_TextField.underlined()
        
        report_Bug_TextField.font = NAFont().textFieldFont()
        
        choose_Language_Label.text = NAString().choose_Language()
        location_Services_Label.text = NAString().location_services()
        report_A_Bug_Label.text = NAString().report_bug()
        app_Version_Label.text = NAString().app_Version()
        
        choose_Language_Label.font = NAFont().headerFont()
        location_Services_Label.font = NAFont().headerFont()
        report_A_Bug_Label.font = NAFont().headerFont()
        app_Version_Label.font = NAFont().headerFont()
    }

}
