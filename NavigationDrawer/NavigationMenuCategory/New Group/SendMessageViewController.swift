//
//  SendMessageViewController.swift
//  nammaApartment
//
//  Created by kirtan labs on 11/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SendMessageViewController: NANavigationViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var txtView_Parent_View: UIView!
    @IBOutlet weak var text_View: UITextView!
    @IBOutlet weak var btn_Send: UIButton!
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var stackView_Bottom_Constraints: NSLayoutConstraint!
    @IBOutlet weak var text_View_Height_Constraints: NSLayoutConstraint!
    @IBOutlet weak var send_Button_Bottom_Constraints: NSLayoutConstraint!
    
    @IBOutlet weak var parent_View_Height_Constraint: NSLayoutConstraint!
    
    var neighbourUID = String()
    var neighbourApartment = String()
    var neighbourFlat = String()
    var messageTime = String()
    
    var neighboursChat = [NANeighboursChat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: NAString().send_Message())
        self.navigationItem.rightBarButtonItem = nil
        text_View.backgroundColor = UIColor.white
        txtView_Parent_View.layer.borderColor = UIColor.black.cgColor
        txtView_Parent_View.layer.borderWidth = 2
        txtView_Parent_View.layer.cornerRadius = 15
        text_View.delegate = self
        text_View.font = NAFont().textFieldFont()
        retrieveNeighboursMessages()
        table_View.separatorStyle = .none
        table_View.estimatedRowHeight = 200
        table_View.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        view.isUserInteractionEnabled = true
        btn_Send.isUserInteractionEnabled = true
        btn_Send.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func keyBoardWillShow(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.stackView_Bottom_Constraints.constant = keyBoardHeight
                self.send_Button_Bottom_Constraints.constant = keyBoardHeight
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                    let indexPath = NSIndexPath(row: self.neighboursChat.count-1, section: 0)
                    self.table_View.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
                })
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.stackView_Bottom_Constraints.constant = (self.stackView_Bottom_Constraints.constant - keyBoardHeight) + 4
                self.send_Button_Bottom_Constraints.constant = (self.send_Button_Bottom_Constraints.constant - keyBoardHeight) + 4
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func btn_Send_Action(_ sender: UIButton) {
        storeMessageInFirebase()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neighboursChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var messageList : NANeighboursChat
        messageList = neighboursChat[indexPath.row]
        let timeStamp = messageList.getTimeStamp()
        let date = (NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000)))
        let dateString = String(describing: date)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = NAString().userProblemTimeStampFormat()
        let dateAndTime = dateFormatterGet.date(from: dateString)
        dateFormatterGet.dateFormat = NAString().converted_Chat_TimeFormat()
        messageTime = (dateFormatterGet.string(from: dateAndTime!))
        
        //Using two different table view Cells for recieved message and sent message.
        if messageList.getReceiverUID() == userUID {
            let cell = tableView.dequeueReusableCell(withIdentifier: NAString().secondCell_ID(), for: indexPath) as? ReceiverTableViewCell
            
            cell?.lbl_Reciever_Time.textColor = UIColor.black
            cell?.lbl_Reciever_Message.text = messageList.getMessage()
            cell?.lbl_Reciever_Time.text = messageTime
            cell?.lbl_Reciever_Message.font = NAFont().lato_Regular_16()
            cell?.lbl_Reciever_Message.sizeToFit()
            cell?.isUserInteractionEnabled = false
            cell?.reciever_Parent_View.layer.cornerRadius = 10
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as? UserTableViewCell
           
            cell?.lbl_User_Time.textColor = UIColor.white
            cell?.lbl_User_Message.textColor = UIColor.white
            cell?.lbl_User_Message.text = messageList.getMessage()
            cell?.lbl_User_Time.text = messageTime
            cell?.user_Parent_View.layer.cornerRadius = 10
            cell?.lbl_User_Message.sizeToFit()
            cell?.lbl_User_Message.font = NAFont().lato_Regular_16()
            cell?.isUserInteractionEnabled = false
            return cell!
        }
    }
    
    /*Resizing the Text View According to the Content Entered by the User and also allowing to resize upto 4 lines.*/
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let numberOfLines: Int = Int(self.text_View.contentSize.height/(self.text_View.font?.lineHeight)!)
        if numberOfLines <= 4 {
            self.text_View_Height_Constraints.constant = self.text_View.contentSize.height
            self.parent_View_Height_Constraint.constant = self.text_View.contentSize.height
        } 
        return true
    }
    
    ///Storing User Sent Messages under particular Chat Room UID.
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
            let chatAllRef = Constants.FIREBASE_DATABASE_REFERENCE
                .child(Constants.FIREBASE_CHILD_CHATS).child(Constants.FIREBASE_USER_CHILD_ALL).child(chatRoomUID!)
            let UIDs = [userUID: NAString().gettrue(),
                        self.neighbourUID: NAString().gettrue()]
            chatAllRef.setValue(UIDs)
            
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
    
    ///Retrieving Neighbours sent Messages in particular chat Room.
    func retrieveNeighboursMessages() {
        self.neighboursChat.removeAll()
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_CHATS).child(neighbourUID)
        
        userDataRef.observe(.value) { (snapshot) in
            if snapshot.exists() {
                let chatRoomUID = snapshot.value as? String
                
                let chatRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_CHATS).child(Constants.FIREBASE_CHILD_PRIVATE).child(chatRoomUID!)
                
                chatRef.observe(.value, with: { (messageUIDsnapshot) in
                    let messagesUID = messageUIDsnapshot.value as? NSDictionary
                    var messagesUIDArray = [String]()
                    messagesUIDArray = messagesUID?.allKeys as! [String]
                    let sortedArray = messagesUIDArray.sorted()
                    self.neighboursChat.removeAll()
                    for messageUID in sortedArray {
                        chatRef.child(messageUID).observe(.value, with: { (messageSnapshot) in
                            let messagesData = messageSnapshot.value as? [String: AnyObject]
                            
                            let message = messagesData![NANeighboursListKeys.message.key]
                            let receiverUID = messagesData![NANeighboursListKeys.receiverUID.key]
                            let timeStamp = messagesData![NANeighboursListKeys.timeStamp.key]
                            
                            let messageData = NANeighboursChat(message: message as! String, receiverUID: receiverUID as! String, timeStamp: timeStamp as! Int)
                            
                            self.neighboursChat.append(messageData)
                            self.table_View.reloadData()
                            let indexPath = NSIndexPath(row: self.neighboursChat.count-1, section: 0)
                            self.table_View.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
                        })
                    }
                })
            }
        }
    }
}
