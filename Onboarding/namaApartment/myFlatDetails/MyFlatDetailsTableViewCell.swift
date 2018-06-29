//
//  MyFlatDetailsTableViewCell.swift
//  nammaApartment
//
//  Created by Sundir Talari on 29/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyFlatDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var list_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        list_Label.font = NAFont().descriptionFont()
    }
}
