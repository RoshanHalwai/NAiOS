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
    
    func shadowEffectForButton(button: UIButton) {
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 1.0
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
    }
    
    func shadowEffectForButton(label: UILabel) {
        label.layer.cornerRadius = 8.0
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.4
        label.layer.shadowPath = UIBezierPath(roundedRect: label.bounds, cornerRadius: label.layer.cornerRadius).cgPath
    }
}
