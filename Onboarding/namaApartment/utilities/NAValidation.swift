//
//  NAValidation.swift
//  nammaApartment
//
//  Created by Sundir Talari on 14/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAValidation: NSObject {
    
    //shouldChangeCharacters mobile Length function
    func isValidMobileNumber(isNewMobileNoLength: Int) -> Bool{
        if (isNewMobileNoLength >= NAString().required_mobileNo_Length()) || (isNewMobileNoLength == NAString().zero_length()){
            return true
        }else{
            return false
        }
    }
}
