//
//  CookViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import MessageUI

class CookViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var titleName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().cookViewTitle())
    }
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO : Feature Added Firebase Cooks List
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! CookCollectionViewCell
        
        //TODO: Need to remove hardcoded values, after implementing firebase functionality here.
        cell.lbl_MyCookName.text = "Srilatha"
        cell.lbl_MyCookRating.text = "5"
        cell.lbl_MyCookTimeSlot.text = "8:30 PM"
        cell.lbl_MyCookFlat.text = "5"
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //setting image round
        cell.myCookImage.layer.cornerRadius = cell.myCookImage.frame.size.width/2
        cell.myCookImage.clipsToBounds = true
        
        //Implementing Calling Function here on Phone click
        //TODO: Need remove hardcoded Number
        cell.actionCall = {
            UIApplication.shared.open(NSURL(string: "tel://(8866993029)")! as URL, options: [:], completionHandler: nil)
        }
        
        //Implementing Message Function here on Message click
        //TODO: Need remove hardcoded Number
        cell.actionMessage = {
            MFMessageComposeViewController.canSendText()
            let messageSheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            messageSheet.recipients = ["8866993029"]
            messageSheet.body = NAString().sendMessageToSocietyServives()
            self.present(messageSheet, animated: true, completion: nil)
        }
        
        //Implementing Calling ShareUI here on Refer click
        //TODO: Need to remove hardcoded text
        cell.actionRefer = {
            let shareUI = UIActivityViewController(activityItems: ["Hellow"], applicationActivities: nil)
            self.present(shareUI, animated: true, completion: nil)
        }
        
        //Implementing Whatsapp UI Function here on whatsapp click
        cell.actionWhatsAPP = {
            let url  = NSURL(string: NAString().sendMessageToSocietyServivesWhatsapp())
            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.open(url! as URL, options: [:]) { (success) in
                    if success {
                        //Used print statement here, so other develper can also know if something wrong.
                        print("WhatsApp accessed successfully")
                    } else {
                        print("Error accessing WhatsApp")
                    }
                }
            }
        }
        return cell
    }
    
    //Message UI default function to dismiss UI after calling.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
