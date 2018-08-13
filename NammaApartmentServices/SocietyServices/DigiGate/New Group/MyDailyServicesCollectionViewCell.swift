//
//  MyDailyServicesCollectionViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

protocol dataCollectionProtocolDailyService {
    func deleteData(indx: Int, cell: UICollectionViewCell)
}

class MyDailyServicesCollectionViewCell: UICollectionViewCell {
    
    var delegate : dataCollectionProtocolDailyService?
    var index : IndexPath?
    
    @IBOutlet weak var myDailyServicesImage: UIImageView!
    
    @IBOutlet weak var lbl_MyDailyServiceName: UILabel!
    @IBOutlet weak var lbl_MyDailyServiceType: UILabel!
    @IBOutlet weak var lbl_MyDailyServicesRating: UILabel!
    @IBOutlet weak var lbl_MyDailyServicesInTime: UILabel!
    @IBOutlet weak var lbl_MyDailyServicesFlats: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    //Created object to call button action in cell class
    var actionEdit : (() -> Void)? = nil
    var actionCall : (() -> Void)? = nil
    var actionMessage : (() -> Void)? = nil
    
    @IBAction func btnCancel(_ sender: UIButton) {
        delegate?.deleteData(indx: (index?.row)!, cell: self)
    }
    
    @IBAction func btnCall(_ sender: UIButton) {
        if let btnCallAction = self.actionCall {
            btnCallAction()
        }
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        if let btnEditAction = self.actionEdit {
            btnEditAction()
        }
    }
    
    @IBAction func btnMessage(_ sender: UIButton) {
        if let btnMessageAction = self.actionMessage {
            btnMessageAction()
        }
        
    }
}
