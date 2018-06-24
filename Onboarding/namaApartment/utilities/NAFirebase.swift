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
    }
