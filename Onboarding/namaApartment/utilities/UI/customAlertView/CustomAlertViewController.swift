//
//  CustomAlertViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 09/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    @IBOutlet weak var customAlertView: UIView!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var lbl_alertDescription: UILabel!
    @IBOutlet weak var btn_reject: UIButton!
    @IBOutlet weak var btn_accept: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        customView()
        
        lbl_alertDescription.text = NAString().family_member_alert_message()
    }
    
    func customView() {
        customAlertView.layer.cornerRadius = 10
        customAlertView.layer.masksToBounds = true
        customAlertView.layer.borderColor = UIColor.gray.cgColor
        customAlertView.layer.borderWidth = 0.5
        customAlertView.layer.contentsScale = UIScreen.main.scale
        customAlertView.layer.shadowColor = UIColor.black.cgColor
        customAlertView.layer.shadowRadius = 5.0
        customAlertView.layer.shadowOpacity = 0.5
        customAlertView.layer.masksToBounds = false
        customAlertView.clipsToBounds = false
    }
    
    @IBAction func btnReject(_ sender: UIButton) {
        print("Rejected")
        
        let lv = NAViewPresenter().addMySerivesVC()
        self.navigationController?.pushViewController(lv, animated: true)
        lv.navTitle = NAString().addFamilyMemberTitle()
        lv.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
    print("accepted")
    }
    
}
