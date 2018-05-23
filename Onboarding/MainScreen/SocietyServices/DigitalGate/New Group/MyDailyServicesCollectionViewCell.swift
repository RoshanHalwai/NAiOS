//
//  MyDailyServicesCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import MessageUI

class MyDailyServicesCollectionViewCell: UICollectionViewCell,MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var myDailyServicesImage: UIImageView!
    
    @IBOutlet weak var lbl_MyDailyServiceName: UILabel!
    @IBOutlet weak var lbl_MyDailyServiceType: UILabel!
    @IBOutlet weak var lbl_MyDailyServicesRating: UILabel!
    @IBOutlet weak var lbl_MyDailyServicesInTime: UILabel!
    @IBOutlet weak var lbl_MyDailyServicesFlats: UILabel!
    
    @IBOutlet weak var lbl_myDailytype: UILabel!
    @IBOutlet weak var lbl_myDailyName: UILabel!
    @IBOutlet weak var lbl_myDailyRating: UILabel!
    @IBOutlet weak var lbl_myDailyTime: UILabel!
    @IBOutlet weak var lbl_myDailyFlats: UILabel!
    
    @IBOutlet weak var btn_Call: UIButton!
    @IBOutlet weak var btn_Message: UIButton!
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_Cancel: UIButton!
    
    //To call your visitor directly from app
    @IBAction func btnCall(_ sender: UIButton)
    {
        UIApplication.shared.open(NSURL(string: "tel://9725098236")! as URL, options: [:], completionHandler: nil)
    }
    
    //To message your visitor directly from app
    @IBAction func btnMessage(_ sender: UIButton)
    {
        MFMessageComposeViewController.canSendText()
        let sms = MFMessageComposeViewController()
        sms.body = ""
        sms.recipients = ["9725098236"]
        sms.messageComposeDelegate = self
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print ("called message App")
    }
    
}
