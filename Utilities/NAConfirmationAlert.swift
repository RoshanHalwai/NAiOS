//
//  NAConfirmationAlert.swift
//  nammaApartment
//
//  Created by Sundir Talari on 14/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAConfirmationAlert: NSObject {
    
    func showConfirmationDialog(VC: UIViewController, Title: String, Message: String, CancelStyle: UIAlertActionStyle, OkStyle: UIAlertActionStyle, OK: ((UIAlertAction) -> Void)?, Cancel: ((UIAlertAction) -> Void)?, cancelActionTitle: String, okActionTitle: String) {
        let alert = UIAlertController(title: Title , message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelActionTitle, style: CancelStyle, handler: Cancel))
        alert.addAction(UIAlertAction(title: okActionTitle, style: OkStyle, handler: OK))
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 10
        VC.present(alert, animated: true)
    }
    
    func showNotificationDialog(VC : UIViewController, Title: String, Message: String, buttonTitle: String, OkStyle: UIAlertActionStyle, OK: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: OkStyle, handler: OK))
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 10
        VC.present(alert, animated: true)
    }
}
