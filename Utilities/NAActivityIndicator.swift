//
//  NAActivityIndicator.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 21/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAActivityIndicator  {
    
    static let shared = NAActivityIndicator()
    
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    func showActivityIndicator(view: UIViewController) {
        activityView.center = view.view.center
        activityView.color = UIColor.black
        activityView.startAnimating()
        view.view.addSubview(activityView)
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
    }
}

