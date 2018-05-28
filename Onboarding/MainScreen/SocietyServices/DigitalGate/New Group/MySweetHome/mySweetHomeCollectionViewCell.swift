//
//  mySweetHomeCollectionViewCell.swift
//  nammaApartment
//
//  Created by KirtanLabs on 27/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import MessageUI

class mySweetHomeCollectionViewCell: UICollectionViewCell ,MFMessageComposeViewControllerDelegate {
   
    
    
    @IBOutlet weak var MySweeetHomeimg: UIImageView!
    
    @IBOutlet weak var lbl_mySweetHomeName: UILabel!
    @IBOutlet weak var lbl_mySweetHomeRelation: UILabel!
    @IBOutlet weak var lbl_mySweetHomeGrantAccess: UILabel!
    
    
    @IBOutlet weak var lbl_MySweetHomeName: UILabel!
    @IBOutlet weak var lbl_MySweetHomeRelation: UILabel!
    @IBOutlet weak var lbl_MySweetHomeGrantAccess: UILabel!
    
    @IBOutlet weak var btn_Call: UIButton!
    @IBOutlet weak var btn_Message: UIButton!
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_Remove: UIButton!
   
    @IBOutlet weak var lbl_Call: UILabel!
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_Edit: UILabel!
    @IBOutlet weak var lbl_Remove: UILabel!
    
    
   
    @IBAction func btnCall(_ sender: Any) {
       
        //TODO : Need to change mobile number here
        UIApplication.shared.open(NSURL(string: "tel://9739591077")! as URL, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func btnMessage(_ sender: Any) {
        
        if(MFMessageComposeViewController.canSendText()){
            
            let messagesheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messagesheet.messageComposeDelegate = self
            messagesheet.recipients = ["9739591077"]
            messagesheet.body = "Hello Vinod"
            self.window?.rootViewController?.present(messagesheet , animated: true , completion: nil)
        } else {
           
            let alert = UIAlertController(title: "Warning", message: "The device can't send SMS", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            
        }
        
    }
    
    @IBAction func btnEdit(_ sender: Any) {
    
    }
    @IBAction func btnRemove(_ sender: Any) {
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
