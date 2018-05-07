//
//  ApartmentTableViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 03/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ApartmentTableViewCell: UITableViewCell
{
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellLabel.font = NAFont().headerFont()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
