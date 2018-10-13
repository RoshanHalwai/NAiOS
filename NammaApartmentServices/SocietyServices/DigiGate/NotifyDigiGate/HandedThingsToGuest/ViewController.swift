//
//  ViewController.swift
//  nammaApartment
//
//  Created by kalpana on 10/12/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        label?.addConstraint(NSLayoutConstraint(item: self.view, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 10))
        
        label?.addConstraint(NSLayoutConstraint(item: self.view, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 10))
      }

    

}
