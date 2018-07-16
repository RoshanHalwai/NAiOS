//
//  EditMyProfileTableViewCell.swift
//  nammaApartment
//
//  Created by Sundir Talari on 01/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class EditMyProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_Family_Members_List: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_Family_Members_List.font = NAFont().descriptionFont()
    }

}
