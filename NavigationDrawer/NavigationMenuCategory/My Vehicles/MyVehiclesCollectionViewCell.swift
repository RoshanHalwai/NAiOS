//
//  MyVehiclesCollectionViewCell.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

protocol dataRemoveProtocol {
    func removeData(index: Int, cell: UICollectionViewCell)
}

class MyVehiclesCollectionViewCell: UICollectionViewCell {
    
    var delegate : dataRemoveProtocol?
    var index : IndexPath?
    
    @IBOutlet weak var myVehicleImage: UIImageView!
    @IBOutlet weak var lbl_MyVehicleNumber: UILabel!
    @IBOutlet weak var lbl_MyVehicleOwner: UILabel!
    @IBOutlet weak var lbl_MyVehicleAddedOn: UILabel!
    
    @IBOutlet weak var lbl_VehicleNumber: UILabel!
    @IBOutlet weak var lbl_VehicleOwner: UILabel!
    @IBOutlet weak var lbl_VehicleAddedOn: UILabel!
    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var btn_Remove: UIButton!
    
    var actionEdit : (() -> Void)? = nil
    
    @IBAction func btn_Edit_Action(_ sender: UIButton) {
        
        if let btnAction = self.actionEdit {
            btnAction()
        }
    }
    
    @IBAction func btn_Remove_Action(_ sender: UIButton) {
        delegate?.removeData(index: (index?.row)!, cell: self)
    }
}
