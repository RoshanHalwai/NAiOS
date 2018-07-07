//
//  MyDailyServicesCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import MessageUI

protocol dataCollectionProtocolMyDailySVC {
    func deleteData(indx: Int, cell: UICollectionViewCell)
}
class MyDailyServicesCollectionViewCell: UICollectionViewCell,MFMessageComposeViewControllerDelegate {
    
    var delegate : dataCollectionProtocolMyDailySVC?
    var index : IndexPath?
    
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
    
    @IBOutlet weak var lbl_Remove: UILabel!
    @IBOutlet weak var lbl_Edit: UILabel!
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_Call: UILabel!
    
    //created object to call button action in cell class
    var yourobj : (() -> Void)? = nil
    
    //calling object on Cancel button action
    @IBAction func btnCancel(_ sender: UIButton)
    {
        delegate?.deleteData(indx: (index?.row)!, cell: self)
    }
    
    //To call your visitor directly from app
    @IBAction func btnCall(_ sender: UIButton)
    {
        //TODO : need to change  contact number.
        UIApplication.shared.open(NSURL(string: "tel://9725098236")! as URL, options: [:], completionHandler: nil)
    }
    
    //calling object in button action
    @IBAction func btnEditMyDailyServices(_ sender: UIButton)
    {
        if let btnAction = self.yourobj
        {
            btnAction()
        }
    }
    
    //To message your visitor directly from app
    @IBAction func btnMessage(_ sender: UIButton)
    {
        if (MFMessageComposeViewController.canSendText()) {
            let messageSheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            
             //TODO : need to change  contact number.
            messageSheet.recipients = ["9725098236"]
            messageSheet.body = ""
            
            self.window?.rootViewController?.present(messageSheet,animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title:NAString().warning(), message:NAString().message_warning_text(), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:NAString().ok(), style: UIAlertActionStyle.default, handler: nil))
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
