//
//  CustomButton.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 09/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class HourButton: UIButton {
    
    func setBackgroundColor() {
        if isSelected {
            backgroundColor = UIColor.red
        } else {
            backgroundColor = UIColor.white
        }
    }
    
    func configure() {
        layer.cornerRadius = 15.0
        layer.borderWidth = 1
        heightAnchor.constraint(equalToConstant: 39).isActive = true
    }
    
    func setTitle(text: String) {
        setTitle(text: text)
    }
    
}
