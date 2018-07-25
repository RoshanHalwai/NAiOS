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
        
        //Formatting & setting Navigation bar
        super.ConfigureNavBarTitle(title: titleName)
    }
    
    @IBAction func btnRaiseAlarm(_ sender: UIButton) {
        NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().emergency_alert_Title(), Message: NAString().emergency_Alert_Message(), CancelStyle: .default, OkStyle: .destructive, OK: {(action) in
            self.lbl_Description.isHidden = false }, Cancel: {(action) in})
    }
}
