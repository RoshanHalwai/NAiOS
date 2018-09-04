//
//  MyGuardsCollectionViewCell.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyGuardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myGuardImage: UIImageView!
    @IBOutlet weak var lbl_MyGuardName: UILabel!
    @IBOutlet weak var lbl_MyGuardGateNo: UILabel!
    @IBOutlet weak var lbl_MyGuardStatus: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lbl_GuardName: UILabel!
    @IBOutlet weak var lbl_GuardGateNo: UILabel!
    @IBOutlet weak var lbl_GuardStatus: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}
