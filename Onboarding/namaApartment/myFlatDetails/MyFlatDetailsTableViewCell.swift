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
        // Initialization code
        list_Label.font = NAFont().descriptionFont()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
