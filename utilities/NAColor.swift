//
//  globalColor.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAColor: NSObject
{
     func buttonFontColor() -> UIColor{
        return UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
    }
    
    func buttonBgColor() -> UIColor {
        return UIColor.black
    }
    
    
    //set btn bg,fontstyle,font,color programtically
    
   // btnLogin.backgroundColor = NAColor().buttonBgColor()
    
   // btnLogin.setTitleColor(NAColor().buttonFontColor(), for: .normal)
}
