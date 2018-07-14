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

    @IBAction func btnRaiseAlarm(_ sender: UIButton)
    {
        let alert = UIAlertController(title: NAString().emergency_alert_Title(), message: NAString().emergency_Alert_Message(), preferredStyle: .alert)
        let backView = alert.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 10.0
        backView?.backgroundColor = UIColor.white
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in }))
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
            self.lbl_Description.isHidden = false
        }))
        
        self.present(alert, animated: true)
    }
}
