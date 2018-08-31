//
//  MyVehiclesCollectionViewCell.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyVehiclesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myVehicleImage: UIImageView!
    @IBOutlet weak var lbl_MyVehicleNumber: UILabel!
    @IBOutlet weak var lbl_MyVehicleOwner: UILabel!
    @IBOutlet weak var lbl_MyVehicleAddedOn: UILabel!
    
    @IBOutlet weak var lbl_VehicleNumber: UILabel!
    @IBOutlet weak var lbl_VehicleOwner: UILabel!
    @IBOutlet weak var lbl_VehicleAddedOn: UILabel!
    
    @IBOutlet weak var cardView: UIView!
}
