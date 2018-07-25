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
                    })
                }
            }).resume()
        }
    
    func layoutFeatureUnavailable(mainView : UIViewController, newText : String) {
        
         //Created SubView Programatically
        let newSubView = UIView(frame: CGRect(x: 14, y: 50, width: 349, height: 255))
            newSubView.backgroundColor = UIColor.white
            mainView.view.addSubview(newSubView)
        
         //Created UILabel Programatically
        let newLabel = UILabel(frame: CGRect(x: 20, y: 170, width: 300, height: 70))
            newLabel.text = newText
            newLabel.numberOfLines = 3
            newLabel.textAlignment = NSTextAlignment.center
            newLabel.font = NAFont().layoutFeatureErrorFont()
            newLabel.textColor = UIColor.black
      
        //Created UIImageView Programatically
        var newImage : UIImageView
            newImage = UIImageView(frame: CGRect(x: (newSubView.frame.size.width/2)-80, y: 15, width: 150, height: 150))
            newImage.image = UIImage(named: "exclamation256")
            //Adding to SubView
            newSubView.addSubview(newImage)
            newSubView.addSubview(newLabel)
    }
}
