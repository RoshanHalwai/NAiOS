//
//  mySweetHomeCollectionViewCell.swift
//  nammaApartment
//
//  Created by KirtanLabs on 27/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import MessageUI

protocol removeCollectionProtocol {
    func deleteData(indx: Int, cell: UICollectionViewCell)
}

class mySweetHomeCollectionViewCell: UICollectionViewCell ,MFMessageComposeViewControllerDelegate {
    
    var delegate : removeCollectionProtocol?
    var index : IndexPath?
   
    @IBOutlet weak var MySweeetHomeimg: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Relation: UILabel!
    @IBOutlet weak var lbl_GrantAccess: UILabel!
    
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
    
    //created object to use Edit button action in cell class
    var objEdit : (() -> Void)? = nil
    
    @IBAction func btnCall(_ sender: Any) {
       
        //TODO : Need to change mobile number here
        UIApplication.shared.open(NSURL(string: "tel://9739591077")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func btnMessage(_ sender: Any) {
        
        if(MFMessageComposeViewController.canSendText()){
            
            let messagesheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messagesheet.messageComposeDelegate = self
            
            //TODO : Nedd to change phone Number.
            messagesheet.recipients = ["9739591077"]
            messagesheet.body = ""
            self.window?.rootViewController?.present(messagesheet , animated: true , completion: nil)
        } else {
           
            let alert = UIAlertController(title:NAString().warning(), message: NAString().message_warning_text(), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:NAString().ok(), style: UIAlertActionStyle.default, handler: nil))
        }
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        if let btnAction = self.objEdit
        {
            btnAction()
        }
    
    }
    
    @IBAction func btnRemove(_ sender: Any) {
         delegate?.deleteData(indx: (index?.row)!, cell: self)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
