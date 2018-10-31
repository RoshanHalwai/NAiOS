//
//  NAFirebase.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 23/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAFirebase {
    
    var stackView : UIStackView!
    func layoutFeatureUnavailable(mainView : UIViewController, newText : String) {
        
        //Image View
        let newImage = UIImageView()
        newImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        newImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        newImage.image = UIImage(named: "exclamation256")
        
        //Text Label
        let newLabel = UILabel()
        newLabel.textColor = UIColor.black
        newLabel.numberOfLines = 3
        newLabel.font = NAFont().layoutFeatureErrorFont()
        newLabel.text  = newText
        newLabel.textAlignment = .center
        
        //Get device width
        let width = mainView.view.bounds.width
        
        //Stack View
        let stackView = UIStackView(frame: CGRect(x: 20, y: 30, width: width - 30, height: 200))
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.fill
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 5
        
        stackView.addArrangedSubview(newImage)
        stackView.addArrangedSubview(newLabel)
        
        mainView.view.addSubview(stackView)
        
        if newText.count == 0 {
            stackView.removeFromSuperview()
            newLabel.removeFromSuperview()
            newImage.removeFromSuperview()
        }
    }
    
    //Creating Method to hide Layout Unavailable Message
    func hideLayoutUnavailableMessage() {
        stackView?.isHidden = true
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
