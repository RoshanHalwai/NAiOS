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
        let stackView = UIStackView()
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
        stackView.centerYAnchor.constraint(equalTo: mainView.view.centerYAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: mainView.view.topAnchor).isActive = true

        stackView.leadingAnchor.constraint(equalTo: mainView.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: mainView.view.trailingAnchor).isActive = true
        
        if newText.count == 0 {
            stackView.removeFromSuperview()
            newLabel.removeFromSuperview()
            newImage.removeFromSuperview()
        }
                
//        let newLabel = UILabel(frame: CGRect(x: 14, y: 170, width: 300, height: 70))
//        newLabel.text = newText
//        newLabel.numberOfLines = 3
//        newLabel.textAlignment = NSTextAlignment.center
//        newLabel.font = NAFont().layoutFeatureErrorFont()
//        newLabel.textColor = UIColor.black
        
//        //Third View
//        let thirdView               = UIImageView()
//        thirdView.backgroundColor   = UIColor.magentaColor()
//        thirdView.heightAnchor.constraintEqualToConstant(120.0).active = true
//        thirdView.widthAnchor.constraintEqualToConstant(120.0).active = true
//        thirdView.image = UIImage(named: "buttonFollowMagenta")
        
//        //Stack View
//        let stackView   = UIStackView()
//        stackView.axis  = UILayoutConstraintAxis.Vertical
//        stackView.distribution  = UIStackViewDistribution.EqualSpacing
//        stackView.alignment = UIStackViewAlignment.Center
//        stackView.spacing   = 16.0
        
//        stackView.addArrangedSubview(imageView)
//        stackView.addArrangedSubview(textLabel)
//        stackView.addArrangedSubview(thirdView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
//        self.view.addSubview(stackView)
        
//        //Constraints
//        stackView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
//        stackView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        
//        let newSubView = UIView(frame: CGRect(x: 14, y: 50, width: 349, height: 255))
//        newSubView.backgroundColor = UIColor.white
//        let newLabel = UILabel(frame: CGRect(x: 14, y: 170, width: 300, height: 70))
//        newLabel.text = newText
//        newLabel.numberOfLines = 3
//        newLabel.textAlignment = NSTextAlignment.center
//        newLabel.font = NAFont().layoutFeatureErrorFont()
//        newLabel.textColor = UIColor.black
//        let newImage = UIImageView(frame: CGRect(x: (newSubView.frame.size.width/2)-80, y: 15, width: 150, height: 150))
//        newImage.image = UIImage(named: "exclamation256")
//        mainView.view.addSubview(newSubView)
        
//        //Adding to SubView
//        newSubView.addSubview(newImage)
//        newSubView.addSubview(newLabel)
        
    }
}
