//
//  HandedThingsToGuestCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 10/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
var UserDataRef : DatabaseReference?

class HandedThingsToGuestTableViewCell: UITableViewCell {
    
    //created object to use History button action in cell class
    var objHistoryVC : (() -> Void)? = nil
    
    @IBOutlet weak var image_View: UIImageView!
    @IBOutlet weak var lbl_Visiter: UILabel!
    @IBOutlet weak var lbl_Type: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Invited: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var lbl_VisiterName: UILabel!
    @IBOutlet weak var lbl_GuestType: UILabel!
    @IBOutlet weak var lbl_GuestDate: UILabel!
    @IBOutlet weak var lbl_GuestTime: UILabel!
    @IBOutlet weak var lbl_GuestInvitedBy: UILabel!
    @IBOutlet weak var lbl_ThingsGiven: UILabel!
    
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var txt_Description: UITextField!
    @IBOutlet weak var btn_NotifyGate: UIButton!
    
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    //Defining cell Height
    class var expandedHeight: CGFloat { get { return 340 } }
    class var defaultHeight: CGFloat  { get { return 215 } }
    
    @IBAction func btn_NotifyGate_Action(_ sender: UIButton) {
        if let btnAction = self.objHistoryVC {
            btnAction()
            // TODO: need to change UID in Future
            UserDataRef = Database.database().reference().child(Constants.FIREBASE_USERDATA).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
                .child(Constants.FIREBASE_CHILD_BANGALORE)
                .child(Constants.FIREBASE_CHILD_BRIGADE_GATEWAY)
                .child(Constants.FIREBASE_CHILD_ASTER)
                .child(Constants.FIREBASE_CHILD_FLATNO)
                .child(Constants.FLAT_Visitor).child(userUID)
            UserDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
                if snapshot.exists(){
                    for DatavalueesCell in ((snapshot.value as AnyObject).allKeys)!{
                        let SnapShotValues_Cell = snapshot.value as? NSDictionary
                        for UserID_Cell  in (SnapShotValues_Cell?.allKeys)! {
                            let userIDS_Cell = UserID_Cell as! String
                            // TODO: need to change UID in Future
                            Database.database().reference()
                                .child(Constants.FIREBASE_CHILD_VISITORS)
                                .child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS)
                                .child(userIDS_Cell).child(Constants.FIREBASE_HANDEDTHINGS).setValue(self.txt_Description.text!)
                        }
                    }
                }
            })
        }
    }
}


