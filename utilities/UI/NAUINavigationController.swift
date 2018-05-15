//
//  UINavigationController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 12/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAUINavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func backBarButton() {
        let image =  #imageLiteral(resourceName: "backk24").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}
