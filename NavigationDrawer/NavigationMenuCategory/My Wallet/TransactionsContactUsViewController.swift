//
//  TransactionsContactUsViewController.swift
//  nammaApartment
//
//  Created by Srilatha on 10/24/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class TransactionsContactUsViewController: NANavigationViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var lbl_ContactTitle : UILabel!
    @IBOutlet weak var lbl_ContactMessage : UILabel!
    @IBOutlet weak var lbl_mobileNumber : UILabel!
    @IBOutlet weak var lbl_Mail : UILabel!
    @IBOutlet weak var img_Call : UIImageView!
    @IBOutlet weak var img_Email : UIImageView!
    @IBOutlet weak var cardView : UIView!
    
    var navTitle = String()
    var phoneNumber = String()
    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieving contactUS data from firebase
        retrieveContactUsDataFromFirebase()
        
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
        lbl_ContactTitle.text = NAString().transactionContact()
        lbl_ContactMessage.text = NAString().transactionContactMessage()
        
        //Performing Actions on click of UILabels(MobileNumber & Email)
        let tapMobileNumber = UITapGestureRecognizer(target: self, action: #selector(tapOnMobileNumber))
        lbl_mobileNumber.isUserInteractionEnabled = true
        lbl_mobileNumber.addGestureRecognizer(tapMobileNumber)
        
        let tapEmail = UITapGestureRecognizer(target: self, action: #selector(tapOnEmail))
        lbl_Mail.isUserInteractionEnabled = true
        lbl_Mail.addGestureRecognizer(tapEmail)
    }
    
    //Implemented Call Functionlity
    @objc func tapOnMobileNumber(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: "tel://\(self.phoneNumber)")! as URL, options: [:], completionHandler: nil)
    }
    
     //Implementing Email Functionlity
    @objc func tapOnEmail(sender:UITapGestureRecognizer) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([self.email])
            mail.setMessageBody("", isHTML: true)
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func retrieveContactUsDataFromFirebase() {
        
       OpacityView.shared.showingOpacityView(view: self)
       OpacityView.shared.showEventPopupView(view: self, title: NAString().retrievingDetails())
        
        //Retrieving contact us data from firebase
        let contactUsRef = Database.database().reference().child(Constants.FIREBASE_CHILD_CONTACTUS)
        contactUsRef.observeSingleEvent(of: .value) { (contactSnapshot) in
            
            let contactUsDetails = contactSnapshot.value as? NSDictionary
            self.phoneNumber = (contactUsDetails![Constants.FIREBASE_CHILD_NUMBER] as? String)!
            self.email = (contactUsDetails![Constants.FIREBASE_CHILD_EMAIL] as? String)!
            
            //Assigning values to show Email & Contact Number
            self.lbl_Mail.text = self.email
            self.lbl_mobileNumber.text = NAString()._91() + NAString().hyphen() + self.phoneNumber
            
            OpacityView.shared.hidingOpacityView()
            OpacityView.shared.hidingPopupView()
        }
    }
}
