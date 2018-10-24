//
//  TransactionsContactUsViewController.swift
//  nammaApartment
//
//  Created by Srilatha on 10/24/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class TransactionsContactUsViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_ContactTitle : UILabel!
    @IBOutlet weak var lbl_ContactMessage : UILabel!
    @IBOutlet weak var lbl_mobileNumber : UILabel!
    @IBOutlet weak var lbl_Mail : UILabel!
    
    @IBOutlet weak var img_Call : UIImageView!
    @IBOutlet weak var img_Email : UIImageView!
    
    @IBOutlet weak var cardView : UIView!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Setting label fonts
        lbl_ContactTitle.font = NAFont().CellLabelFont()
        lbl_ContactMessage.font = NAFont().lato_Regular_20()
        lbl_mobileNumber.font = NAFont().headerFont()
        lbl_Mail.font = NAFont().headerFont()
        
        //Setting View Shadow Effect
        NAShadowEffect().shadowEffectForView(view: cardView)
        
        //Setting Label Texts
        //TODO: Need to Retrieve Mobile Number and Email in Firebase
        lbl_ContactTitle.text = NAString().transactionContact()
        lbl_ContactMessage.text = NAString().transactionContactMessage()
        
        //Setting Label text Underline
        lbl_mobileNumber.attributedText = NSAttributedString(string: NAString().mobileNumber(), attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        lbl_Mail.attributedText = NSAttributedString(string: NAString().email(), attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
}
