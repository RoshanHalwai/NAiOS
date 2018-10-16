//
//  SendMessageViewController.swift
//  nammaApartment
//
//  Created by kirtan labs on 11/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SendMessageViewController: NANavigationViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var text_View: UITextView!
    @IBOutlet weak var btn_Send: UIButton!
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var stackView_Bottom_Constraints: NSLayoutConstraint!
    @IBOutlet weak var text_View_Height_Constraints: NSLayoutConstraint!
    
    @IBOutlet weak var table_View_Bottom_Constraint: NSLayoutConstraint!
    
    var neighbourUID = String()
    var neighbourApartment = String()
    var neighbourFlat = String()
    var messageTime = String()
    
    var neighboursChat = [NANeighboursChat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: "Send Message")
        self.navigationItem.rightBarButtonItem = nil
        text_View.backgroundColor = UIColor.white
        text_View.layer.borderColor = UIColor.black.cgColor
        text_View.layer.borderWidth = 2
        text_View.layer.cornerRadius = 15
        text_View.delegate = self
        text_View.font = NAFont().textFieldFont()
        retrieveNeighboursMessages()
        table_View.separatorStyle = .none
       
        
        
        table_View.estimatedRowHeight = 100
        
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
                //self.table_View_Bottom_Constraint.constant = keyBoardHeight
                
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.stackView_Bottom_Constraints.constant = self.stackView_Bottom_Constraints.constant - keyBoardHeight
                //self.table_View_Bottom_Constraint.constant = self.table_View_Bottom_Constraint.constant - keyBoardHeight
               
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btn_Send_Action(_ sender: UIButton) {
        storeMessageInFirebase()
        //retrieveNeighboursMessages()
        
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
        dateFormatterGet.dateFormat = "hh:mm a"
        messageTime = (dateFormatterGet.string(from: dateAndTime!))
        if messageList.getReceiverUID() == userUID {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? ReceiverTableViewCell
            
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let numberOfLines: Int = Int(self.text_View.contentSize.height/(self.text_View.font?.lineHeight)!)
        let estimatedSize = self.text_View.contentSize.height
        text_View.constraints.forEach { (constraints) in
            self.text_View_Height_Constraints.constant = estimatedSize
        }
        if numberOfLines <= 5 {
            self.text_View_Height_Constraints.constant = self.text_View.contentSize.height
        } 
        return true
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

//        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as? SendMessageTableViewCell
//        var messageList : NANeighboursChat
//        messageList = neighboursChat[indexPath.row]
//        cell?.parentView.layer.cornerRadius = 10
//
//        let timeStamp = messageList.getTimeStamp()
//        let date = (NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000)))
//        let dateString = String(describing: date)
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = NAString().userProblemTimeStampFormat()
//        let dateAndTime = dateFormatterGet.date(from: dateString)
//        dateFormatterGet.dateFormat = "hh:mm a"
//        let messageTime = (dateFormatterGet.string(from: dateAndTime!))
//
//        if messageList.getReceiverUID() == userUID {
//            cell?.parentView.layer.borderColor = UIColor.black.cgColor
//            cell?.parentView.layer.borderWidth = 1
//            cell?.parentView.backgroundColor = UIColor.white
//            cell?.lbl_time.textColor = UIColor.lightGray
//            cell?.parentView_Trailing.constant = 60
//            cell?.parentView_Leading.constant = 14
//        } else {
//            cell?.parentView.backgroundColor = UIColor.lightGray
//            cell?.lbl_time.textColor = UIColor.black
//            cell?.parentView_Trailing.constant = 14
//            cell?.parentView_Leading.constant = 60
//        }
//        cell?.lbl_Messages.text = messageList.getMessage()
//        cell?.lbl_time.text = messageTime
//        //indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
//
//        cell?.lbl_Messages.font = NAFont().textFieldFont()
//        cell?.isUserInteractionEnabled = false
//
//        return cell!
