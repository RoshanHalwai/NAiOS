//
//  SendMessageViewController.swift
//  nammaApartment
//
//  Created by kirtan labs on 11/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SendMessageViewController: NANavigationViewController {
    
    @IBOutlet weak var text_View: UITextView!
    @IBOutlet weak var btn_Send: UIButton!
    
    var neighbourUID = String()
    var neighbourApartment = String()
    var neighbourFlat = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text_View.backgroundColor = UIColor.white
        text_View.layer.borderColor = UIColor.black.cgColor
        text_View.layer.borderWidth = 2
        text_View.layer.cornerRadius = 5
        text_View.delegate = self as? UITextViewDelegate
        text_View.font = NAFont().textFieldFont()
    }

    @IBAction func btn_Send_Action(_ sender: UIButton) {
        storeMessageInFirebase()
    }
    
    func storeMessageInFirebase() {
        let userDataRef = GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_CHATS)
            .child(neighbourUID)
        
        var chatRoomUID : String?
        chatRoomUID = (userDataRef.childByAutoId().key)
        
        userDataRef.observeSingleEvent(of: .value) { (snapshot) in
            
            if snapshot.exists() {
                chatRoomUID = snapshot.value as? String
            } else {
                userDataRef.setValue(chatRoomUID)
                
                let city = GlobalUserData.shared.flatDetails_Items.first?.getcity()
                let society = GlobalUserData.shared.flatDetails_Items.first?.getsocietyName()
                
                let neighbourDataRef = Constants.FIREBASE_USERDATA_PRIVATE
                    .child(city!)
                    .child(society!)
                    .child(self.neighbourApartment)
                    .child(self.neighbourFlat)
                    .child(Constants.FIREBASE_CHILD_CHATS)
                    .child(userUID)
                neighbourDataRef.setValue(chatRoomUID)
            }
            
            let chatRef = Constants.FIREBASE_DATABASE_REFERENCE
                .child(Constants.FIREBASE_CHILD_CHATS)
                .child(Constants.FIREBASE_CHILD_PRIVATE)
                .child(chatRoomUID!)
            
            let messageUID : String?
            messageUID = chatRef.childByAutoId().key
            
            let messageData = [NANeighboursListKeys.message.key: self.text_View.text,
                               NANeighboursListKeys.receiverUID.key: self.neighbourUID,
                               NANeighboursListKeys.timeStamp.key:(Int64(Date().timeIntervalSince1970 * 1000))] as [String : Any]
            
            self.text_View.text = ""
            chatRef.child(messageUID!).setValue(messageData)
        }
    }
}
