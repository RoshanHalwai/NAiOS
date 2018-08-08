//
//  MyVistorListCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

protocol dataCollectionProtocol {
    func deleteData(indx: Int, cell: UICollectionViewCell)
}

class MyGuestListCollectionViewCell: UICollectionViewCell {
    
    var delegate : dataCollectionProtocol?
    var index : IndexPath?
    
    @IBOutlet weak var myVisitorImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lbl_MyVisitorName: UILabel!
    @IBOutlet weak var lbl_MyVisitorDate: UILabel!
    @IBOutlet weak var lbl_MyVisitorType: UILabel!
    @IBOutlet weak var lbl_MyVisitorTime: UILabel!
    @IBOutlet weak var lbl_InvitedName: UILabel!
    @IBOutlet weak var lbl_Invitor: UILabel!
    @IBOutlet weak var btn_Reschedule: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbl_InvitedName.font = NAFont().headerFont()
        lbl_MyVisitorType.font = NAFont().headerFont()
        lbl_MyVisitorName.font = NAFont().headerFont()
        lbl_MyVisitorDate.font = NAFont().headerFont()
        lbl_MyVisitorTime.font = NAFont().headerFont()
        lbl_Invitor.font = NAFont().textFieldFont()
    }
    
    var actionRescheduling : (() -> Void)? = nil
    var actionCall : (() -> Void)? = nil
    var actionMessage : (() -> Void)? = nil
    
    //To call your visitor directly from app
    @IBAction func btnCall(_ sender: UIButton) {
        if let btnAction = self.actionCall {
            btnAction()
        }
    }
    
    //calling object on Reschedule button action
    @IBAction func btnReschedule(_ sender: UIButton) {
        if let btnAction = self.actionRescheduling {
            btnAction()
        }
    }
    
    //calling object on Cancel button action
    @IBAction func btnCancel(_ sender: UIButton) {
        delegate?.deleteData(indx: (index?.row)!, cell: self)
    }
    
    //To message your visitor directly from app
    @IBAction func btnMessage(_ sender: UIButton) {
        if let btnAction = self.actionMessage {
            btnAction()
        }
    }
}
