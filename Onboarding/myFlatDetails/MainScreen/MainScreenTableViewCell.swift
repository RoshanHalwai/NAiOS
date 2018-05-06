//
//  MainScreenTableViewCell.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    var NSModel:societyServicesModel!{
        didSet{
            cellTitle.text = NSModel.cellTitle
            cellImage.image = NSModel.cellImage
        }
    }
    
    var NAModel:apartmentServicesModel!{
        didSet{
            cellTitle.text = NAModel.cellTitle
            cellImage.image = NAModel.cellImage
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
