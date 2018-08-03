//
//  SocietyHistoryCollectionViewCell.swift
//  nammaApartment
//
//  Created by kalpana on 8/3/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SocietyHistoryCollectionViewCell: UICollectionViewCell {
    
    //created object to use history button action in cell class
    var actionHistory : (() -> Void)? = nil
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Number: UILabel!
    @IBOutlet weak var lbl_Problem: UILabel!
    @IBOutlet weak var lbl_SlotTime: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cardView: UIView?

    @IBOutlet weak var lbl_ServiceName: UILabel!
    @IBOutlet weak var lbl_ServiceNumber: UILabel!
    @IBOutlet weak var lbl_ServiceProblem: UILabel!
    @IBOutlet weak var lbl_ServiceSlotTime: UILabel!
        
}

