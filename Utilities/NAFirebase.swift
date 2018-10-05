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
    //Created Global function to get Profile image from firebase in Visitor List
    func downloadImageFromServerURL(urlString: String, imageView:UIImageView) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async(execute: { () -> Void in
                    imageView.image = image
                    
                    //Here Post the Value using NotificationCenter
                    NotificationCenter.default.post(name: Notification.Name("CallBack"), object: nil)
                })
            }
        }).resume()
    }
    
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
        
        //Stack View
        stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.equalCentering
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = CGFloat(NAString().fifteen())
        
        stackView.addArrangedSubview(newImage)
        stackView.addArrangedSubview(newLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.view.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: mainView.view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: mainView.view.topAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: mainView.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: mainView.view.trailingAnchor).isActive = true
        
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
}
