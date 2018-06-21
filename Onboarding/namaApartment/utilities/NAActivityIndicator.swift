//
//  NAActivityIndicator.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 21/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController   {
    
    func showActivityIndicator() {
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.center = self.view.center
        activityView.color = UIColor.black
        activityView.startAnimating()
        self.view.addSubview(activityView)
    }
    
    func hideActivityIndicator() {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
    }
}


