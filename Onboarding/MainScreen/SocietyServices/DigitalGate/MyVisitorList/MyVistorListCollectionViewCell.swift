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
        //TODO : Need to change mobile number here
         UIApplication.shared.open(NSURL(string: "tel://9725098236")! as URL, options: [:], completionHandler: nil)
    }
    
    //To message your visitor directly from app
    @IBAction func btnMessage(_ sender: UIButton)
    {
         //TODO : Need to change mobile number here
        if (MFMessageComposeViewController.canSendText()) {
            let messageSheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            messageSheet.recipients = ["9725098236"]
            messageSheet.body = "Hellow vikas"
            self.window?.rootViewController?.present(messageSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "The device can't send SMS", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
