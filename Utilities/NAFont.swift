//
//  globalFont.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAFont: NSObject {
    
    func labelFont() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 22)!
    }
    
    func headerFont() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 18)!
    }
    
    func descriptionFont() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 14)!
    }
    
    func popupViewFont() -> UIFont {
        return UIFont(name: "Lato-Regular", size: 14)!
    }
    
    func textFieldFont() -> UIFont {
        return UIFont(name: "Lato-Regular", size: 18)!
    }
    
    func buttonFont() -> UIFont {
        return UIFont(name: "Lato-Light", size: 22)!
    }
    
    func CellLabelFont() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 26)!
    }
    
    func splashdescriptionFont() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 18)!
    }
    
    func viewTitleFont() -> UIFont {
        return UIFont(name: "Lato-Regular", size: 26)!
    }
    
    func layoutFeatureErrorFont() -> UIFont {
        return UIFont(name: "Lato-Italic", size: 18)!
    }
    
    func popUpButtonFont() -> UIFont {
        return UIFont(name: "Lato-Regular", size: 18)!
    }
    
    func cellButtonFont() -> UIFont {
        return UIFont(name: "Lato-BoldItalic", size: 14)!
    }
}
