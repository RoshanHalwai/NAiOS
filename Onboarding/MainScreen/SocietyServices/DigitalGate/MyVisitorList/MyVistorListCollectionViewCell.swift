//
//  MyVistorListCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import MessageUI

class MyVistorListCollectionViewCell: UICollectionViewCell,MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var myVisitorImage: UIImageView!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lbl_MyVisitorName: UILabel!
    @IBOutlet weak var lbl_MyVisitorDate: UILabel!
    @IBOutlet weak var lbl_MyVisitorType: UILabel!
    @IBOutlet weak var lbl_MyVisitorTime: UILabel!
    @IBOutlet weak var lbl_InvitedName: UILabel!
    
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
