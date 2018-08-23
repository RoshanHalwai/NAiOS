//
//  NAShodowEffect.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//For Creating Shadow Effect for Collection View Cell and UIView
class NAShadowEffect: NSObject {
    
    func shadowEffect(Cell: UICollectionViewCell) {
        Cell.contentView.layer.cornerRadius = 8.0
        Cell.contentView.layer.borderWidth = 1.0
        Cell.contentView.layer.borderColor = UIColor.clear.cgColor
        Cell.contentView.layer.masksToBounds = false
        Cell.layer.shadowColor = UIColor.gray.cgColor
        Cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        Cell.layer.shadowRadius = 4.0
        Cell.layer.shadowOpacity = 1.0
        Cell.layer.masksToBounds = false
        Cell.layer.shadowPath = UIBezierPath(roundedRect: Cell.bounds, cornerRadius: Cell.contentView.layer.cornerRadius).cgPath
    }
    
    func shadowEffectForView(view: UIView) {
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        view.layer.shadowRadius = 1.7
        view.layer.shadowOpacity = 0.45
    }
}
