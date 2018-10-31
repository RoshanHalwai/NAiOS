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
        if (isNewMobileNoLength >= NAString().required_mobileNo_Length()){
            return true
        }else{
            return false
        }
    }
    
    //Email Validation Function
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let validEmail = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let emailTextInput = try NSRegularExpression(pattern: validEmail)
            let emailString = emailAddressString as NSString
            let results = emailTextInput.matches(in: emailAddressString, range: NSRange(location: 0, length: emailString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch {
            returnValue = false
        }
        return  returnValue
    }
}
