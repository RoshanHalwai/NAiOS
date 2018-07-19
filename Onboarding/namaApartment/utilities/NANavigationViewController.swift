//
//  NANavigationViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Foundation

class NANavigationViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackBarButton()
        configureInfoButton()
        //configureHistoryButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func configureInfoButton() {
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "information24"), for: .normal)
        infoButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    func configureBackBarButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "backBarButton"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func ConfigureNavBarTitle(title: String)
    {
        let name = UILabel()
        name.text = title
        name.textColor =  UIColor.white
        name.textAlignment = .center
        name.font = NAFont().viewTitleFont()
        navigationItem.titleView = name
    }
}
