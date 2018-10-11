//
//  NeighboursCollectionViewCell.swift
//  nammaApartment
//
//  Created by Srilatha on 10/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class NeighboursCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myNeighboursImage: UIImageView!
    @IBOutlet weak var lbl_MyNeighbourName: UILabel!
    @IBOutlet weak var lbl_MyNeighbourApartment: UILabel!
    @IBOutlet weak var lbl_MyNeighbourFlat: UILabel!
    @IBOutlet weak var lbl_NeighbourName: UILabel!
    @IBOutlet weak var lbl_NeighbourApartment: UILabel!
    @IBOutlet weak var lbl_NeighbourFlat: UILabel!
    
    @IBOutlet weak var btn_Message: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var actionMessage : (() -> Void)? = nil
    
    @IBAction func btnMessage(_ sender: UIButton) {
        if let btnMessageAction = self.actionMessage {
            btnMessageAction()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.myNeighboursImage.layer.cornerRadius = self.myNeighboursImage.frame.size.width/2
        self.myNeighboursImage.layer.cornerRadius = self.myNeighboursImage.frame.size.height/2
        self.myNeighboursImage.clipsToBounds = true
    }
}
