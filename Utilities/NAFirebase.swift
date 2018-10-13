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
        
        //Get device width
        let width = mainView.view.bounds.width
        
        //Stack View
        let stackView = UIStackView(frame: CGRect(x: 10, y: 30, width: width - 20, height: 200))
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
}
