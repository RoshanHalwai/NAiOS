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

class mySweetHomeCollectionViewCell: UICollectionViewCell {
    
    var delegate : removeCollectionProtocol?
    var index : IndexPath?
    var mySweetHomeVC: MySweetHomeViewController!
    
    @IBOutlet weak var MySweeetHomeimg: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_GrantAccess: UILabel!
    
    @IBOutlet weak var lbl_MySweetHomeName: UILabel!
    @IBOutlet weak var lbl_MySweetHomeGrantAccess: UILabel!
    
    @IBOutlet weak var btn_Call: UIButton!
    @IBOutlet weak var btn_Message: UIButton!
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_Remove: UIButton!
    
    @IBOutlet weak var lbl_Call: UILabel!
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_Edit: UILabel!
    @IBOutlet weak var lbl_Remove: UILabel!
    
    //created object to use button action in cell class
    var objEdit : (() -> Void)? = nil
    var objCall : (() -> Void)? = nil
    var objMessage : (() -> Void)? = nil
    
    @IBAction func btnCall(_ sender: Any) {
        if let btnCallAction = self.objCall {
            btnCallAction()
        }
    }
    
    @IBAction func btnMessage(_ sender: Any) {
        if let btnMessageAction = self.objMessage {
            btnMessageAction()
        }
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        if let btnAction = self.objEdit {
            btnAction()
        }
    }
    
    @IBAction func btnRemove(_ sender: Any) { }
}
